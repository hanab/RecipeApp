//
//  MockImageCache.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//

import XCTest
import UIKit
@testable import RecipeApp

final class MockImageCache: ImageCaching {
    // MARK: Properties
    var storedImages: [String: UIImage] = [:]

    // MARK: ImageCaching implementation
    func image(forKey key: String) -> UIImage? {
        storedImages[key]
    }

    func save(image: UIImage, forKey key: String) {
        storedImages[key] = image
    }

    func filename(forURL url: URL) -> String? {
        return url.absoluteString
    }
}
