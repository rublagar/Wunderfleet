//
//  UIViewController+Common.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import Foundation

import PKHUD

extension UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    static func initFromStoryboard(name: String = StoryBoards.Map) -> Self {
        let storyboard = UIStoryboard(name: name,
                                      bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
    func hideLoader(hide: Bool = true) {
        hide ? PKHUD.sharedHUD.hide() : PKHUD.sharedHUD.show()
    }
    
}
