//
//  RepositoryServices.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

// MARK: - PokemonRepository Protocol
protocol PokemonRepository {
    func fetchPokemons(
        offset: Int
    ) async throws -> [Pokemon]

    func fetchPokemon(
        name: String
    ) async throws -> PokemonDetail
}


// MARK: - Implementation
final class PokemonRepositoryImpl: PokemonRepository {

    private let client: HTTPClient
    init(client: HTTPClient) {
        self.client = client
    }

    /// Función que obtien la lista de Pokemones
    func fetchPokemons(offset: Int) async throws -> [Pokemon] {
        let response: PokemonListResponse =
            try await client.request(
                endpoint: .pokemonList(
                    limit: 20,
                    offset: offset
                )
            )
        return response.results
    }

    // Función para buscar un pokemon por nombre
    func fetchPokemon(name: String) async throws -> PokemonDetail {
        try await client.request(
            endpoint: .pokemon(name: name)
        )
    }
}
