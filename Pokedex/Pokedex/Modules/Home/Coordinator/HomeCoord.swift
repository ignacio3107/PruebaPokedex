//
//  HomeCoord.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit


// MARK: - HomeCoord class
final class HomeCoord: NavigationBridge {
    weak private var mainController: UIViewController?
}

// MARK: - HomeCoord extension
extension HomeCoord: Coordinator {
    func createModule() -> UIViewController {
        let vc = ViewController.instantiate(destinoVC: Controllers.homeVC) as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.viewModel = HomeVM(view: vc, coordinator: self)
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
    
    func closeView() {
        self.mainController?.dismissOrPopViewController()
    }
    
    func goToCellAction(option: Pokemon, idStr: String) {
        print("Dirigirse al detalle de \(option.name)")
        let params: PokemonSelect = PokemonSelect(id: idStr, nameCapitalized: option.name.capitalized)
        let vc = self.create(.detailVC, obj: params)
        self.mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToFavoritos(){
        let vc = self.create(.favoritosVC)
        self.mainController?.navigationController?.pushViewController(vc, animated: true)
    }
}
