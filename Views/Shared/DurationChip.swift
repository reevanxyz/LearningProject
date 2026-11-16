import SwiftUI

struct DurationChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        // Two different button styles can't be chosen with a ternary, so we branch.
        if isSelected {
            chip
                .buttonStyle(.glassProminent)
                .tint(AppColors.learnedOrange)
        } else {
            chip
                .buttonStyle(.glass)
        }
    }

    private var chip: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textDisabled)
        }
        .controlSize(.large)
    }
}
