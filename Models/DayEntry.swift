//
//  DayEntry.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import Foundation

enum DayStatus: String, Codable {
    case learned
    case frozen
}

struct DayEntry: Codable {
    /// Midnight at the start of the day this entry belongs to.
    let date: Date
    var status: DayStatus
}
