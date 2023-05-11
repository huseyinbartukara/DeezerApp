//
//  ArtistTracksModelManager.swift
//  DeezerApp
//
//  Created by Bartu Kara on 11.05.2023.
//

import Foundation

var gelenAlbumId = 0

struct ArtistTracksModelManager {
    
    let olmasıGerekenUrl = "https://api.deezer.com/album/118058342/tracks"
    
    
    mutating func getAlbumTracksID(albumId : Int) {
        gelenAlbumId = albumId
        print("çalışıyor mu : \(gelenAlbumId)")
    }
    
    func fetchTracks ( completion: @escaping(ArtistTracksModel) -> Void) {
        
        print(gelenAlbumId)
        
        guard let url = URL(string: "https://api.deezer.com/album/\(gelenAlbumId)/tracks") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
          if let error = error {
            print("Error fetching Tracks: \(error.localizedDescription)")
          }
          
          guard let jsonData = data else { return }
          
          let decoder = JSONDecoder()
          
          do {
            let decodedData = try decoder.decode(ArtistTracksModel.self, from: jsonData)
            completion(decodedData)
          } catch {
            print("Error decoding data.")
          }
          
        }
        
        dataTask.resume()
    }
    
    
    
    
}
