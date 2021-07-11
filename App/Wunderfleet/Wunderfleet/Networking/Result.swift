//
//  Result.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

enum Result <Value> {
    
    case success(value: Value)
    case failure(error: CallError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as CallError {
            self = .failure(error: error)
        } catch let error {
            print(error)
            self = .failure(error: CallError(status: .failed))
        }
    }
    
}
