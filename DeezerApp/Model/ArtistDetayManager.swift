//
//  ArtistDetayManager.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import Foundation

var gelenArtistId = 0

struct ArtistDetayManager{
    
    
    let olmasıGerekenUrl = "https://api.deezer.com/artist/8354140"
    
    
    mutating func getArtistID(artistId : Int) {
        gelenArtistId = artistId
        print("çalışıyor mu : \(gelenArtistId)")
        
    }
    
    func fetchArtistDetay ( completion: @escaping(ArtistModelDetay) -> Void) {
        
        guard let url = URL(string: "https://api.deezer.com/artist/\(gelenArtistId)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
          if let error = error {
            print("Error fetching ArtistDetay: \(error.localizedDescription)")
          }
          
          guard let jsonData = data else { return }
          
          let decoder = JSONDecoder()
          
          do {
            let decodedData = try decoder.decode(ArtistModelDetay.self, from: jsonData)
            completion(decodedData)
          } catch {
            print("Error decoding data.")
          }
          
        }
        
        dataTask.resume()
        
        
    }
    
    
}
