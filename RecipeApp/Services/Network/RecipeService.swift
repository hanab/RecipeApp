//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(from url: URL) async throws -> [Recipe]
}

final class RecipeService: RecipeServiceProtocol {
    // MARK: Properties
    private let session: NetworkSessionProtocol

    // MARK: init
    init(session: NetworkSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: RecipeServiceProtocol implementation
    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw RecipeError.invlaidResponse
        }
        
        do {
            return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
        } catch {
            throw RecipeError.decodingError
        }
    }
}
