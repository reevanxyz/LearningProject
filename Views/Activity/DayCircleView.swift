import SwiftUI

/// How a day circle looks. Used by the week strip and the calendar.
enum DayCircleStyle {
    case learned   // orange tint, orange number
    case frozen    // blue tint, blue number
    case today     // solid orange, white number (today, not logged yet)
    case plain     // no background (future days and missed days)
}

struct DayCircleView: View {
    let number: Int
    let style: DayCircleStyle
    var diameter: CGFloat = 44

    var body: some View {
        Text("\(number)")
            .font(.system(size: diameter / 2, weight: style == .today ? .semibold : .regular))
            .foregroundStyle(textColor)
            .frame(width: diameter, height: diameter)
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
        DayCircleView(number: 25, style: .plain, diameter: 38)
    }
    .padding()
    .background(AppColors.background)
}
