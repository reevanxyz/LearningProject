//
//  WeekDayItem.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 16/11/2026.
//


import SwiftUI

/// Everything one column of the week strip needs to display.
struct WeekDayItem: Identifiable {
    let id: Int          // 0 = Sunday ... 6 = Saturday
    let letter: String   // "S", "M", "T" ...
    let number: Int      // day of the month
    let style: DayCircleStyle
}

struct WeekStripView: View {
    let days: [WeekDayItem]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(days) { day in
                VStack(spacing: 4) {
                    Text(day.letter)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                    DayCircleView(number: day.number, style: day.style)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
