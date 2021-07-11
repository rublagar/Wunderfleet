//
//  String+Common.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

extension String {
    
    var localized: String {
      return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
}
