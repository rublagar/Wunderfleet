//
//  Reservation.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

struct Reservation: Codable {
    
    var reservationId: Int?
    var carId: Int?
    var cost: Int?
    var drivenDistance: Int?
    var licencePlate: String?
    var startAddress: String?
    var userId: Int?
    var isParkModeEnabled = false
    var damageDescription: String?
    var fuelCardPin: String?
    var endTime: Int?
    var startTime: Int?
    
    var reserved: Bool {
        get {
            return self.startTime != nil && self.endTime != nil
        }
    }
    
}
