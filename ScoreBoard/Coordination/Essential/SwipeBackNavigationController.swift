//
//  SwipeBackNavigationController.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import UIKit

final class SwipeBackNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension SwipeBackNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
        return viewControllers.count > 1
    }
}
