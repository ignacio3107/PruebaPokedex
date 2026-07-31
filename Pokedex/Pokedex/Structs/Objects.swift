//
//  Objects.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

// MARK: - Objetos Lista
struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonSelect {
    let id: String
    let nameCapitalized: String
}

// MARK: - Objetos detalle
struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}

struct InfoDetail {
    var title: String
    var descript: String
}
