//
//  FavoriteCountry+CoreDataProperties.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//
//

import Foundation
import CoreData


extension FavoriteCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCountry> {
        return NSFetchRequest<FavoriteCountry>(entityName: "FavoriteCountry")
    }

    @NSManaged public var countryname: String
    @NSManaged public var id: UUID
    @NSManaged public var capital: String
    @NSManaged public var flag: String
    @NSManaged public var population: Int64
    @NSManaged public var isFavorite: Bool

}

extension FavoriteCountry : Identifiable {

}
