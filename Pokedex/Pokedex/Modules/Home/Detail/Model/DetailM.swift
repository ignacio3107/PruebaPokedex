//
//  DetailM.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

// MARK: HomeMProtocol
protocol DetailMProtocol: ProtocolM {
//    func responseServicePokemonDetail(detail: PokemonDetail)
    func errorServiceAlert(msj: String)
    func responseFillInfo(arrayInfo: [InfoDetail])
}

@MainActor
final class DetailM {
    // MARK: - Constantes
    private let repository: PokemonRepository
    
    // MARK: - Variables
    weak var delegate: DetailMProtocol?
    var arrayInfoDetail: [InfoDetail] = []
    
    private(set) var detailService: PokemonDetail = PokemonDetail(id: 1, name: "Example", height: 5, weight: 60)
    var name = ""
    
    // MARK: - Inicializadores
    init(repository: PokemonRepository) {
        self.repository = repository
    }

    // MARK: - Llamadas a servicios
    /// Función que regresa la información a pintar en cada una de las celdas de Home
    func getPokemonDetailService(params: PokemonSelect) {
        self.fillOptionsDetail(params: params)
        //TODO: Obtener la data del detalle desde servicio
        
//        Task {
//            do {
//                let newDetail =
//                    try await repository.fetchPokemon(
//                    name:name
//                )
//                self.detailService = newDetail
//                self.fillOptionsDetail()
////                self.delegate?.responseServicePokemonDetail(detail: newDetail)
//            } catch {
//                self.delegate?.errorServiceAlert(msj: error.localizedDescription)
//            }
//        }
    }
    
    func fillOptionsDetail(params: PokemonSelect){
        self.arrayInfoDetail.removeAll()
        var optionCell: InfoDetail = InfoDetail(title: "Id", descript: params.id)
        self.arrayInfoDetail.append(optionCell)
        
        optionCell.title = "Name:"
        optionCell.descript = params.nameCapitalized
        self.arrayInfoDetail.append(optionCell)
        
        //FIXME: - Los datos de Height y Weight son los mismos para todos los Pokemones
        optionCell.title = "Height:"
        optionCell.descript = "\(detailService.height) kg"
        self.arrayInfoDetail.append(optionCell)
        
        optionCell.title = "Weight:"
        optionCell.descript = "\(detailService.weight) cm"
        self.arrayInfoDetail.append(optionCell)
        
        self.delegate?.responseFillInfo(arrayInfo: self.arrayInfoDetail)
    }
}
