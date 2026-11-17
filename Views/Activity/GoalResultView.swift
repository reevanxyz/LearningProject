//
//  GoalResultView.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 16/11/2026.
//


import SwiftUI

/// The message shown instead of the big circle when a goal is completed or failed.
struct GoalResultView: View {
    let systemImage: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: systemImage)
                .font(.system(size: 46))
                .foregroundStyle(AppColors.learnedOrange)

            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.top, 24)

            Text(subtitle)
                .font(.system(size: 15))
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, 4)

            Button(action: action) {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppColors.textPrimary)
            }
            .buttonStyle(.glassProminent)
            .tint(AppColors.learnedOrange)
            .controlSize(.large)
            .padding(.top, 72)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
    }
}
