//
//  ArtistModel.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import Foundation


struct ArtistModel : Decodable{
    let data : [Artist]
}

struct Artist : Decodable {
    let id : Int
    let name : String
    let picture : String
    let picture_small : String
    let picture_medium : String
    let picture_big : String
    let picture_xl : String
    let radio : Bool
    let tracklist : String
    let type : String
}
