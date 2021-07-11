//
//  Manager.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import Alamofire
import RxAlamofire
import RxSwift

final class Manager {

    static let shared: Manager = {
        let instance = Manager()
        return instance
    }()
    
    let sessionManager: Session
    
    private init() {
        let config: URLSessionConfiguration = .default
        config.urlCache = nil
        config.timeoutIntervalForRequest = 120
        sessionManager = Alamofire.Session(configuration: config)
    }
    
    func dataRequestObservable(router: Router) -> Observable<DataRequest> {
        return self.sessionManager.rx.request(urlRequest: router)
    }
    
}
