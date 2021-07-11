//
//  CallError.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

enum CallStatus: Error {
    
    case success
    case failed
    case serialization(error: String?)
    case unknown
    
}

final class CallError {
    
    var message: String = String()
    var callStatus: CallStatus = .unknown
    
    init() { }
    
    init(message: String, callStatus: CallStatus = .unknown) {
        self.message = message
        self.callStatus = callStatus
    }
    
    convenience init(status: CallStatus) {
        switch status {
        case .success:
            self.init()
        case .failed:
            self.init(message: "GENERIC_ERROR".localized)
        case .serialization(let error):
            self.init(message: error ?? "SERIALIZATION_ERROR".localized)
        case .unknown:
            self.init(message: "UNKNOWN_ERROR".localized)
        }
    }
    
}
