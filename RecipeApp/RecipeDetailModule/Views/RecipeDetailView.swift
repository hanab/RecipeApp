//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

struct RecipeDetailView: View {
    // MARK: Properties
    @Environment(\.dismiss) var dismiss
    var recipe: Recipe
    private let imageCache = ImageCache()
    @State private var isLoading = true
    
    // MARK: body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImageView(urlString: recipe.photoURLLarge ?? "",
                               cache: imageCache,
                               placeholder: {
                    AnyView(
                        ImagePlaceholderView(dimension: 100)
                    )
                })
                
                RecipeDetailCardView(recipe: recipe)
                
                VStack(spacing: 16) {
                    if let youtubeURL = recipe.youtubeURL {
                        Text("Watch Video")
                            .font(.headline)
                            .padding(.horizontal)
                        YoutubeVideoView(videoURL: youtubeURL)
                            .aspectRatio(16/9, contentMode: .fit)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.allRecipes[0])
}
