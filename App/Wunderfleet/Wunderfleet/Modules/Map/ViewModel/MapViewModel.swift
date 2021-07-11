//
//  MapViewModel.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift
import RxCocoa

final class MapViewModel: BaseViewModel {
    
    // Handle navigation to CarDetail
    let showCarDetail : BehaviorRelay<Car?> = BehaviorRelay<Car?>(value: nil)
    
    // Handle Cars data
    var carsData: Observable<Result<[Car]>> {
        return _carsData.asObservable().observe(on: MainScheduler.instance)
    }
    private let _carsData = ReplaySubject<Result<[Car]>>.create(bufferSize: 1)
    var carsDetailResponse: BehaviorRelay<[Car]?> = BehaviorRelay<[Car]?>(value: nil)
    
    override init() {
        super.init()

        self.subscribeData()
        self.getCars()
    }
    
}

// MARK: Data Subscribers

extension MapViewModel {
    
    // Subscribe main thread Cars data and accept response
    private func subscribeData() {
        self.carsData
            .subscribe(onNext: { [weak self] result in
                guard let wself = self else { return }
                switch result {
                case .success(let response):
                    wself.carsDetailResponse.accept(response)
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: API Calls

extension MapViewModel {
    
    // Subscribe Cars API call
    private func getCars() {
        API().cars()
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe { [weak self] event in
                guard let wself = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        wself._carsData.on(event)
                    case .failure(let error):
                        print(error)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
}
