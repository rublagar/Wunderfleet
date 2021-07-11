//
//  Constants.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

// MARK: Common Constants

struct Constants {
    
    // API Constants
    static let BASE_URL: String = "https://s3.eu-central-1.amazonaws.com/wunderfleet-recruiting-dev"
    static let QUICK_RENTAL_URL: String = "https://4i96gtjfia.execute-api.eu-central-1.amazonaws.com/default/wunderfleet-recruiting-mobile-dev-quick-rental"
    static let API_BEARER: [String:String] = ["Authorization":"Bearer df7c313b47b7ef87c64c0f5f5cebd6086bbb0fa"]
    static let CARS_PATH: String = "/cars.json"
    static let CAR_PATH: String = "/cars/"

    // Map Constants
    
    static let annotationId: String = "annotationId"
    static let latitude: Double = 51.515
    static let longitude: Double = 7.4651
    static let latitudinalMeters: Double = 1000
    static let longitudinalMeters: Double = 1000
    
}

// MARK: Assets

struct Assets {
    
    static let UserLocation: String = "UserLocation"
    static let WunderPOI: String = "POIWM"
    static let Arrow: String = "Arrow"

}

// MARK: Storyboards

struct StoryBoards {
    
    static let Map: String = "Map"

}

