//
//  HomeM.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation
import UIKit

// MARK: HomeMProtocol
protocol HomeMProtocol: ProtocolM {
    func responseServicePokemons(pokemons: [Pokemon])
    func errorServiceAlert(msj: String)
}

@MainActor
final class HomeM {
    // MARK: - Constantes
    private let repository: PokemonRepository
    
    // MARK: - Variables
    weak var delegate: HomeMProtocol?
    
    private(set) var arrayPokemons: [Pokemon] = []
    private var offset = 0
    
    // MARK: - Inicializadores
    init(repository: PokemonRepository) {
        self.repository = repository
    }

    // MARK: - Llamadas a servicios
    /// Función que regresa la información a pintar en cada una de las celdas de Home
    func getPokemonsService() {
        Task {
            do {
                let newPokemons =
                    try await repository.fetchPokemons(
                        offset: offset
                    )
                arrayPokemons.append(contentsOf: newPokemons)
                offset += 20
                self.delegate?.responseServicePokemons(pokemons: arrayPokemons)
            } catch {
                self.delegate?.errorServiceAlert(msj: error.localizedDescription)
            }
        }
    }
}

