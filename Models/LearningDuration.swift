//
//  LearningDuration.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import Foundation

enum LearningDuration: String, Codable, CaseIterable {
    case week
    case month
    case year

    /// Label shown on the duration chips.
    var title: String {
        switch self {
        case .week: "Week"
        case .month: "Month"
        case .year: "Year"
        }
    }

    /// Days that must be logged (learned or frozen) to complete the goal.
    var dayCount: Int {
        switch self {
        case .week: 7
        case .month: 30
        case .year: 365
        }
    }

    /// Freezes allowed for one goal of this duration.
    var freezeLimit: Int {
        switch self {
        case .week: 2
        case .month: 8
        case .year: 96
        }
    }
}