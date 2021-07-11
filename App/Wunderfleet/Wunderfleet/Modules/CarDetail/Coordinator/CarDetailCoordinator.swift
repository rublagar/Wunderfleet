//
//  File.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

final class CarDetailCoordinator: Coordinator {

    private let rootViewController: UIViewController
    private let carId: Int

    init(rootViewController: UIViewController, carId: Int) {
        self.rootViewController = rootViewController
        self.carId = carId
     }

    // MARK: Start Coordinator
    
    override func start() {
        let viewController = CarDetailViewController.initFromStoryboard(name: StoryBoards.CarDetail)

        let viewModel = CarDetailViewModel(cardId: self.carId)
        viewController.viewModel = viewModel
        
        // Subscribe view dismiss and handle coordinators
        viewModel.dismissCarDetailView
            .subscribe(onNext: { [weak self] dismiss in
            guard let wself = self else { return }
            guard let dismiss = dismiss, dismiss else { return }
            wself.removeCoordinator(wself)
        })
        .disposed(by: self.disposeBag)
        
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
    
}
