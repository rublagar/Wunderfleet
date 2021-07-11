//
//  MockAPI.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import RxSwift

final class MockAPI: APIServiceProtocol {
    
    let car = Car(carId: 1, title: "Manfred", isClean: false, isDamaged: true, licencePlate: "FBL 081", fuelLevel: 27, vehicleStateId: 0, hardwareId: "HARDWARE", vehicleTypeId: 1, pricingTime: "0,22/km", pricingParking: "0,05/min", isActivatedByHardware: false, locationId: 2, address: "Bissenkamp 4", zipCode: "44135", city: "Dortmund", lat: 51.5156, lon: 7.4647, reservationState: 0, damageDescription: "Marius hat gesagt das muss so, und so, und so\r\nUnd wenn ich das verändere?", vehicleTypeImageUrl: "https://wunderfleet-recruiting-dev.s3.eu-central-1.amazonaws.com/images/vehicle_type_image.png")
    let reservation = Reservation(reservationId: 88, carId: 16, cost: 0, drivenDistance: 0, licencePlate: "Uhlandstraße 142", startAddress: "Uhlandstraße 142", userId: 12, isParkModeEnabled: false, damageDescription: "", fuelCardPin: "1234", endTime: 1404778918, startTime: 1404778018)
    
    func cars() -> Observable<Result<[Car]>> {
        return Observable.just(Result.success(value: [self.car]))
    }
    
    func car(carId: Int) -> Observable<Result<Car>> {
        return Observable.just(Result.success(value: self.car))
    }
    
    func quickRental(carId: Int) -> Observable<Result<Reservation>> {
        return Observable.just(Result.success(value: self.reservation))
    }
    
}
