//
//  YoutubeVideoView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    // MARK: Properties
    let videoURL: String
    
    // MARK: UIViewRepresentable implementations
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoID = videoURL.youtubeVideoID() else { return }
        uiView.scrollView.isScrollEnabled = false
        // Used since loading the html slightly improves the speed of the video load
        let html = """
            <!DOCTYPE html>
            <html style="height:100%; margin:0;">
              <body style="height:100%; margin:0;">
                <iframe
                  width="100%"
                  height="100%"
                  src="https://www.youtube.com/embed/\(videoID)?playsinline=1"
                  frameborder="0"
                  allowfullscreen
                  style="border:none;">
                </iframe>
              </body>
            </html>
            """
        uiView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
    }
}
