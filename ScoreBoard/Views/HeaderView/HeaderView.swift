//
//  HeaderView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 02/02/2021.
//

import SwiftUI

struct HeaderView: View {

    let title: String

    var body: some View {
        ZStack(alignment: .center) {
            Color.black
            Text(title)
                .foregroundColor(.white)
                .lineLimit(1)
                .font(.system(size: 20, weight: .semibold))
        }
        .frame(height: 48)
    }
}
