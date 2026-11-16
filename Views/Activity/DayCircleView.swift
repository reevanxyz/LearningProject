//
//  DayCircleStyle.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 16/11/2026.
//


import SwiftUI

/// How a day in the week strip looks.
enum DayCircleStyle {
    case learned   // orange tint, orange number
    case frozen    // blue tint, blue number
    case today     // solid orange, white number (today, not logged yet)
    case plain     // no background (future days and missed days)
}

struct DayCircleView: View {
    let number: Int
    let style: DayCircleStyle

    var body: some View {
        Text("\(number)")
            .font(.system(size: 22, weight: style == .today ? .semibold : .regular))
            .foregroundStyle(textColor)
            .frame(width: 44, height: 44)
            .background(backgroundColor, in: .circle)
    }

    private var textColor: Color {
        switch style {
        case .learned: AppColors.learnedOrange
        case .frozen: AppColors.freezeBlue
        case .today, .plain: AppColors.textPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .learned: AppColors.learnedTint
        case .frozen: AppColors.freezeTint
        case .today: AppColors.learnedOrange
        case .plain: Color.clear
        }
    }
}

#Preview {
    HStack(spacing: 8) {
        DayCircleView(number: 20, style: .learned)
        DayCircleView(number: 23, style: .frozen)
        DayCircleView(number: 24, style: .today)
        DayCircleView(number: 25, style: .plain)
    }
    .padding()
    .background(AppColors.background)
}
