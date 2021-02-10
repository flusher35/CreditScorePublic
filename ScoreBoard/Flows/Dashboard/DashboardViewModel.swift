//
//  DashboardViewModel.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import Combine
import SwiftUI

class DashboardViewModel: ObservableObject {

    // MARK: - Internal computed properties
    var scoreAnimationIncrement: Int {
        return maxScore / 140
    }

    // MARK: - Internal stored properties
    @Published var progress: CGFloat = 0
    @Published var currentScore = 0
    @Published var maxScore = 0
    @Published var progressAnimationDuration: Double = 0
    @Published var isLoading = false
    @Published var isScoreDetailsVisible = false
    @Published var isModalPresented = false
    var modalType: DashboardModalType?
    let title = Strings.dashboardTitle
    let navigation = PassthroughSubject<MainCoordinatorRoute, Never>()

    // MARK: - Private stored properties
    private var cancellableBag = Set<AnyCancellable>()
    private let interactor: CreditReportInteracting
    private let modalFactory: DashboardViewModelModalFactoryProviding
    private let gradientPicker = GradientColorPicker(colors: CircleProgressViewConfig.defaultConfig.colors)

    // MARK: - Internal methods
    init(interactor: CreditReportInteracting = CreditReportInteractor(),
         modalFactory: DashboardViewModelModalFactoryProviding = DashboardViewModelModalFactory()) {
        self.interactor = interactor
        self.modalFactory = modalFactory
    }

    func viewDidAppear() {
        getScore()
    }

    // MARK: - Private methods
    private func getScore() {
        guard !isLoading else { return }
        isLoading = true
        interactor.getCreditReportInfo { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let creditReport): self?.scoreReceived(creditReport.creditReportInfo)
                case .failure(let error): self?.errorReceived(description: error.shortDescription)
                }
            }
        }
    }

    private func scoreReceived(_ info: CreditReportInfo) {
        isScoreDetailsVisible = true
        maxScore = info.maxScoreValue
        let oldScore = currentScore
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.currentScore = info.score
            self.progressAnimationDuration = Double(abs(oldScore - self.currentScore)) / Double(self.scoreAnimationIncrement) * Double(1) / 60
            self.progress = CGFloat(self.currentScore) / CGFloat(self.maxScore)
        }
    }

    private func errorReceived(description: String) {
        let viewModel = modalFactory.createErrorModalViewModel(text: description)
        viewModel.actionSubject
            .sink { [weak self] in
                self?.getScore()
                self?.isModalPresented = false
                self?.modalType = nil
            }
            .store(in: &cancellableBag)
        modalType = .error(viewModel)
        isModalPresented = true
    }
}

extension DashboardViewModel: ColorForNumberProvider {
    func getColor(for number: Int) -> UIColor {
        return gradientPicker.getUIColor(percentage: CGFloat(number) / CGFloat(maxScore)) ?? .black
    }
}
