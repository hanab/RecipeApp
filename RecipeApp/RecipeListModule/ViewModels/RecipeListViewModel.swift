//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {
    // MARK: properties
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: RecipeError?
    @Published var shouldShowAlert = false
    
    let coloumns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    private let recipeService: RecipeServiceProtocol
    
    // MARK: init
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = service
    }
    
    // MARK: Functions
    func fetchRecipies() async {
        isLoading = true
        guard let url =  URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            shouldShowAlert = true
            error = RecipeError.invalidURL
            return
        }
        
        do {
            let recipes = try await recipeService.fetchRecipes(from: url)
            self.recipes = recipes
            isLoading = false
        } catch(let error) {
            if let error = error as? RecipeError {
                self.error = error
            } else {
                self.error = RecipeError.custom(error: error)
            }
            shouldShowAlert = true
            isLoading = false
        }
    }
}
