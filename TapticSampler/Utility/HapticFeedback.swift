//
//  HapticFeedback.swift
//  TapticSampler
//
//  Created by Keisuke Tatsumi on 2018/08/26.
//  Copyright © 2018年 Keisuke Tatsumi. All rights reserved.
//

import UIKit

enum HapticFeedback {

    case notification(UINotificationFeedbackType)
    case impact(UIImpactFeedbackStyle)
    case selection

    static func generate(_ feedback: HapticFeedback) {
        guard #available(iOS 10.0, *) else { return }

        let feedBackClosure: () -> Void
        switch feedback {
        case .notification(let notificationType):
            feedBackClosure = {
                let generator = UINotificationFeedbackGenerator()
                generator.prepare()
                generator.notificationOccurred(notificationType)
            }

        case .impact(let style):
            feedBackClosure = {
                let generator = UIImpactFeedbackGenerator(style: style)
                generator.prepare()
                generator.impactOccurred()
            }

        case .selection:
            feedBackClosure = {
                let generator = UISelectionFeedbackGenerator()
                generator.prepare()
                generator.selectionChanged()
            }
        }

        // Should be occurred on main thread.
        DispatchQueue.main.async {
            feedBackClosure()
        }
    }
}
