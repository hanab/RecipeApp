//
//  MockURLSession.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//
import Foundation
@testable import RecipeApp

class MockURLSession: NetworkSessionProtocol {
    
    //MARK: Properties
    var mockData: Data?
    
    //MARK: NetworkSessionProtocol implementation
    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard let data = mockData else {
            throw URLError(.badURL)
        }
        
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
