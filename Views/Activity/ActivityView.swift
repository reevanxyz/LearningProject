import SwiftUI

struct ActivityView: View {
    private let store: LearningStore
    @State private var viewModel: ActivityViewModel
    @State private var isShowingGoalForm = false
    @State private var isShowingCalendar = false
    @Environment(\.scenePhase) private var scenePhase

    init(store: LearningStore) {
        self.store = store
        _viewModel = State(initialValue: ActivityViewModel(store: store))
    }

    var body: some View {
        VStack(spacing: 0) {
            header

            WeekStripView(days: viewModel.weekDays)
                .padding(.horizontal, 8)
                .padding(.top, 16)

            statCards
                .padding(.top, 12)

            content
        }
        .padding(.top, 4)
        .padding(.bottom, 11)
        .background(AppColors.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $isShowingGoalForm) {
            LearningGoalView(store: store)
        }
        .navigationDestination(isPresented: $isShowingCalendar) {
            CalendarView(store: store)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                viewModel.refresh()
            }
        }
    }
    // MARK: - Content below the stat cards

    @ViewBuilder
    private var content: some View {
        switch viewModel.goalStatus {
        case .active:
            VStack(spacing: 0) {
                Spacer()
                logLearnedButton
                Spacer()
                freezeSection
            }
        case .completed:
            resultContent(
                systemImage: "hands.sparkles.fill",
                title: "Well done!",
                subtitle: "Ready for your next goal?"
            )
        case .failed:
            resultContent(
                systemImage: "xmark.seal",
                title: "You didn't reach your goal this time.",
                subtitle: "Want to set another goal?"
            )
        }
    }

    private func resultContent(systemImage: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 0) {
            GoalResultView(systemImage: systemImage, title: title, subtitle: subtitle) {
                isShowingGoalForm = true
            }
            .padding(.top, 69)
            Spacer()
        }
    }
    // MARK: - Sections

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Text("Activity")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)
                Spacer()
                GlassIconButton(icon: Image(systemName: "calendar")) {
                    isShowingCalendar = true
                }
                GlassIconButton(icon: Image(systemName: "pencil.and.outline")) {
                    isShowingGoalForm = true
                    
                }
            }
            Text(viewModel.dateText)
                .font(.body)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }

    private var statCards: some View {
        HStack(spacing: 12) {
            StatCardView(
                systemImage: "flame.fill",
                iconColor: AppColors.learnedOrange,
                value: viewModel.learnedText,
                label: "Learned"
            )
            StatCardView(
                systemImage: "snowflake",
                iconColor: AppColors.freezeBlue,
                value: viewModel.frozenText,
                label: "Freezed"
            )
        }
        .padding(.horizontal, 16)
    }

    private var logLearnedButton: some View {
        Button {
            viewModel.logLearned()
        } label: {
            Text(viewModel.learnButtonTitle)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(viewModel.canLogLearned ? AppColors.textPrimary : AppColors.textDisabled)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.glassProminent)
        .buttonBorderShape(.circle)
        .tint(viewModel.canLogLearned ? AppColors.learnedOrange : AppColors.disabledFill)
        .disabled(!viewModel.canLogLearned)
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 60)
    }

    private var freezeSection: some View {
        VStack(spacing: 16) {
            Button {
                viewModel.freezeToday()
            } label: {
                Text(viewModel.freezeButtonTitle)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(viewModel.canFreeze ? AppColors.textPrimary : AppColors.textDisabled)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.glassProminent)
            .tint(viewModel.canFreeze ? AppColors.freezeBlue : AppColors.disabledFill)
            .controlSize(.large)
            .disabled(!viewModel.canFreeze)
            .padding(.horizontal, 60)

            Text(viewModel.freezeCaption)
                .font(.system(size: 14))
                .foregroundStyle(AppColors.textSecondary)
        }
    }
}

/// A store that saves into its own throwaway storage, so previews never touch real data.
private func makePreviewStore(_ suite: String) -> LearningStore {
    let defaults = UserDefaults(suiteName: suite)!
    defaults.removePersistentDomain(forName: suite)
    return LearningStore(defaults: defaults)
}

#Preview("Active") {
    let store = makePreviewStore("ActivityPreviewActive")
    let _ = store.setGoal(topic: "Swift", duration: .week)
    NavigationStack { ActivityView(store: store) }
}

#Preview("Completed") {
    let store = makePreviewStore("ActivityPreviewCompleted")
    let start = Calendar.current.date(byAdding: .day, value: -6, to: .now)!
    let _ = store.setGoal(topic: "Swift", duration: .week, now: start)
    let _ = (0..<7).forEach { offset in
        let day = Calendar.current.date(byAdding: .day, value: offset, to: start)!
        store.logLearned(now: day)
    }
    NavigationStack { ActivityView(store: store) }
}

#Preview("Failed") {
    let store = makePreviewStore("ActivityPreviewFailed")
    let start = Calendar.current.date(byAdding: .day, value: -3, to: .now)!
    let _ = store.setGoal(topic: "Swift", duration: .week, now: start)
    let _ = store.logLearned(now: start)
    let _ = store.freezeToday(now: Calendar.current.date(byAdding: .day, value: 1, to: start)!)
    NavigationStack { ActivityView(store: store) }
}
