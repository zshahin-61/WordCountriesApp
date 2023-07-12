//
//  UserfavoriteView.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI
import CoreData
struct UserfavoriteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FavoriteCountry.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteCountry.population, ascending: false)]
    )
    private var favorites: FetchedResults<FavoriteCountry>
    
    @State private var showDeleteAllAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Favorites User List").font(.headline)) {
                    ForEach(favorites, id: \.self) { favoriteCountry in
                        VStack(alignment: .leading) {
                            HStack {
                    Text(favoriteCountry.flag)
                        .font(.largeTitle)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Name: \(favoriteCountry.countryname ?? "")")
                            .font(.headline)
                        Text("Capital: \(favoriteCountry.capital ?? "")")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text("Population: \(favoriteCountry.population)")
                        .font(.subheadline)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete(perform: deleteFavorite)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: EditButton())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showDeleteAllAlert = true
                    }) {
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.red)
                }
            }
            .alert(isPresented: $showDeleteAllAlert) {
                Alert(
                    title: Text("Delete All"),
                    message: Text("Are you sure you want to delete all favorites?"),
                    primaryButton: .destructive(Text("Delete All"), action: deleteAllFavorites),
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let favoriteCountry = favorites[index]
            viewContext.delete(favoriteCountry)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete favorite country: \(error)")
        }
    }
    
    private func deleteAllFavorites() {
        for favoriteCountry in favorites {
            viewContext.delete(favoriteCountry)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete all favorites: \(error)")
        }
    }
}
