//
//  Haptic.swift
//  QuickMeal
//
//  Created by Kamil Zachara on 30/03/2025.
//

import UIKit

protocol Haptic {
    func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

extension Haptic {
    func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
