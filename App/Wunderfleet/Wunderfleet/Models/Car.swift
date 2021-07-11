//
//  Car.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

struct Car: Codable {
    
    var carId: Int
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
    
    var imageURL: URL? {
        get {
            if let vehicleTypeImageUrl = self.vehicleTypeImageUrl {
                return URL(string: vehicleTypeImageUrl)
            }
            return nil
        }
    }
    
    // Unify all Car attributes
    var attributes: [CarAttribute] {
        var attributesArray: [CarAttribute] = []
        let mirror = Mirror(reflecting: self)
        for child in mirror.children  {
            guard child.label != Constants.CarTitle,
                  child.label != Constants.CarImage,
                  let title = child.label,
                  let carAttribute = self.formattedCarAttribute(title: title,
                                                                value: child.value)
            else {
                continue
            }
            attributesArray.append(carAttribute)
        }
        return attributesArray
    }
    
    private func formattedCarAttribute(title: String, value: Any) -> CarAttribute? {
        switch value {
        case is String:
            return CarAttribute(title: "\(title)", description: "\((value as? String)!)")
        case is Bool:
            return CarAttribute(title: "\(title)", description: "\((value as? Bool)!)")
        case is Int:
            return CarAttribute(title: "\(title)", description: "\((value as? Int)!)")
        case is Double:
            return CarAttribute(title: "\(title)", description: "\((value as? Double)!)")
        default:
            return nil
        }
    }
    
}

// MARK: Car Attribute
struct CarAttribute {
    
    var title: String?
    var description: String?
    
}

