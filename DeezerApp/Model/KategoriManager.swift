//
//  KategoriManager.swift
//  DeezerApp
//
//  Created by Bartu Kara on 9.05.2023.
//

import Foundation


struct KategoriManager {
  
  func fetchKategori(completion: @escaping(KategoriModel) -> Void) {
    
    guard let url = URL(string: "https://api.deezer.com/genre") else { return }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error {
        print("Error fetching Kategori: \(error.localizedDescription)")
      }
      
      guard let jsonData = data else { return }
      
      let decoder = JSONDecoder()
      
      do {
        let decodedData = try decoder.decode(KategoriModel.self, from: jsonData)
        completion(decodedData)
      } catch {
        print("Error decoding data.")
      }
      
    }
    
    dataTask.resume()
  }
  
}
