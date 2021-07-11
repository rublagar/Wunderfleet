//
//  API.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift
import RxAlamofire
import Alamofire

final class API {
    
    static let shared: API = {
        let instance = API()
        return instance
    }()
    
    init() { }
    
    // MARK: Cars List Endpoint
    
    func cars() -> Observable<Result<[Car]>> {
        return API.arrayDataRequest(dataRequest: Manager.shared.dataRequestObservable(router: Router.cars)).map({ response -> Result<[Car]> in
            guard let response = response,
                  let carData = try? JSONSerialization.data(withJSONObject: response, options: []),
                  let carResponse = try? JSONDecoder().decode([Car].self, from: carData)
            else {
                return Result.failure(error: CallError(status: .serialization(error: response?.description)))
            }
            return Result.success(value: carResponse)
        })
    }
    
    // MARK: Car Detail Endpoint
    
    func car(carId: Int) -> Observable<Result<Car>> {
        return API.dataRequest(dataRequest: Manager.shared.dataRequestObservable(router: Router.car(carId: carId))).map({ response -> Result<Car> in
            guard let response = response,
                  let carData = try? JSONSerialization.data(withJSONObject: response, options: []),
                  let carResponse = try? JSONDecoder().decode(Car.self, from: carData)
            else {
                return Result.failure(error: CallError(status: .serialization(error: response?.description)))
            }
            return Result.success(value: carResponse)
        })
    }
    
    // MARK: QuickRental Endpoint
    
    func quickRental(carId: Int) -> Observable<Result<Reservation>> {
        return API.dataRequest(dataRequest: Manager.shared.dataRequestObservable(router: Router.quickRental(carId: carId))).map({ response -> Result<Reservation> in
            guard let response = response,
                  let reservationData = try? JSONSerialization.data(withJSONObject: response, options: []),
                  let carResponse = try? JSONDecoder().decode(Reservation.self, from: reservationData)
            else {
                return Result.failure(error: CallError(status: .serialization(error: response?.description)))
            }
            return Result.success(value: carResponse)
        })
    }
    
    // MARK: Data Requests
    
    // TODO: Improve Errors feedback
    private static func dataRequest(dataRequest: Observable<DataRequest>) -> Observable<[String:Any]?> {
        return Observable<[String: Any]?>.create({ (observer) -> Disposable in
            dataRequest.observe(on: MainScheduler.instance).subscribe({ dataRequestEvent in
                switch dataRequestEvent {
                case .next(let event):
                    event.responseJSON(completionHandler: { (dataResponse) in
                        switch dataResponse.result {
                        case .success(let data):
                            guard var json = data as? [String:Any] else {
                                observer.onNext(nil)
                                return
                            }
                            json.updateValue(dataResponse.response!.statusCode, forKey: "status")
                            guard dataResponse.response!.statusCode == 200 else {
                                observer.onNext(nil)
                                return
                            }
                            observer.onNext(json)
                        case .failure(_):
                            observer.onNext(nil)
                            observer.onCompleted()
                        }
                    })
                case .error(_):
                    observer.onNext(nil)
                    observer.onNext(nil)
                case .completed:
                    observer.onCompleted()
                }
            })
        })
    }
    
    // TODO: Improve Errors feedback
    private static func arrayDataRequest(dataRequest: Observable<DataRequest>) -> Observable<[[String:Any]]?> {
        return Observable<[[String: Any]]?>.create({ (observer) -> Disposable in
            dataRequest.observe(on: MainScheduler.instance).subscribe({ dataRequestEvent in
                switch dataRequestEvent {
                case .next(let event):
                    event.responseJSON(completionHandler: { (dataResponse) in
                        switch dataResponse.result {
                        case .success(let data):
                            guard let json = data as? [[String:Any]] else {
                                observer.onNext(nil)
                                return
                            }
                            observer.onNext(json)
                        case .failure(_):
                            observer.onCompleted()
                        }
                    })
                case .error(_):
                    observer.onNext(nil)
                case .completed:
                    observer.onCompleted()
                }
            })
        })
    }

}
