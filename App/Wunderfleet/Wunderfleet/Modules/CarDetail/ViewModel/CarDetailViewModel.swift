//
//  CarDetailViewModel.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift
import RxCocoa

final class CarDetailViewModel: BaseViewModel {
    
    // API
    let apiService: APIServiceProtocol
    let carId: Int
    
    // Handle navigation
    let dismissCarDetailView : BehaviorRelay<Bool?> = BehaviorRelay<Bool?>(value: nil)
    
    // Handle Cars data
    var carData: Observable<Result<Car>> {
        return _carData.asObservable().observe(on: MainScheduler.instance)
    }
    private let _carData = ReplaySubject<Result<Car>>.create(bufferSize: 1)
    var carsDetailResponse: PublishSubject<Car> = PublishSubject<Car>()
    var carAttributes: PublishSubject<[CarAttribute]> = PublishSubject<[CarAttribute]>()
    
    // Handle Rental
    var quickRentalData: Observable<Result<Reservation>> {
        return _quickRentalData.asObservable().observe(on: MainScheduler.instance)
    }
    private let _quickRentalData = ReplaySubject<Result<Reservation>>.create(bufferSize: 1)
    var quickRentalResponse: PublishSubject<Reservation> = PublishSubject<Reservation>()
    
    init(apiService: APIServiceProtocol, carId: Int) {
        self.apiService = apiService
        self.carId = carId
        
        super.init()
        
        self.subscribeData()
        self.getCar(cardId: carId)
    }
    
}

// MARK: Data Subscribers

extension CarDetailViewModel {
    
    // Subscribe main thread Car data and accept response
    private func subscribeData() {
        self.carData
            .subscribe(onNext: { [weak self] result in
                guard let wself = self else { return }
                switch result {
                case .success(let response):
                    wself.carsDetailResponse.onNext(response)
                    wself.carAttributes.onNext(response.attributes)
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
        
        // Subscribe main thread Rental data and accept response
        self.quickRentalData
            .subscribe(onNext: { [weak self] result in
                guard let wself = self else { return }
                switch result {
                case .success(let response):
                    wself.quickRentalResponse.onNext(response)
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: API Calls

extension CarDetailViewModel {
    
    private func getCar(cardId: Int) {
        // Subscribe Car Detail API call
        self.apiService.car(carId: cardId)
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe { [weak self] event in
                guard let wself = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        wself._carData.on(event)
                    case .failure(let error):
                        print(error)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func quickRental() {
        // Subscribe Rent Car API call
        self.apiService.quickRental(carId: self.carId)
            .observe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe { [weak self] event in
                guard let wself = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        wself._quickRentalData.on(event)
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
