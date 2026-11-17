//
//  LearningGoalView.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 17/11/2026.
//


import SwiftUI

struct LearningGoalView: View {
    @State private var viewModel: GoalFormViewModel
    @Environment(\.dismiss) private var dismiss

    init(store: LearningStore) {
        // Prefill only when the current goal is still active. After a completed or
        // failed goal, this screen starts blank for a fresh goal.
        let goalToEdit = store.goalStatus() == .active ? store.goal : nil
        _viewModel = State(initialValue: GoalFormViewModel(store: store, goal: goalToEdit))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GoalFormFields(
                topic: $viewModel.topic,
                duration: $viewModel.duration
            )
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 36)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    if viewModel.confirm() {
                        dismiss()
                    }
                }
                .disabled(!viewModel.canSubmit)
            }
        }
        .alert("Update goal", isPresented: $viewModel.isShowingUpdateAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update") {
                viewModel.saveGoal()
                dismiss()
            }
        } message: {
            Text("If you update now, your streak will start over.")
        }
        .tint(AppColors.learnedOrange)
    }
}

#Preview {
    NavigationStack {
        LearningGoalView(store: LearningStore(defaults: UserDefaults(suiteName: "GoalPreview")!))
    }
}
