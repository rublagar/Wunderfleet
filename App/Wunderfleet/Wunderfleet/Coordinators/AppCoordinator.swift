//
//  AppCoordinator.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

final class AppCoordinator: Coordinator {
    
    private let apiService: APIServiceProtocol
    private let window: UIWindow

    init(window: UIWindow, apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.window = window
    }

    // MARK: Start Coordinator
    
    override func start() {
        let mapCoordinator = MapCoordinator(window: window, apiService: self.apiService)
        self.addCoordinator(mapCoordinator)
        mapCoordinator.start()
    }
    
}
