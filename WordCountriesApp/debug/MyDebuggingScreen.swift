//
//  MyDebuggingScreen.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI

struct MyDebuggingScreen: View {
    
    
    @FetchRequest(sortDescriptors:[])
    private var CountryFavoriteFromDB:FetchedResults<FavoriteCountry>
    
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("Favorite List")) {
                    ForEach(CountryFavoriteFromDB) {
                        currList in
                        Text(currList.countryname)
                        Text(currList.capital)
                        
                    }
                } // end section #3
            } // end List
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    // button to delete everything
                    Button {
                        // deleteAll()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        
        
        
    } // end body
}
struct MyDebuggingScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyDebuggingScreen()
    }
}
