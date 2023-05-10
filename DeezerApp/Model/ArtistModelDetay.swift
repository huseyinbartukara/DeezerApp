//
//  ArtistModelDetay.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import Foundation

struct ArtistModelDetay : Decodable {
    let id : Int
    var name : String
    let link : String
    let share : String
    var picture : String
    let picture_small : String
    let picture_medium : String
    var picture_big : String
    var picture_xl : String
    let nb_album : Int
    let nb_fan : Int
    let radio : Bool
    let tracklist : String
    let type : String
}
