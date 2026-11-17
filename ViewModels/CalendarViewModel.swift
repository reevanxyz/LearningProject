//
//  CalendarCell.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 17/11/2026.
//


import Foundation
import Observation

/// One square of a month grid. A nil number is an empty cell before the 1st.
struct CalendarCell: Identifiable {
    let id: Int
    let number: Int?
    let style: DayCircleStyle
}

struct CalendarMonth: Identifiable {
    let id: Date          // first day of the month
    let title: String     // "March 2026"
    let cells: [CalendarCell]
}

@Observable
final class CalendarViewModel {
    private let store: LearningStore
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let now: Date

    init(store: LearningStore, calendar: Calendar = Calendar(identifier: .gregorian)) {
        self.store = store
        self.calendar = calendar
        self.now = .now

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = calendar
        formatter.dateFormat = "MMMM yyyy"
        self.monthFormatter = formatter
    }

    /// Every month from the earliest logged day up to the current month, oldest first.
    var months: [CalendarMonth] {
        let earliest = min(store.entries.map(\.date).min() ?? now, now)
        let lastMonthStart = monthStart(of: now)
        var cursor = monthStart(of: earliest)

        var result: [CalendarMonth] = []
        while cursor <= lastMonthStart {
            result.append(makeMonth(starting: cursor))
            guard let next = calendar.date(byAdding: .month, value: 1, to: cursor) else { break }
            cursor = next
        }
        return result
    }

    private func monthStart(of date: Date) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: date)) ?? date
    }

    private func makeMonth(starting start: Date) -> CalendarMonth {
        let days = calendar.range(of: .day, in: .month, for: start) ?? 1..<32
        let blanks = calendar.component(.weekday, from: start) - 1   // Sunday first

        var cells = (0..<blanks).map { CalendarCell(id: $0, number: nil, style: .plain) }
        for day in days {
            guard let date = calendar.date(byAdding: .day, value: day - 1, to: start) else { continue }
            cells.append(CalendarCell(id: cells.count, number: day, style: style(for: date)))
        }
        return CalendarMonth(id: start, title: monthFormatter.string(from: start), cells: cells)
    }

    private func style(for date: Date) -> DayCircleStyle {
        switch store.status(on: date) {
        case .learned:
            return .learned
        case .frozen:
            return .frozen
        case nil:
            let isToday = calendar.isDate(date, inSameDayAs: now)
            return (isToday && store.goalStatus(at: now) == .active) ? .today : .plain
        }
    }
}