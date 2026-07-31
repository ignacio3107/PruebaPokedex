//
//  Endpoints.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation

enum APIEndpoint {
    static let baseURLImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/"
    
    static let baseURL = "https://pokeapi.co/api/v2"

    case pokemonList(limit: Int, offset: Int)
    case pokemon(name: String)

    var url: URL? {
        switch self {
        case .pokemonList(let limit, let offset):
            var components = URLComponents(string: "\(Self.baseURL)/pokemon")
            components?.queryItems = [
                .init(name: "limit", value: "\(limit)"),
                .init(name: "offset", value: "\(offset)")
            ]
            return components?.url

        case .pokemon(let name):
            return URL(string: "\(Self.baseURL)/pokemon/\(name)")
        }
    }
}
