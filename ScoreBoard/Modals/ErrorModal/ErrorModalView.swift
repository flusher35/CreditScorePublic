//
//  ErrorModal.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 02/02/2021.
//

import SwiftUI

struct ErrorModalView: View {

    @ObservedObject var viewModel: ErrorModalViewModel

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text(Strings.errorModalTitle)
                    .font(.system(size: 22, weight: .semibold))
                Text(viewModel.text)
                    .font(.system(size: 18))
                    .padding(.bottom, 8)
            }
            .foregroundColor(.black)
            .lineSpacing(5)
            .multilineTextAlignment(.center)
            Button(viewModel.retryButtonText) { viewModel.actionSubject.send() }
                .buttonStyle(CustomButtonStyle(config: .primary))
        }
    }
}
