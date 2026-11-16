//
//  LearningStore.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import Foundation
import Observation

@Observable
final class LearningStore {

    // MARK: - Saved state

    private(set) var goal: LearningGoal?
    private(set) var entries: [DayEntry] = []
    private(set) var lastLoggedAt: Date?

    // MARK: - Private details

    private let defaults: UserDefaults
    private let calendar: Calendar
    private let saveKey = "learningStore.v1"
    private let streakTimeout: TimeInterval = 32 * 60 * 60   // 32 hours, in seconds

    init(defaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.defaults = defaults
        self.calendar = calendar
        load()
    }

    // MARK: - Read-only values

    /// Entries that belong to the current goal.
    private var goalEntries: [DayEntry] {
        guard let goal else { return [] }
        let start = calendar.startOfDay(for: goal.startDate)
        return entries.filter { $0.date >= start }
    }

    var learnedCount: Int {
        goalEntries.filter { $0.status == .learned }.count
    }

    var frozenCount: Int {
        goalEntries.filter { $0.status == .frozen }.count
    }

    var freezeLimit: Int {
        goal?.duration.freezeLimit ?? 0
    }

    /// The status of any day, or nil if nothing was logged. Also used by the week strip and calendar.
    func status(on date: Date) -> DayStatus? {
        let day = calendar.startOfDay(for: date)
        return entries.first { $0.date == day }?.status
    }

    /// With no goal this returns .active, so callers should check `goal` first.
    func goalStatus(at now: Date = .now) -> GoalStatus {
        guard let goal else { return .active }
        if goalEntries.count >= goal.duration.dayCount { return .completed }
        let reference = lastLoggedAt ?? goal.startDate
        return now.timeIntervalSince(reference) > streakTimeout ? .failed : .active
    }

    func canFreezeToday(at now: Date = .now) -> Bool {
        guard goal != nil, goalStatus(at: now) == .active else { return false }
        if status(on: now) == .frozen { return false }
        return frozenCount < freezeLimit
    }

    // MARK: - Actions

    /// Starts a brand-new goal. Past days stay in the history, but today starts clean.
    func setGoal(topic: String, duration: LearningDuration, now: Date = .now) {
        let today = calendar.startOfDay(for: now)
        entries.removeAll { $0.date >= today }
        goal = LearningGoal(topic: topic, duration: duration, startDate: now)
        lastLoggedAt = nil
        save()
    }

    /// Marks today as learned. If today was frozen, this switches it (and frees the freeze).
    func logLearned(now: Date = .now) {
        guard goalStatus(at: now) == .active else { return }
        if status(on: now) == .learned { return }
        setTodayStatus(.learned, now: now)
    }

    /// Marks today as frozen. If today was learned, this switches it.
    func freezeToday(now: Date = .now) {
        guard canFreezeToday(at: now) else { return }
        setTodayStatus(.frozen, now: now)
    }

    private func setTodayStatus(_ status: DayStatus, now: Date) {
        let today = calendar.startOfDay(for: now)
        if let index = entries.firstIndex(where: { $0.date == today }) {
            entries[index].status = status
        } else {
            entries.append(DayEntry(date: today, status: status))
        }
        lastLoggedAt = now
        save()
    }

    // MARK: - Saving and loading

    private func save() {
        let saved = SavedData(goal: goal, entries: entries, lastLoggedAt: lastLoggedAt)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        defaults.set(data, forKey: saveKey)
    }

    private func load() {
        guard let data = defaults.data(forKey: saveKey),
              let saved = try? JSONDecoder().decode(SavedData.self, from: data)
        else { return }
        goal = saved.goal
        entries = saved.entries
        lastLoggedAt = saved.lastLoggedAt
    }
}

/// Everything we save, bundled into one value so it can be encoded in one go.
private struct SavedData: Codable {
    var goal: LearningGoal?
    var entries: [DayEntry]
    var lastLoggedAt: Date?
}
