//
//  GeocodeModel.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/3/23.
//

import Foundation

struct GeocodeModel: Codable, Identifiable {
    
    var name: String?
    var localNames: LocalNames?
    var lat: Double
    var lon: Double
    var country: String?
    var state: String?
    
    var id: String {
        "\(lat)\(lon)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name       = "name"
        case localNames = "local_names"
        case lat        = "lat"
        case lon        = "lon"
        case country    = "country"
        case state      = "state"
    }
    
}
