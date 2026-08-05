//
//  FavoritosCoord.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 04/08/26.
//

import Foundation
import UIKit


// MARK: - FavoritosCoord class
final class FavoritosCoord: NavigationBridge {
    weak private var mainController: UIViewController?
   
    
}

// MARK: - FavoritosCoord extension
extension FavoritosCoord: Coordinator {
    func createModule() -> UIViewController {
        let vc = FavoritosVC()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
}
