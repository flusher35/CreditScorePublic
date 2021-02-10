//
//  ActivityIndicatorView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 01/02/2021.
//

import SwiftUI

public struct ActivityIndicatorView: UIViewRepresentable {

    private var style: UIActivityIndicatorView.Style

    public init(style: UIActivityIndicatorView.Style = .medium) {
        self.style = style
    }

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.startAnimating()
        return indicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) { }
}
