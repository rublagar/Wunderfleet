//
//  Car.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

struct Car: Codable {
    
    var carId: Int?
    var title: String?
    var isClean: Bool?
    var isDamaged: Bool?
    var licencePlate: String?
    var fuelLevel: Int?
    var vehicleStateId: Int?
    var hardwareId: String?
    var vehicleTypeId: Int?
    var pricingTime: String?
    var pricingParking: String?
    var isActivatedByHardware: Bool?
    var locationId: Int?
    var address: String?
    var zipCode: String?
    var city: String?
    var lat: Double?
    var lon: Double?
    var reservationState: Int?
    var damageDescription: String?
    var vehicleTypeImageUrl: String?
    
}
