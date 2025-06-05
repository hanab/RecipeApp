//
//  RecipeDetailCardView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

struct RecipeDetailCardView: View {
    // MARK: Properties
    var recipe: Recipe
    
    // MARK: body
    var body: some View {
        VStack(spacing: 16) {
            Text(recipe.name)
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            Text(recipe.cuisine)
                .font(.caption2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            if let source = recipe.sourceURL,
               let sourceURL = URL(string: source){
                Link("Click to View Full Recipe", destination: sourceURL)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .shadow(radius: 4)
        .padding(.horizontal)
        .offset(y: -60)
    }
}

#Preview {
    RecipeDetailCardView(recipe: Recipe.allRecipes[0])
}
