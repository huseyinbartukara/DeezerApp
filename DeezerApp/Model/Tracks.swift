//
//  Tracks.swift
//  DeezerApp
//
//  Created by Bartu Kara on 12.05.2023.
//

import Foundation

class Tracks {
    
    var albumId : Int?
    var albumTitle : String?
    var albumDuration : Int?
    
    init() {
        
    }
    
    init(albumId: Int, albumTitle: String, albumDuration: Int) {
        self.albumId = albumId
        self.albumTitle = albumTitle
        self.albumDuration = albumDuration
    }
    
    
}
