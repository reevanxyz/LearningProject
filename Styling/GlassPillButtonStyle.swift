//
//  GlassPillButtonStyle.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import SwiftUI

/// The pill-shaped glass button used across the app. Pass the color it should glow.
struct GlassPillButtonStyle: ButtonStyle {
    let tint: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(AppColors.textPrimary)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .glassEffect(.regular.tint(tint).interactive(), in: .capsule)
    }
}