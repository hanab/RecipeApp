//
//  MockImageLoader.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//
import Foundation
import UIKit
@testable import RecipeApp

final class MockImageLoader: ImageLoading {
    // MARK: Properties
    var result: Result<UIImage, Error>

    // MARK: init
    init(result: Result<UIImage, Error>) {
        self.result = result
    }

    // MARK: ImageLoading implementation
    func loadImage(from url: URL) async throws -> UIImage {
        try result.get()
    }
}
