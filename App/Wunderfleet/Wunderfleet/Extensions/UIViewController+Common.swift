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
    
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   acceptTitle: String? = "ALERT_ACCEPT".localized,
                   cancelTitle: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: acceptTitle, style: .default, handler: nil))
        
        if let cancelTitle = cancelTitle {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))

        }
        self.present(alert, animated: true)
    }
    
    func hideLoader(hide: Bool = true) {
        hide ? PKHUD.sharedHUD.hide() : PKHUD.sharedHUD.show()
    }
    
}
