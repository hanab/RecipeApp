//
//  ImageCache.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import Foundation
import UIKit

protocol ImageCaching {
    func image(forKey key: String) -> UIImage?
    func save(image: UIImage, forKey key: String)
    func filename(forURL url: URL) -> String?
}

final class ImageCache: ImageCaching {
    // MARK: Properties
    private let cacheDirectory: URL?
    
    // MARK: init
    init(folderName: String = "RecipeImageCache") {
        let folder = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        self.cacheDirectory = folder?.appendingPathComponent(folderName)
        guard let cacheDirectory = cacheDirectory else { return }
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    // MARK: ImageCaching implementation
    func image(forKey key: String) -> UIImage? {
        guard let cacheDirectory = cacheDirectory else { return nil }
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    func save(image: UIImage, forKey key: String) {
        guard let cacheDirectory = cacheDirectory else { return }
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        try? data.write(to: fileURL)
    }
    
    func filename(forURL url: URL) -> String? {
        url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
    }
}
