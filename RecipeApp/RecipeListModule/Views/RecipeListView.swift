//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

struct RecipeListView: View {
    // MARK: Properites
    @StateObject private var viewModel = RecipeListViewModel()
    private let imageCache = ImageCache()
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                if viewModel.recipes.isEmpty && !viewModel.isLoading {
                    Text("No Recipes Available")
                            .font(.headline)
                            .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: viewModel.coloumns, spacing: 16) {
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe, cache: imageCache)
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchRecipies()
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await viewModel.fetchRecipies()
            }
        }
        .alert(isPresented: $viewModel.shouldShowAlert) {
            Alert(
                title: Text("Data Fetch Error"),
                message: Text(viewModel.error?.errorDescription ?? "")
            )
        }
    }
}

#Preview {
    RecipeListView()
}
