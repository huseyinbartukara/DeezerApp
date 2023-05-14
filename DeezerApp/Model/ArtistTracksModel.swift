//
//  ArtistTracksModel.swift
//  DeezerApp
//
//  Created by Bartu Kara on 11.05.2023.
//

import Foundation

struct ArtistTracksModel : Decodable {
    
    let data : [ArtistTracks]
}

struct ArtistTracks : Decodable {
    
    let id : Int
    let readable : Bool
    let title : String
    let title_short : String
    let title_version : String
    let isrc : String
    let link : String
    let duration : Int
    let track_position : Int
    let disk_number : Int
    let rank : Int
    let explicit_lyrics : Bool
    let explicit_content_lyrics : Int
    let explicit_content_cover : Int
    let preview : String
    let md5_image : String
    let artist : ArtistNesne
    let type : String
    
}

struct ArtistNesne : Decodable {
    let id : Int
    let name : String
    let tracklist : String
    let type : String
}
