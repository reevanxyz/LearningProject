//
//  GoalFormViewModel.swift
//  MyApp
//
//  Created by Reevan Alsheheli on 15/11/2026.
//


import Foundation
import Observation

/// Drives the goal form. Used by Onboarding now and by the Learning Goal screen later.
@Observable
final class GoalFormViewModel {
    var topic: String
    var duration: LearningDuration

    private let store: LearningStore

    /// Pass an existing goal to prefill the form, or nothing for a blank form.
    init(store: LearningStore, goal: LearningGoal? = nil) {
        self.store = store
        topic = goal?.topic ?? ""
        duration = goal?.duration ?? .week
    }

    private var trimmedTopic: String {
        topic.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// The button is only enabled when there is a topic.
    var canSubmit: Bool {
        !trimmedTopic.isEmpty
    }

    func saveGoal() {
        guard canSubmit else { return }
        store.setGoal(topic: trimmedTopic, duration: duration)
    }
}