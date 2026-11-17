//
//  CalendarView.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 17/11/2026.
//


import SwiftUI

struct CalendarView: View {
    @State private var viewModel: CalendarViewModel

    init(store: LearningStore) {
        _viewModel = State(initialValue: CalendarViewModel(store: store))
    }

    var body: some View {
        let months = viewModel.months

        ScrollView {
            VStack(spacing: 0) {
                ForEach(months) { month in
                    MonthView(month: month, showsDivider: month.id != months.last?.id)
                }
            }
            .padding(.top, 24)
        }
        .defaultScrollAnchor(.bottom)   // open at the current month
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// One month: title, SUN–SAT header and the grid of days.
private struct MonthView: View {
    let month: CalendarMonth
    let showsDivider: Bool

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    private let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(month.title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.horizontal, 20)
                .padding(.top, 14)

            HStack(spacing: 0) {
                ForEach(weekdays, id: \.self) { name in
                    Text(name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 11)
            .padding(.top, 12)

            LazyVGrid(columns: columns, spacing: 13) {
                ForEach(month.cells) { cell in
                    if let number = cell.number {
                        DayCircleView(number: number, style: cell.style, diameter: 38)
                    } else {
                        Color.clear.frame(height: 38)
                    }
                }
            }
            .padding(.horizontal, 11)
            .padding(.top, 6)
            .padding(.bottom, 12)

            if showsDivider {
                Rectangle()
                    .fill(AppColors.divider)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    let defaults = UserDefaults(suiteName: "CalendarPreview")!
    let _ = defaults.removePersistentDomain(forName: "CalendarPreview")
    let store = LearningStore(defaults: defaults)
    let start = Calendar.current.date(byAdding: .day, value: -40, to: .now)!
    let _ = store.setGoal(topic: "Swift", duration: .year, now: start)
    let _ = (0..<40).forEach { offset in
        let day = Calendar.current.date(byAdding: .day, value: offset, to: start)!
        if offset % 6 == 3 {
            store.freezeToday(now: day)
        } else {
            store.logLearned(now: day)
        }
    }
    NavigationStack { CalendarView(store: store) }
}