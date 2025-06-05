//
//  ImageCacheTests.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//

import XCTest
@testable import RecipeApp
import UIKit

final class ImageCacheTests: XCTestCase {
    // MARK: Properties
    var imageCache: ImageCaching!

    // MARK: Lifecycle methods
    override func setUp() {
        super.setUp()
        
        imageCache = ImageCache(folderName: "TestFolder")
    }

    override func tearDown() {
        let tempDirectory = FileManager.default.temporaryDirectory.appendingPathComponent("TestFolder")
        try? FileManager.default.removeItem(at: tempDirectory)
        imageCache = nil
        super.tearDown()
    }

    // MARK: Test Cases
    func testSaveAndRetrieveImage() throws {
        let testImage = try XCTUnwrap(Helper.createTestImage())
        let key = "testImage.png"

        imageCache.save(image: testImage, forKey: key)
        let retrievedImage = imageCache.image(forKey: key)

        XCTAssertNotNil(retrievedImage, "testImage should exist")
        XCTAssertEqual(retrievedImage?.size, testImage.size)
    }

    func testImageNotFoundReturnsNil() {
        let result = imageCache.image(forKey: "blank.jpg")
        XCTAssertNil(result, "Image should not exist")
    }

    func testFilenameEncoding() throws {
        let url = try XCTUnwrap(URL(string: "https://example.com/image/1?id=123/"))
        let filename = imageCache.filename(forURL: url)
        
        XCTAssertEqual(filename?.contains("/"),false, "Filename should be encoded to avoid path separators")
        XCTAssertEqual(filename?.contains("?"), false, "Filename should not contain query parameters")
        XCTAssertNotEqual(filename?.count, 0, "Filename should not be empty")
    }
}
