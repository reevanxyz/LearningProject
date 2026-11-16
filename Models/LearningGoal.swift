//
//  LearningGoal.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import Foundation

struct LearningGoal: Codable {
    let topic: String
    let duration: LearningDuration
    /// When the goal was created. Starts the 32-hour clock until the first log.
    let startDate: Date
}

/// Where the current goal stands. Worked out on demand and never saved.
enum GoalStatus {
    case active
    case completed
    case failed
}