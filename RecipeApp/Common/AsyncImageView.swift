//
//  AsyncImageView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI

struct AsyncImageView: View {
    // MARK: Properties
    @StateObject private var loader: AsyncImageLoader
    private let placeholder: AnyView
    
    // MARK: init
    init(urlString: String,
        cache: ImageCaching,
        @ViewBuilder placeholder: @escaping () -> AnyView) {
            let url = URL(string: urlString)
            _loader = StateObject(wrappedValue: AsyncImageLoader(url: url,
                                                                 cache: cache,
                                                                 loader: NetworkImageLoader()))
            self.placeholder = placeholder()
        }
    
    // MARK: body
    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
    }
}
#Preview {
    AsyncImageView(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/658442fe-e3d3-44a5-9081-e2424fb0129d/small.jpg",
                   cache: ImageCache()) {
        AnyView(
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .background(Color.red)
                .aspectRatio(1, contentMode: .fit)
        )
    }
}
