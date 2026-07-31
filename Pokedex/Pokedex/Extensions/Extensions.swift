//
//  Extensions.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(destinoVC: Controllers) -> UIViewController
}

let loader = CustomLoader()

// MARK: - UIViewController
extension UIViewController: Storyboarded {
    static func instantiate(destinoVC: Controllers) -> UIViewController {
        let storyboard = UIStoryboard(name: destinoVC.rawValue, bundle: nil)
        return storyboard.instantiateViewController(identifier: destinoVC.rawValue)
    }
    
    /// Función que quita el controlador con pop o con dismiss, dependiendo si existe un NavigationController
    func dismissOrPopViewController() {
        if self.navigationController != nil {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

