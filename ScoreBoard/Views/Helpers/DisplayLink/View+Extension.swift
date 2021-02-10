//
//  OnFrame.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 30/01/2021.
//

import Combine
import SwiftUI

extension View {
    public func onFrame(isActive: Bool = true, displayLink: DisplayLink = .shared, _ action: @escaping (DisplayLink.Frame) -> Void) -> some View {
        let publisher = isActive ? displayLink.eraseToAnyPublisher() : Empty<DisplayLink.Frame, Never>().eraseToAnyPublisher()
        return SubscriptionView(content: self, publisher: publisher, action: action)
    }
}
