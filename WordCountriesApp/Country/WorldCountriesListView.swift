//
//  WorldCountriesListView.swift
//  WordCountriesApp
//
//  Created by zahra SHAHIN on 2023-07-11.
//

import SwiftUI
import MapKit



struct WorldCountriesListView: View {
    @State var CountryList: [CountryResponseObj] = []
 
    var body: some View {
            NavigationView {
                List(CountryList, id: \.self) { country in
                    NavigationLink(destination: CountryDetailsView(country: country)) {
                        HStack {
                            Text(country.flag)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(country.name.common)
                                    .font(.headline)
                                Text("Capital: \(country.capital.joined(separator: ", "))")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .navigationTitle("World Countries")
                .onAppear {
                    loadDataFromAPI()
                }
            }
        }
    
    func loadDataFromAPI() {
        
        print("Getting data from API")
        
        // 1. Specify the API URL
        let apiUrlString = "https://restcountries.com/v3.1/independent?status=true"
        
        print("give me result----\(apiUrlString)")
        
        guard let apiUrl = URL(string: apiUrlString) else {
            print("ERROR: Cannot convert API address to a URL object")
            return
        }
        
        // 2. Create a network request object
        let request = URLRequest(url: apiUrl)
        
        // 3. Connect to the API and handle the results
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR: Network error: \(error)")
                return
            }
            
            if let jsonData = data {
                print("Data retrieved")
                
                do {
                     let decodedResponse = try JSONDecoder().decode([CountryResponseObj].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.CountryList = decodedResponse
                        print("we are here \(CountryList)")
                    }
                } catch {
                    print("ERROR: Error decoding JSON - \(error)")
                }
                
            
            } else {
                print("ERROR: Did not receive data from the API")
            }
        }
        task.resume()
    }
}

struct WorldCountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        WorldCountriesListView()
    }
}
