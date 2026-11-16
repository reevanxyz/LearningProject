//
//  DurationChip.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import SwiftUI

struct DurationChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(isSelected ? AppColors.textPrimary : AppColors.textDisabled)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .glassEffect(
                    isSelected
                        ? .regular.tint(AppColors.learnedOrange).interactive()
                        : .regular.interactive(),
                    in: .capsule
                )
        }
        .buttonStyle(.plain)
    }
}