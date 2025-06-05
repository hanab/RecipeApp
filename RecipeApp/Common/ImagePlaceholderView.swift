//
//  ImagePlaceholderView.swift
//  RecipeApp
//
//  Created by Hana on 6/2/25.
//
import SwiftUI

struct ImagePlaceholderView: View {
    // MARK: Properties
    var dimension: CGFloat
    
    // MARK: body
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.black)
            .frame(width: dimension, height: dimension, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ImagePlaceholderView(dimension: 100)
}
