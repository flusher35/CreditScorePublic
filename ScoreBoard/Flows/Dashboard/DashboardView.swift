//
//  DashboardView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 30/01/2021.
//

import SwiftUI

struct DashboardView: View {

    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Color.black
                    .frame(height: proxy.safeAreaInsets.top)
                HeaderView(title: viewModel.title)
                circleProgressView
            }
            .edgesIgnoringSafeArea(.top)
        }
        .modal(isPresented: $viewModel.isModalPresented, canDismiss: false) { modalView }
    }

    private var circleProgressView: some View {
        ZStack {
            if viewModel.isLoading {
                ActivityIndicatorView(style: .large)
            }
            CircleProgressView(progress: viewModel.progress,
                               animationDuration: viewModel.progressAnimationDuration,
                               config: .defaultConfig)
                .scaleEffect(viewModel.isLoading || viewModel.isModalPresented ? 0 : 1)
                .animation(viewModel.isLoading ? nil : .easeOut(duration: 0.35))
            if viewModel.isScoreDetailsVisible {
                innerCircleView
            }
        }
        .animation(.linear(duration: 0.5))
        .padding(24)
        .onAppear(perform: viewModel.viewDidAppear)
    }

    private var innerCircleView: some View {
        VStack(spacing: 2) {
            Text(Strings.yourCreditScoreIs)
                .font(.system(size: 24, weight: .regular))
            CounterLabelView(number: viewModel.currentScore,
                             increment: viewModel.scoreAnimationIncrement,
                             colorProvider: viewModel)
                .font(.system(size: 76, weight: .ultraLight))
            Text(String(format: Strings.outOf, arguments: [String(viewModel.maxScore)]))
                .font(.system(size: 24, weight: .regular))
        }
    }

    @ViewBuilder private var modalView: some View {
        if viewModel.isModalPresented, let modalType = viewModel.modalType {
            switch modalType {
            case .error(let viewModel): ErrorModalView(viewModel: viewModel)
            }
        }
    }
}
