//
//  ArtistModelAlbum.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import Foundation

struct ArtistModelAlbum : Decodable {
    
    let data : [ArtistModelAlbumDetay]
}

struct ArtistModelAlbumDetay : Decodable {
    
    let id : Int
    let title : String
    let link : String
    let cover : String
    let cover_small : String
    let cover_medium : String
    let cover_big : String
    let cover_xl : String
    let md5_image : String
    let genre_id : Int
    let fans : Int
    let release_date : String
    let record_type : String
    let tracklist : String
    let explicit_lyrics : Bool
    let type : String
    
    
}
