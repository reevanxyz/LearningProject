//
//  GoalFormFields.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import SwiftUI

/// "I want to learn ___ in a Week / Month / Year". Shared by Onboarding and Learning Goal.
struct GoalFormFields: View {
    @Binding var topic: String
    @Binding var duration: LearningDuration

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("I want to learn")
                .font(.body)
                .foregroundStyle(AppColors.textPrimary)

            TextField(
                "Topic",
                text: $topic,
                prompt: Text("Swift").foregroundStyle(AppColors.textDisabled)
            )
            .font(.body)
            .foregroundStyle(AppColors.textPrimary)
            .padding(.top, 16)
            .padding(.bottom, 14)

            Rectangle()
                .fill(AppColors.divider)
                .frame(height: 1)

            Text("I want to learn it in a")
                .font(.body)
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 28)

            HStack(spacing: 11) {
                ForEach(LearningDuration.allCases, id: \.self) { option in
                    DurationChip(
                        title: option.title,
                        isSelected: duration == option
                    ) {
                        duration = option
                    }
                }
            }
            .padding(.top, 12)
        }
    }
}
