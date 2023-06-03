//
//  ImageFetcher.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/3/23.
//

import UIKit

enum ImageFetcher {
    
    static func fetchImage(named name: String) async -> UIImage {
        if let imageFromCache = ImageCache.getImage(named: name) {
            return imageFromCache
        }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(name)@2x.png") else { return UIImage() }
        if let (data, _) = try? await URLSession.shared.data(from: url) {
            if let image = UIImage(data: data) {
                ImageCache.save(imageName: name, imageData: data)
                return image
            }
        }
        return UIImage()
    }
    
}
