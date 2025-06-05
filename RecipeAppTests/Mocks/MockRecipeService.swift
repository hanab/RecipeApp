//
//  MockRecipeService.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//
import Foundation
@testable import RecipeApp

final class MockRecipeService: RecipeServiceProtocol {
    // MARK: Properties
    var shouldFail = false
    var mockData: [Recipe] = []

    // MARK: RecipeServiceProtocol implementation
    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        if shouldFail {
            throw RecipeError.decodingError
        }
        return mockData
    }
}
