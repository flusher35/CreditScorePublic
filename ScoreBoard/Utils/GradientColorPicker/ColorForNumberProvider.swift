//
//  ColorForNumberProvider.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 01/02/2021.
//

import UIKit

protocol ColorForNumberProvider: AnyObject {
    func getColor(for number: Int) -> UIColor
}
