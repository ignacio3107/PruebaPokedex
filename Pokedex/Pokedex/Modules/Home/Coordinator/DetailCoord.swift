//
//  DetailCoord.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit


// MARK: - DetailCoord class
final class DetailCoord: NavigationBridge {
    weak private var mainController: UIViewController?
    private var params: PokemonSelect
    
    init?(params: PokemonSelect) {
        if params.id.isEmpty {
            return nil
        }
        self.params = params
        
    }
}

// MARK: - DetailCoord extension
extension DetailCoord: Coordinator {
    func createModule() -> UIViewController {
        let vc = ViewController.instantiate(destinoVC: Controllers.detailVC) as! DetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.viewModel = DetailVM(view: vc, coordinator: self, params: params)
        self.mainController = vc
        return vc
    }
    
    func showLoading() {
        loader.show(on: self.mainController!)
    }
    
    func hideLoading() {
        loader.hide(on: self.mainController!)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: Constant.Alert.titleError,
                message: "\(message)",
                preferredStyle: .alert
            )
        let btnAceptar = UIAlertAction(title: Constant.Alert.btnAcept, style: .default) { _ in
                //...
            }
            alert.addAction(btnAceptar)
        self.mainController?.present(alert, animated: true)
    }
    
}
