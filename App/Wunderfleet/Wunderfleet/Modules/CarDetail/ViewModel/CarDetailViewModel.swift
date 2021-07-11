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
    
    func dismiss() {
        self.dismissCarDetailView.accept(true)
    }
    
}

// MARK: Data Subscribers

extension CarDetailViewModel {
    
    // Subscribe main thread Car data and accept response
    private func subscribeData() {
        self.carData
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.carsDetailResponse.onNext(response)
                    self?.carAttributes.onNext(response.attributes)
                    self?.carsDetailResponse.onCompleted()
                case .failure(let error):
                    self?.carsDetailResponse.onError(error.callStatus)
                    self?.carsDetailResponse.onCompleted()
                }
            }, onError: { [weak self] error in
                self?.carsDetailResponse.onError(error)
                self?.carsDetailResponse.onCompleted()
            })
            .disposed(by: self.disposeBag)
        
        // Subscribe main thread Rental data and accept response
        self.quickRentalData
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let response):
                    self?.quickRentalResponse.onNext(response)
                case .failure(let error):
                    self?.quickRentalResponse.onError(error.callStatus)
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
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        self?._carData.on(event)
                    case .failure(let error):
                        self?._carData.onError(error.callStatus)
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
            .subscribe { [weak self] event in
                switch event {
                case .next(let result):
                    switch result {
                    case .success:
                        self?._quickRentalData.on(event)
                    case .failure(let error):
                        self?._quickRentalData.onError(error.callStatus)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
}
