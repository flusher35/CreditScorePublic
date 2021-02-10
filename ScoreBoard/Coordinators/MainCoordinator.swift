//
//  MainCoordinator.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import Combine
import UIKit

class MainCoordinator: BaseCoordinator {

    // MARK: - Internal methods
    override func start() {
        let viewModel = DashboardViewModel()
        viewModel.navigation
            .sink { [weak self] in self?.navigate($0) }
            .store(in: &cancellableBag)
        let viewController = CustomHostingController(rootView: DashboardView(viewModel: viewModel))
        navigationController.pushViewController(viewController, animated: false)
    }

    // MARK: - Private methods
    private func navigate(_ route: MainCoordinatorRoute) {
        switch route {
        case .showDetails: showDetails()
        }
    }

    private func showDetails() {
        //example of navigation
    }
}
