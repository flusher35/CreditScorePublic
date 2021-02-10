//
//  APISettings.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

protocol APISettingsProvider {
    var apiHost: String { get }
    var apiPath: String { get }
}

struct APISettings: APISettingsProvider {
    let apiHost = "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com"
    let apiPath = "/prod/mockcredit/values"
}
