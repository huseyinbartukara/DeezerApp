//
//  ArtistManager.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import Foundation

var gelenGenderId = 0

struct ArtistManager {
    
    let genelUrl = "https://api.deezer.com/genre"
    let olmasıGerekenUrl = "https://api.deezer.com/genre/12/artists"
    var gelenGenderId = 0
    
    mutating func getGenderID(genderId : Int) {
        gelenGenderId = genderId
        print("çalışıyor mu : \(gelenGenderId)")
        
    }
    
    func fetchArtist ( completion: @escaping(ArtistModel) -> Void) {
        
        print(gelenGenderId)
        
        guard let url = URL(string: "https://api.deezer.com/genre/\(gelenGenderId)/artists") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
          if let error = error {
            print("Error fetching Kategori: \(error.localizedDescription)")
          }
          
          guard let jsonData = data else { return }
          
          let decoder = JSONDecoder()
          
          do {
            let decodedData = try decoder.decode(ArtistModel.self, from: jsonData)
            completion(decodedData)
          } catch {
            print("Error decoding data.")
          }
          
        }
        
        dataTask.resume()
        
        
    }
    
    
    
    
}
