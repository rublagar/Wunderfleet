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
    
    // API
    let apiService: APIServiceProtocol
    
    // Handle navigation to CarDetail
    let showCarDetail: PublishSubject<Car> = PublishSubject<Car>()
    
    // Handle Cars data
    var carsData: Observable<Result<[Car]>> {
        return _carsData.asObservable().observe(on: MainScheduler.instance)
    }
    private let _carsData = ReplaySubject<Result<[Car]>>.create(bufferSize: 1)
    var carsDetailResponse: PublishSubject<[Car]> = PublishSubject<[Car]>()
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
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
                case .success(let cars):
                    wself.carsDetailResponse.onNext(cars)
                    wself.carsDetailResponse.onCompleted()
                default:
                    break
                }
            }, onError: { [weak self] error in
                self?.carsDetailResponse.onError(error)
                self?.carsDetailResponse.onCompleted()
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: API Calls

extension MapViewModel {
    
    // Subscribe Cars API call
    private func getCars() {
        self.apiService.cars()
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe { [weak self] event in
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        self?._carsData.on(event)
                    case .failure(let error):
                        self?._carsData.onError(error.callStatus)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
}
