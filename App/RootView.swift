import SwiftUI

/// Decides which screen to show: Onboarding until a goal exists, then Activity.
struct RootView: View {
    @Environment(LearningStore.self) private var store

    var body: some View {
        if store.goal == nil {
            OnboardingView(store: store)
        } else {
            // TEMPORARY placeholder. We build the real ActivityView in Stage 4.
            Text("Activity (Stage 4)")
                .foregroundStyle(AppColors.textPrimary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.background.ignoresSafeArea())
        }
    }
}

#Preview {
    RootView()
        .environment(LearningStore())
}
