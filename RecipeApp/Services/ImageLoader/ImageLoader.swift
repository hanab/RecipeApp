//
//  ImageLoader.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import UIKit
import SwiftUI

protocol ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage
}

struct NetworkImageLoader: ImageLoading {
    // MARK: ImageLoading implementation
    func loadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        return image
    }
}

@MainActor
final class AsyncImageLoader: ObservableObject {
    // MARK: properties
    @Published var image: Image?
    @Published var error: Error?
    // property used for async testing
    public private(set) var loadTask: Task<Void, Never>?
    
    // MARK: init
    init(url: URL?, cache: ImageCaching, loader: ImageLoading) {
        guard let url else { return }
        self.loadTask = Task {
            await loadImage(url, cache: cache, loader: loader)
        }
    }
    
    private func loadImage(_ url: URL, cache: ImageCaching, loader: ImageLoading) async {
        guard let key = cache.filename(forURL: url) else { return }
        
        if let cached = cache.image(forKey: key) {
            image = Image(uiImage: cached)
            return
        }
        
        do {
            let loaded = try await loader.loadImage(from: url)
            cache.save(image: loaded, forKey: key)
            image = Image(uiImage: loaded)
        } catch {
            self.error = error
            print("Image load failed: \(error)")
        }
    }
}
