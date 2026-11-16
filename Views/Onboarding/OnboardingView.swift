//
//  OnboardingView.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import SwiftUI

struct OnboardingView: View {
    @State private var viewModel: GoalFormViewModel

    init(store: LearningStore) {
        _viewModel = State(initialValue: GoalFormViewModel(store: store))
    }

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "flame.fill")
                .font(.system(size: 40))
                .foregroundStyle(AppColors.learnedOrange)
                .padding(.top, 60)

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("Hello")
                        .font(.system(size: 32, weight: .light))
                    Text("Learner")
                        .font(.system(size: 32, weight: .bold))
                }
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 84)

                Text("This app will help you learn everyday!")
                    .font(.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .padding(.top, 4)

                GoalFormFields(
                    topic: $viewModel.topic,
                    duration: $viewModel.duration
                )
                .padding(.top, 35)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            VStack(spacing: 12) {
                Button("Start Learning") {
                    viewModel.saveGoal()
                }
                .buttonStyle(GlassPillButtonStyle(tint: AppColors.learnedOrange))
                .disabled(!viewModel.canSubmit)
                .opacity(viewModel.canSubmit ? 1 : 0.4)

                Text("You can edit your goal later")
                    .font(.footnote)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(.horizontal, 16)
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    OnboardingView(store: LearningStore())
}