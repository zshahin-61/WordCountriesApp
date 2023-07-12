//
//  CountryDetailsView.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI
import MapKit
import CoreData

struct CountryDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let country: CountryResponseObj
    
    @FetchRequest(sortDescriptors: [])
    private var favorites: FetchedResults<FavoriteCountry>
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    func isFavorite() -> Bool {
        return favorites.first(where: { $0.countryname == country.name.common }) != nil
    }
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("Flag:").font(.headline)
                    Text(country.flag).font(.largeTitle)
                }
                Text("Common name: \(country.name.common)")
                    .font(.headline)
                Text("Official name: \(country.name.official)")
                    .font(.headline)
                
                Text("Capital: \(country.capital[0])")
                    .font(.headline)
                
                Text("Population: \(country.population)")
                    .font(.headline)
                
                Text("Area: \(country.area.formatted()) sq km")
                    .font(.headline)
                
               
                
                MapView(latitude: country.capitalInfo.latlng[0], longitude: country.capitalInfo.latlng[1], annotationTitle: country.capital.first ?? "")
                    .frame(height: 200)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Country Details").font(.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite() ? "heart.fill" : "heart")
                }
                .foregroundColor(isFavorite() ? .red : .black)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Favorite Status"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func toggleFavorite() {
        withAnimation {
            if isFavorite() {
//remove section
                if let favoriteCountry = favorites.first(where: { $0.countryname == country.name.common }) {
                    viewContext.delete(favoriteCountry)
                    alertMessage = "Removed from Favorites"
                }
            } else {
//check exist
                if favorites.contains(where: { $0.countryname == country.name.common }) {
                    alertMessage = "Country is already in Favorites"
                } else {
//add
                    let favoriteCountry = FavoriteCountry(context: viewContext)
                    favoriteCountry.countryname = self.country.name.common
                    favoriteCountry.capital = self.country.capital[0]
                    favoriteCountry.id = UUID()
                    favoriteCountry.flag = self.country.flag
                    favoriteCountry.population = Int64(self.country.population)
                    favoriteCountry.isFavorite = true
                    alertMessage = "Added to Favorites"
                }
            }
            
            do {
                try viewContext.save()
                showAlert = true
            } catch {
                print("Failed to save favorite country: \(error)")
            }
        }
    }
}
