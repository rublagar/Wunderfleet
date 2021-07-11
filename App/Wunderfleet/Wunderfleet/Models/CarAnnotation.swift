//
//  CarAnnotation.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation
import MapKit

final class CarAnnotation: MKPointAnnotation {

    var item: Car
    
    var carTitle: String {
        guard let title = self.item.title, !title.isEmpty else {
            return "No Name"
        }
        return title
    }

    required init(_ item: Car) {
        self.item = item

        super.init()
        
        if let latitude = item.lat, let longitude = item.lon {
            self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        }
    }

}
