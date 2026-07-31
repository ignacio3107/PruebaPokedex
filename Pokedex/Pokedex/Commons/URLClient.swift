//
//  URLClient.swift
//  Pokedex
//
//  Created by Ignacio Hernández on 30/07/26.
//

import Foundation

// MARK: URLSession Abstraction
protocol HTTPClient {
    func request<T: Decodable>(
        endpoint: APIEndpoint
    ) async throws -> T
}

// MARK: - HTTPClient
/// Implementación con las siguientes acciones:
/// - Valida URL
/// - Valida HTTPResponse
/// - Valida statusCode
/// - Captura errores de Decoding
/// - Encapsula errores desconocidos
final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(
        endpoint: APIEndpoint
    ) async throws -> T {
        guard let url = endpoint.url else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard 200...299 ~= httpResponse.statusCode else {
                throw APIError.statusCode(httpResponse.statusCode)
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decoding(error)
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknown(error)
        }
    }
}
