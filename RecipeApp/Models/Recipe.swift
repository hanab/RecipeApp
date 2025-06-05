//
//  Recipe.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import Foundation

// MARK: - RecipeResponse
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable {
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String?
    let sourceURL: String?
    let id: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
}

// MARK: - Test Data
extension Recipe {
    static let allRecipes = [
        Recipe(cuisine: "Malaysian",
               name: "Apam Balik",
               photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
               photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
               sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
               id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
               youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(cuisine: "British",
               name: "Apple & Blackberry Crumble",
               photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
               photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
               sourceURL: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
               id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
               youtubeURL: "https://www.youtube.com/watch?v=4vhcOwVBDO4")
    ]
}
