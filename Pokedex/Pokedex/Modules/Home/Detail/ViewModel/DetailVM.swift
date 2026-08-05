//
//  DetailVM.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

// MARK: DetailProtocol
protocol DetailProtocol: AnyObject {
    func refreshTableView()
    func refreshImage(link: String)
    func refreshFav(exists: Bool)
}

// MARK: DetailVM class
class DetailVM {
    // MARK: - Params
    private let coordinator: DetailCoord!
    private unowned let vista: DetailVC
    private let model: DetailM
    private var params: PokemonSelect
    var namesFavs: [String] = []
    
    // MARK: - Implementation
    weak var delegate: DetailProtocol?
    
    // MARK: - Variables
    var arrayDetail: [InfoDetail] = []
    
    // MARK: - Initializers
    init(view: DetailVC, coordinator: DetailCoord, params: PokemonSelect) {
        self.params = params
        self.vista = view
        self.coordinator = coordinator
        self.model = DetailM(repository: PokemonRepositoryImpl(client: URLSessionHTTPClient()))
        self.model.delegate = self
        
        if let favs = UserDefaults.standard.stringArray(forKey: "Favoritos"){
            self.namesFavs = favs
            print(":::::::FAVORITOS ::::::")
            print(favs)
        }else {
            print("No hay datos guardados...")
        }
        
    }
    
    // MARK: - ::: Funciones :::
    /// Función que obtiene la información necesaria para mostrar en tabla
    func initInfo() {
        self.coordinator.showLoading()
        self.validateFav()
        self.model.getPokemonDetailService(params: self.params)
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    /// Función que retorna el numero de celdas a mostrar
    /// - Parameter tableView: tabla de referencia
    /// - Returns: Valor entero
    func getNumberOfRows(tableView: UITableView) -> Int {
        return self.arrayDetail.count
    }
    
    /// Función que retorna la celda correspondiente
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var obj: InfoDetail
        obj = self.arrayDetail[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.homeDetailTableViewCell.rawValue) as! HomeDetailTableViewCell
        cell.title.text = obj.title
        cell.descript.text = obj.descript
        
        if obj.title == "Id" {
            self.delegate?.refreshImage(link: APIEndpoint.baseURLImage + "\(obj.descript).png")
        }
        return cell
    }
    
    /// Función que define la acción personalizada al seleccionar una celda
    /// - Parameter tableView: tabla de referencia
    /// - Parameter indexPath: posición seleccionada
    func selectOption(tableView: UITableView, indexPath: IndexPath) {
        print("Celda sin acción...")
    }
    
    func selectToFav(){
        let resultado = namesFavs.filter { $0 == params.nameCapitalized }
        if resultado.isEmpty {
            self.namesFavs.append(params.nameCapitalized)
            self.delegate?.refreshFav(exists: true)
        }else {
            self.namesFavs.removeAll { $0 == params.nameCapitalized }
            self.delegate?.refreshFav(exists: false)
        }
        UserDefaults.standard.set(self.namesFavs, forKey: "Favoritos")
    }
    
    func validateFav(){
        let resultado = namesFavs.filter { $0 == params.nameCapitalized }
        if !resultado.isEmpty {
            self.delegate?.refreshFav(exists: true)
        }else {
            self.delegate?.refreshFav(exists: false)
        }
    }
}

// MARK: - HomeMProtocol
extension DetailVM: DetailMProtocol {
    func responseFillInfo(arrayInfo: [InfoDetail]) {
        self.coordinator.hideLoading()
        self.arrayDetail = arrayInfo
        delegate?.refreshTableView()
        
    }
    
//    func responseServicePokemonDetail(detail: [PokemonDetail]) {
//        self.arrayDetail = detail
//        self.coordinator.hideLoading()
//        delegate?.refreshTableView()
//    }
    
    func errorServiceAlert(msj: String) {
        self.coordinator.hideLoading()
        self.coordinator.showAlert(msj)
    }
}
