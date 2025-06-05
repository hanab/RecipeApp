//
//  YoutubeVideoIDExtractionTests.swift
//  RecipeAppTests
//
//  Created by Hana on 6/5/25.
//


import XCTest
import Foundation
@testable import RecipeApp

final class YoutubeVideoIDExtractionTests: XCTestCase {
    // MARK: Test Cases
    func testExtractVideoIDFromYoutubeDotComURLSuccess() {
        let videoURL =  "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        XCTAssertEqual(videoURL.youtubeVideoID(), "6R8ffRRJcrg")
    }
    
    func testExtractVideoIDFromYoutubeDotBeURLSuccess() {
        let videoURL =  "https://www.youtu.be/4vhcOwVBDO4"
        XCTAssertEqual(videoURL.youtubeVideoID(), "4vhcOwVBDO4")
    }
    
    func testExtractVideoIDFailure() {
        let videoURL =  "https://www.abc.com/4vhcOwVBDO4"
        XCTAssertNil(videoURL.youtubeVideoID())
    }
}
