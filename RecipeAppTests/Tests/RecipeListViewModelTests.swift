//
//  RecipeListViewModelTests.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//

import XCTest
@testable import RecipeApp

@MainActor
final class RecipeListViewModelTests: XCTestCase {
    // MARK: Test Cases
    func testFetchRecipesWithValidJson() async {
        let data = Helper.loadJSON(named: "Recipes")
        let mockSession = MockURLSession()
        mockSession.mockData = data
        let service = RecipeService(session: mockSession)
        let viewModel = RecipeListViewModel(service: service)

        await viewModel.fetchRecipies()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.shouldShowAlert)
        XCTAssertEqual(viewModel.recipes.count, 63)
        XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik")
        XCTAssertEqual(viewModel.recipes.first?.cuisine, "Malaysian")
        XCTAssertEqual(viewModel.recipes.first?.id, "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        XCTAssertEqual(viewModel.recipes.first?.photoURLSmall, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        XCTAssertEqual(viewModel.recipes.first?.photoURLLarge, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        XCTAssertEqual(viewModel.recipes.first?.sourceURL, "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        XCTAssertEqual(viewModel.recipes.first?.youtubeURL, "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }

    func testFetchRecipesWithMalformedJson() async {
        let malformedData = Helper.loadJSON(named: "MalformedRecipes")
        let mockSession = MockURLSession()
        mockSession.mockData = malformedData
        let service = RecipeService(session: mockSession)
        let viewModel = RecipeListViewModel(service: service)

        await viewModel.fetchRecipies()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.shouldShowAlert)
    }
    
    func testFetchRecipesWithEmptyJson() async {
        let malformedData = Helper.loadJSON(named: "EmptyRecipes")
        let mockSession = MockURLSession()
        mockSession.mockData = malformedData
        let service = RecipeService(session: mockSession)
        let viewModel = RecipeListViewModel(service: service)

        await viewModel.fetchRecipies()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.shouldShowAlert)
    }
}
