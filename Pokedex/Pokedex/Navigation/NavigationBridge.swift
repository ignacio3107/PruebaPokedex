//
//  NavigationBridge.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

@objcMembers public class NavigationBridge {
    // MARK: - Crear Controladores
    /// Función para crear módulos
    /// - Parameter vc: Controllers type enum
    /// - Returns: UIViewController
    func create(_ vc: Controllers, obj: Any? = nil) -> UIViewController {
        switch vc {
        // MARK: - Módulo Home
        case .homeVC:
            let coord = HomeCoord()
            return coord.createModule()
        case .detailVC:
            if let params = obj as? PokemonSelect, let coord = DetailCoord(params: params) {
                return coord.createModule()
            }
        case .favoritosVC:
            let coord = FavoritosCoord()
            return coord.createModule()
        default:
            if let _ = obj {
                return UIViewController()
            }
        }
        // En caso de que se pase el parametro obj y este sea nil, se presentará un controller vacío
        return UIViewController()
        }
}
