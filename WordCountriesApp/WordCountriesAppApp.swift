//
//  WordCountriesAppApp.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI

@main
struct WordCountriesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    // TODO: Code to prepopulate the database goes here
                    loadSampleData()
                }
        }
    }
    // TODO: Helper function to load app with sample data
    private func loadSampleData() {
        print("++++ TODO: Load sample data...")
        
        let viewContext = persistenceController.container.viewContext

        
        let getAllFavoriteRequest = FavoriteCountry.fetchRequest()

        
        
        do {
            // manually forcing the app to request all data from the database (course)
            let countryInDB = try viewContext.fetch(getAllFavoriteRequest)
            print("Number of courses in database:\(countryInDB.count)")
        
            if (countryInDB.isEmpty) {
        // create the sample data here
        
        let favorite1 = FavoriteCountry(context: viewContext)
        favorite1.id = UUID()
        favorite1.countryname = "Iran"
        favorite1.capital = "Tehran"
        favorite1.flag = ""
        favorite1.population = 89342
        favorite1.isFavorite = false
        
      
        
                try viewContext.save()
                print("Database populated!")
            }
            else {
                print("Sorry, database is already populated!")
            }
            
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
        
    }
    
 
}
