//
//  Helper.swift
//  RecipeAppTests
//
//  Created by Hana on 6/2/25.
//
import Foundation
import UIKit

final class Helper {
    // MARK: Function for loading data from a json file
    static func loadJSON(named name: String) -> Data? {
        let bundle = Bundle(for: Helper.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("Missing file: \(name).json")
        }
        return try? Data(contentsOf: url)
    }

    // MARK: Function for creating test image
    static func createTestImage(size: CGSize = CGSize(width: 10, height: 10)) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        UIColor.blue.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
