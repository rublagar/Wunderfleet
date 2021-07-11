//
//  CarDetailsCell.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import UIKit

class CarDetailsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    static let identifier = "CarDetailsCell"
    
    var carAttribute: CarAttribute? {
        didSet {
            self.titleLabel.text = carAttribute?.title
            self.detailLabel.text = carAttribute?.description
        }
    }

}
