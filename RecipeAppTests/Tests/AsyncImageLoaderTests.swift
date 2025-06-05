//
//  AsyncImageLoaderTests.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//

import XCTest
import SwiftUI
@testable import RecipeApp

@MainActor
final class AsyncImageLoaderTests: XCTestCase {
    // MARK: Properties
    let testURL = URL(string: "https://abc.com/testImage.jpg")
    
    // MARK: Test Cases
    func testLoadImageFromCache() async throws {
        let expected = try XCTUnwrap(UIImage(systemName: "play.fill"))
        let cache = MockImageCache()
        cache.save(image: expected, forKey: "https://abc.com/testImage.jpg")
        let loader = AsyncImageLoader(
            url: testURL,
            cache: cache,
            loader: MockImageLoader(result: .failure(URLError(.badURL)))
        )

        await loader.loadTask?.value

        XCTAssertNotNil(loader.image)
        XCTAssertNil(loader.error)
    }

    func testLoadImageFromNetworkAndCache() async throws {
        let expected = try XCTUnwrap(UIImage(systemName: "star"))
        let cache = MockImageCache()
        let loader = AsyncImageLoader(
            url: testURL,
            cache: cache,
            loader: MockImageLoader(result: .success(expected))
        )

        await loader.loadTask?.value

        XCTAssertEqual(cache.storedImages[try XCTUnwrap(testURL).absoluteString]?.pngData(), expected.pngData())
        XCTAssertNotNil(loader.image)
    }

    func testLoadFailsWithError() async {
        let cache = MockImageCache()
        let loader = AsyncImageLoader(
            url: testURL,
            cache: cache,
            loader: MockImageLoader(result: .failure(URLError(.badServerResponse)))
        )

        await loader.loadTask?.value

        XCTAssertNil(loader.image)
        XCTAssertNotNil(loader.error)
    }
}
