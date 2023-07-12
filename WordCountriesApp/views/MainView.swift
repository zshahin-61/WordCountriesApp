//
//  MainView.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
//            MyDebuggingScreen()
//            .tabItem {
//                Label("Debug", systemImage: "wrench.and.screwdriver")
//            }
            
            WorldCountriesListView()
            .tabItem {
                Label("WorldCountries", systemImage: "globe")
            }
            UserfavoriteView()
            .tabItem {
                Label("Favorite List", systemImage: "heart.fill")
            }
        
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
