//
//  StatCardView.swift
//  LearningProject
//
//  Created by Reevan Alsheheli on 16/11/2026.
//


import SwiftUI

/// The "4 days / Learned" and "0 days / Freezed" cards.
struct StatCardView: View {
    let systemImage: String
    let iconColor: Color
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemImage)
                .font(.system(size: 20))
                .foregroundStyle(iconColor)
            Text(value)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
            Text(label)
                .font(.system(size: 14))
                .foregroundStyle(AppColors.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .glassEffect(.regular, in: .rect(cornerRadius: 32))
    }
}
