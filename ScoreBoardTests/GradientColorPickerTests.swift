//
//  GradientColorPickerTests.swift
//  ScoreBoardTests
//
//  Created by Anton Shevtsov on 06/02/2021.
//

import XCTest

class GradientColorPickerTests: XCTestCase {

    let colors: [UIColor] = [.red , .green, .black]
    lazy var picker = GradientColorPicker(colors: colors)

    func testPickingFirstColor() {
        //given red color
        let expectedColor = colors[0]
        //when picking color from gradient at position
        let color = picker.getUIColor(percentage: 0)
        //then colors should match
        XCTAssertNotNil(color)
        XCTAssertTrue(color!.isCloselyEqual(to: expectedColor))
    }

    func testPickingMiddleColor() {
        //given green color
        let expectedColor = colors[1]
        //when picking color from gradient at position
        let color = picker.getUIColor(percentage: 0.5)
        //then colors should match
        XCTAssertNotNil(color)
        XCTAssertTrue(color!.isCloselyEqual(to: expectedColor), "color picked from gradient doesn't match")
    }

    func testPickingLastColor() {
        //given black color
        let expectedColor = colors[2]
        //when picking color from gradient at position
        let color = picker.getUIColor(percentage: 1)
        //then colors should match
        XCTAssertNotNil(color)
        XCTAssertTrue(color!.isCloselyEqual(to: expectedColor), "color picked from gradient doesn't match")
    }
}

private extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

    func isCloselyEqual(to color: UIColor) -> Bool {
        return rgba.red.rounded() == color.rgba.red.rounded() &&
            rgba.green.rounded() == color.rgba.green.rounded() &&
            rgba.blue.rounded() == color.rgba.blue.rounded()
    }
}
