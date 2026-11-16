import SwiftUI

struct ActivityView: View {
    @State private var viewModel: ActivityViewModel
    @Environment(\.scenePhase) private var scenePhase

    init(store: LearningStore) {
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

            Spacer()
            logLearnedButton
            Spacer()

            freezeSection
        }
        .padding(.top, 4)
        .padding(.bottom, 11)
        .background(AppColors.background.ignoresSafeArea())
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                viewModel.refresh()
            }
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
                // Actions are wired in later stages (Calendar: Stage 8, goal: Stage 7).
                GlassIconButton(icon: Image(systemName: "calendar")) { }
                GlassIconButton(icon: Image(systemName: "pencil.and.outline")) { }
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

#Preview {
    let defaults = UserDefaults(suiteName: "ActivityPreview")!
    let _ = defaults.removePersistentDomain(forName: "ActivityPreview")
    let store = LearningStore(defaults: defaults)
    let _ = store.setGoal(topic: "Swift", duration: .week)
    ActivityView(store: store)
}
