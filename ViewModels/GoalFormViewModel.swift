import Foundation
import Observation

/// Drives the goal form. Used by Onboarding and by the Learning Goal screen.
@Observable
final class GoalFormViewModel {
    var topic: String
    var duration: LearningDuration
    var isShowingUpdateAlert = false

    private let store: LearningStore
    /// Set only when editing a goal that is still active.
    private let originalGoal: LearningGoal?

    /// Pass the active goal to edit it, or nothing for a blank form.
    init(store: LearningStore, goal: LearningGoal? = nil) {
        self.store = store
        self.originalGoal = goal
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

    private var isEditing: Bool {
        originalGoal != nil
    }

    private var hasChanges: Bool {
        guard let originalGoal else { return true }
        return trimmedTopic != originalGoal.topic || duration != originalGoal.duration
    }

    /// Called when the checkmark is tapped. Returns true if the screen should close right away.
    func confirm() -> Bool {
        guard canSubmit else { return false }
        if !hasChanges { return true }          // nothing to save
        if isEditing {                          // changing an active goal restarts the streak, so ask first
            isShowingUpdateAlert = true
            return false
        }
        saveGoal()                              // a new goal after completed/failed: no warning needed
        return true
    }

    func saveGoal() {
        guard canSubmit else { return }
        store.setGoal(topic: trimmedTopic, duration: duration)
    }
}
