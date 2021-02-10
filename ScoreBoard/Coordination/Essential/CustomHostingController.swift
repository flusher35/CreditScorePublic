//
//  CustomHostingController.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import SwiftUI

class CustomHostingController<T: View>: UIHostingController<T> {

    override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    private let statusBarStyle: UIStatusBarStyle

    // MARK: - Internal methods
    init(rootView: T,
         statusBarStyle: UIStatusBarStyle = .lightContent) {
        self.statusBarStyle = statusBarStyle
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) { return nil }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
