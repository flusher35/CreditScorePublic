//
//  Coordinator.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    func start()
}
