//
//  ProtocolM.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

// MARK: Model main protocol
/// Protocolo general para llamadas a Servicios
@objc  protocol ProtocolM {
    // MARK: - Notificaciones Loading
    @objc optional func showLoading(msj: String)
    @objc optional func hideLoading()
    // MARK: Notificaciones Errores
    @objc optional func errorServiceAlert(msj: String)
    @objc optional func errorInternetConection()
}


// MARK: Coordinator main protocol
protocol Coordinator {
    func createModule() -> UIViewController
}
