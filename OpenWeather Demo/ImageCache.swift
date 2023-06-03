//
//  ImageCache.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/3/23.
//

import UIKit

enum ImageCache {
    
    static let basePath = "\(FileManager.documentDirectory)/images"
    
    static func getImage(named name: String) -> UIImage? {
        let path = "\(basePath)/\(name)"
        if let data = FileManager.default.contents(atPath: path) {
            return UIImage(data: data)
        }
        return nil
    }
    
    static func save(imageName: String, imageData: Data) {
        let path = "\(basePath)/\(imageName)"
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: imageData)
        }
    }
    
}

extension FileManager {
    static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
