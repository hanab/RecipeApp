//
//  RecipeServiceTest.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//

import XCTest
import Foundation
@testable import RecipeApp

final class RecipeServiceTests: XCTestCase {
    //MARK: Properties
    var recipeSerivce: RecipeService!
    var session = MockURLSession()
    
    // MARK: Lifecycle methods
    override func setUp() {
        super.setUp()
        recipeSerivce = RecipeService(session: session)
    }
    
    // MARK: Tests Cases
    func testFetchRecipesWithValidData() async throws {
        let mockData = Helper.loadJSON(named: "Recipes")
        session.mockData = mockData
        let url = try XCTUnwrap(URL(string: "http://test.com"))
        let recipes = try await recipeSerivce.fetchRecipes(from: url)
        XCTAssertEqual(recipes.count, 63)
        XCTAssertEqual(recipes.first?.name, "Apam Balik")
        XCTAssertEqual(recipes.first?.cuisine, "Malaysian")
    }
    
    func testFetchRecipesWithMalformedData() async throws {
        let mockData = Helper.loadJSON(named: "MalformedRecipes")
        session.mockData = mockData
        let url = try XCTUnwrap(URL(string: "http://test.com"))
        
        do {
            _ = try await recipeSerivce.fetchRecipes(from: url)
            XCTFail("Expected to throw decodingError")
        } catch let error as RecipeError {
            XCTAssertEqual(error.localizedDescription, RecipeError.decodingError.localizedDescription)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchRecipesWithEmptyResponse() async throws {
        let mockData = Helper.loadJSON(named: "EmptyRecipes")
        session.mockData = mockData
        let url = try XCTUnwrap(URL(string: "http://test.com"))
        let recipes = try await recipeSerivce.fetchRecipes(from: url)
        XCTAssertEqual(recipes.count, 0)
    }
}
