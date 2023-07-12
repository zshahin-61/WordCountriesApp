//
//  country.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//
import Foundation

struct CountryResponseObj: Codable, Hashable {
    
        
        var name: Name
        var capital: [String]
        var population: Int
        var area: Double
        var flag: String
    var capitalInfo: CapitalInfo
   //   var latlng: [Double]

        
    }
struct CapitalInfo: Codable, Hashable {
    var latlng: [Double]
}
struct Name: Codable, Hashable {
   var common: String
    var official: String
    struct NativeName: Codable, Hashable {
        let ara: NativeNameAra
    }
    struct NativeNameAra: Codable, Hashable {
        var official: String
        var common: String
    }
}
