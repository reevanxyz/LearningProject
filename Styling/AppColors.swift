//
//  AppColors.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import SwiftUI

// MARK: - Hex helper

extension Color {
    /// Creates a color from a hex number, e.g. Color(hex: 0xF58A25).
    init(hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

// MARK: - App colors

/// Every color used in the app, in one place.
/// Values are estimated from the design images, so adjust them here if needed.
enum AppColors {
    // Surfaces
    static let background = Color.black
    static let disabledFill = Color(hex: 0x1C1C1E)   // "Logged as Learned" circle
    
    static let divider = Color(hex: 0x2C2C2E)         // field underline

    // Brand colors
    static let learnedOrange = Color(hex: 0xF58A25)
    static let freezeBlue = Color(hex: 0x32C8F5)

    // Tinted circles (week strip and calendar days)
    static let learnedTint = learnedOrange.opacity(0.15)
    static let freezeTint = freezeBlue.opacity(0.15)

    // Text
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: 0x8E8E93)  // date, captions
    static let textDisabled = Color(hex: 0x4D4D50)   // "Logged as Learned", disabled pill
}

// MARK: - Preview (temporary check, not part of the app UI)

private struct SwatchRow: View {
    let name: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 44, height: 44)
            Text(name)
                .foregroundStyle(AppColors.textPrimary)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        SwatchRow(name: "learnedOrange", color: AppColors.learnedOrange)
        SwatchRow(name: "freezeBlue", color: AppColors.freezeBlue)
        SwatchRow(name: "learnedTint", color: AppColors.learnedTint)
        SwatchRow(name: "freezeTint", color: AppColors.freezeTint)
        SwatchRow(name: "disabledFill", color: AppColors.disabledFill)
        SwatchRow(name: "textSecondary", color: AppColors.textSecondary)
        SwatchRow(name: "textDisabled", color: AppColors.textDisabled)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    .background(AppColors.background)
}
