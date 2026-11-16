import SwiftUI

/// A round glass icon button, using the built-in glass button style.
struct GlassIconButton: View {
    let icon: Image
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            icon
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(AppColors.textPrimary)
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .controlSize(.large)
    }
}
