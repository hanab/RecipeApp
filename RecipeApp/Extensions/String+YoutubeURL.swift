//
//  String+YoutubeURL.swift
//  RecipeApp
//
//  Created by Hana on 6/4/25.
//

import Foundation

extension String {
    // Function for extracting youtube video ID from URL string
    // Embeding the video instead of loading it from the URL seems to load faster
    func youtubeVideoID() -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        if url.host?.contains("youtube.com") == true {
            return url.queryItems?.first(where: { $0.name == "v" })?.value
        } else if url.host?.contains("youtu.be") == true {
            return url.path.dropFirst().description
        }
        return nil
    }
}
