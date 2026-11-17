import SwiftUI

/// Decides which screen to show: Onboarding until a goal exists, then Activity.
struct RootView: View {
    @Environment(LearningStore.self) private var store

    var body: some View {
        if store.goal == nil {
            OnboardingView(store: store)
        } else {
            NavigationStack {
                ActivityView(store: store)
            }
        }
    }
}

#Preview {
    RootView()
        .environment(LearningStore())
}
