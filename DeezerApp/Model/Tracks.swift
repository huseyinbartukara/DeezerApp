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
    var albumPreview : String?
    
    init() {
        
    }
    
    init(albumId: Int, albumTitle: String, albumDuration: Int, albumPreview: String) {
        self.albumId = albumId
        self.albumTitle = albumTitle
        self.albumDuration = albumDuration
        self.albumPreview = albumPreview
    }
    
    
}
