import Foundation
import Observation

@Observable
final class ActivityViewModel {
    private let store: LearningStore
    private let calendar: Calendar
    private let dateFormatter: DateFormatter

    /// The time the screen is showing. Refreshed when the app comes to the foreground and on every tap.
    private var now: Date

    private static let weekdayLetters = ["S", "M", "T", "W", "T", "F", "S"]

    init(store: LearningStore, calendar: Calendar = Calendar(identifier: .gregorian)) {
        self.store = store
        self.calendar = calendar
        self.now = .now

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = calendar
        formatter.dateFormat = "EEEE, d MMMM"
        self.dateFormatter = formatter
    }

    // MARK: - Header and week strip

    var dateText: String {
        dateFormatter.string(from: now)
    }

    /// The seven days of the current week, Sunday first.
    var weekDays: [WeekDayItem] {
        let today = calendar.startOfDay(for: now)
        let weekday = calendar.component(.weekday, from: today)   // 1 = Sunday
        guard let sunday = calendar.date(byAdding: .day, value: 1 - weekday, to: today) else {
            return []
        }
        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: sunday) else {
                return nil
            }
            return WeekDayItem(
                id: offset,
                letter: ActivityViewModel.weekdayLetters[offset],
                number: calendar.component(.day, from: date),
                style: style(for: date)
            )
        }
    }

    private func style(for date: Date) -> DayCircleStyle {
        switch store.status(on: date) {
        case .learned:
            return .learned
        case .frozen:
            return .frozen
        case nil:
            return calendar.isDate(date, inSameDayAs: now) ? .today : .plain
        }
    }

    // MARK: - Stat cards and caption

    var learnedText: String { dayCountText(store.learnedCount) }
    var frozenText: String { dayCountText(store.frozenCount) }

    var freezeCaption: String {
        "\(store.frozenCount) out of \(store.freezeLimit) Freezes used"
    }

    private func dayCountText(_ count: Int) -> String {
        count == 1 ? "1 day" : "\(count) days"
    }

    // MARK: - Buttons

    private var todayStatus: DayStatus? {
        store.status(on: now)
    }

    var canLogLearned: Bool { todayStatus != .learned }
    var learnButtonTitle: String { canLogLearned ? "Log as Learned" : "Logged as Learned" }

    var canFreeze: Bool { store.canFreezeToday(at: now) }
    var freezeButtonTitle: String { todayStatus == .frozen ? "Freezed for a day" : "Freeze for a day" }

    // MARK: - Actions

    func refresh() {
        now = .now
    }

    func logLearned() {
        refresh()
        store.logLearned(now: now)
    }

    func freezeToday() {
        refresh()
        store.freezeToday(now: now)
    }
}
