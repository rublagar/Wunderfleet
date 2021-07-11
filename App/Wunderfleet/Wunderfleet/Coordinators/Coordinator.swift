//
//  Coordinator.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

class Coordinator: NSObject {
    
    let disposeBag = DisposeBag()
    var coordinators = [Coordinator]()
    
    func addCoordinator(_ coordinator: Coordinator) {
        self.coordinators.append(coordinator)
    }
    
    func removeCoordinator(_ coordinator: Coordinator) {
        self.coordinators = coordinators.filter { $0 !== coordinator }
    }
    
    func removeAllCoordinators() {
        self.coordinators.forEach { coordinator in
            coordinator.removeAllCoordinators()
        }
        self.coordinators.removeAll()
    }
    
    func start() { }
    
}

