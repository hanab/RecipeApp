//
//  RecipeCardView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

struct RecipeCardView: View {
    // MARK: Properties
    var recipe: Recipe
    let cache: ImageCaching
    
    // MARK: body
    var body: some View {
        VStack(spacing: 6) {
            AsyncImageView(urlString: recipe.photoURLSmall ?? "",
                           cache: cache,
                           placeholder: {
                AnyView (
                    ImagePlaceholderView(dimension: 40)
                )
            })
            Text(recipe.name)
                .font(.caption)
                .foregroundColor(.black)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            Text(recipe.cuisine)
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
        }
        .frame(width: 160, height: 210, alignment: .top)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.3), radius: 25, x: 0, y: 10)
    }
}

#Preview {
    RecipeCardView(recipe: Recipe.allRecipes[0], cache: ImageCache())
}
