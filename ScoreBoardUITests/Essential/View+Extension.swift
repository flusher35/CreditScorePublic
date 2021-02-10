//
//  View+Extension.swift
//  ScoreBoardUITests
//
//  Created by Anton Shevtsov on 09/02/2021.
//

import SnapshotTesting
import SwiftUI

extension View {
    func test(size: CGSize,
              named name: String? = nil,
              record recording: Bool = false,
              timeout: TimeInterval = 5,
              file: StaticString = #file,
              testName: String = #function,
              line: UInt = #line) {
        assertSnapshot(matching: self.frame(width: size.width, height: size.height),
                       as: .image(size: size),
                       named: name,
                       record: recording,
                       timeout: timeout,
                       file: file,
                       testName: testName,
                       line: line)
    }
}
