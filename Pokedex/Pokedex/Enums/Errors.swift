//
//  Errors.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
    case unknown(Error)

    var errorDescription: String? {

        switch self {
        case .invalidURL:
            return "URL inválida"
        case .requestFailed:
            return "No fue posible realizar la petición"
        case .invalidResponse:
            return "Respuesta inválida"
        case .statusCode(let code):
            return "Código HTTP \(code)"
        case .decoding:
            return "No fue posible decodificar la respuesta"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
