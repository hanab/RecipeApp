//
//  URLSession+Data.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import Foundation

//MARK: Urlsession extension and protocol used for testing
protocol NetworkSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSessionProtocol { }

