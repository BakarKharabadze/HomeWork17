//
//  Country.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/21/24.
//

import Foundation

struct Country: Decodable {
    let name: Name
    let flag: String?
    let nativeName: String?
    let altSpellings: [String]?
    let capital: [String]?
    let currencies: [String: Currency]?
    let region: String?
    let borders: [String]?
    let flags: Flags?
    let maps: Maps?
    
    struct Flags: Decodable {
        let alt: String?
        let png: String?
    }
    
    struct Name: Codable {
        let common: String?
        let official: String?
    }
    
    struct Currency: Decodable {
        let name: String?
        let symbol: String?
    }
    
    struct Maps: Codable {
        let googleMaps: String?
        let openStreetMaps: String?
    }
}
