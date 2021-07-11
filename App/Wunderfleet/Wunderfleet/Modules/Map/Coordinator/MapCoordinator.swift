//
//  MapCoordinator.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

final class MapCoordinator: Coordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: Start Coordinator
    
    override func start() {
        let viewController = MapViewController.initFromStoryboard(name: StoryBoards.Map)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = MapViewModel()
        viewController.viewModel = viewModel
        
        
        viewModel.showCarDetail
            .subscribe(onNext: { [weak self] car in
                // TODO: Show car details
        })
        .disposed(by: self.disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

