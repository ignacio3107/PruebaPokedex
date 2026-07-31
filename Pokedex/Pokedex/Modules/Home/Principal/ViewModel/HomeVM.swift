//
//  HomeVM.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

// MARK: HomeProtocol
protocol HomeProtocol: AnyObject {
    func refreshTableView()
}

// MARK: HomeVM class
class HomeVM {
    // MARK: - Params
    private let coordinator: HomeCoord!
    private unowned let vista: HomeVC
    private let model: HomeM
    
    // MARK: - Implementation
    weak var delegate: HomeProtocol?
    
    // MARK: - Variables
    var arrayPokemons: [Pokemon] = []
    
    // MARK: - Initializers
    init(view: HomeVC, coordinator: HomeCoord) {
        self.vista = view
        self.coordinator = coordinator
        self.model = HomeM(repository: PokemonRepositoryImpl(client: URLSessionHTTPClient()))
//        self.model.delegateGral = self
        self.model.delegate = self
    }
    
    // MARK: - ::: Funciones :::
    /// Función que obtiene la información necesaria para mostrar en tabla
    func initInfo() {
        self.coordinator.showLoading()
        self.model.getPokemonsService()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    /// Función que retorna el numero de celdas a mostrar
    /// - Parameter tableView: tabla de referencia
    /// - Returns: Valor entero
    func getNumberOfRows(tableView: UITableView) -> Int {
        return self.arrayPokemons.count
    }
    
    /// Función que retorna la celda correspondiente
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var obj: Pokemon
        obj = self.arrayPokemons[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Celdas.pokemonTableViewCell.rawValue) as! PokemonTableViewCell
        cell.name.text = obj.name.capitalized
        
        var id: Int {
            Int(obj.url.split(separator: "/").last(where: { !$0.isEmpty })!)!
        }
        cell.id.text = "\(id)"
        cell.icon.load(link: APIEndpoint.baseURLImage + "\(id).png")
        return cell
        
    }
    
    /// Función que define la acción personalizada al seleccionar una celda
    /// - Parameter tableView: tabla de referencia
    /// - Parameter indexPath: posición seleccionada
    func selectOption(tableView: UITableView, indexPath: IndexPath) {
        var optionSelect: Pokemon
        optionSelect = self.arrayPokemons[indexPath.row]
        print("Seleccionaste: \(optionSelect.name)")
        
        self.coordinator.goToCellAction(option: optionSelect, idStr: "\(indexPath.row + 1)")
    }
    
    func willDisplay(tableView: UITableView, indexPath: IndexPath) {
        let lastElement = self.arrayPokemons.count - 1
        if indexPath.row == lastElement {
            self.initInfo()
           }
    }
}

// MARK: - HomeMProtocol
extension HomeVM: HomeMProtocol {
    func responseServicePokemons(pokemons: [Pokemon]) {
        self.arrayPokemons = pokemons
        self.coordinator.hideLoading()
        delegate?.refreshTableView()
    }
    
    func errorServiceAlert(msj: String) {
        self.coordinator.hideLoading()
        self.coordinator.showAlert(msj)
    }
}
