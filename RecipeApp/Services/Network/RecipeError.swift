//
//  RecipeError.swift
//  RecipeApp
//
//  Created by Hana on 6/5/25.
//

import Foundation

enum RecipeError: Error{
    case invalidURL
    case invlaidResponse
    case decodingError
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self{
        case .invalidURL:
            return "The URL is not valid"
        case .decodingError:
            return "Data decoded has failed"
        case .invlaidResponse:
            return "Invalid response found"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
