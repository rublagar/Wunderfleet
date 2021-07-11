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
                guard let wself = self else { return }
                guard let car = car else { return }
                wself.showDetail(car: car, rootViewController: navigationController)
        })
        .disposed(by: self.disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    // Start the Car Detail coordinator
    private func showDetail(car: Car, rootViewController: UIViewController) {
        guard let carId = car.carId else {
            return
        }
        let carDetailCoordinator = CarDetailCoordinator(rootViewController: rootViewController, carId: carId)
        self.addCoordinator(carDetailCoordinator)
        carDetailCoordinator.start()
    }
    
}

