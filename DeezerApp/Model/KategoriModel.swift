//
//  KategoriModel.swift
//  DeezerApp
//
//  Created by Bartu Kara on 9.05.2023.
//

import Foundation

struct KategoriModel : Decodable{
    let data : [Data]
}

struct Data : Decodable {
    let id : Int
    let name : String
    let picture : String
    let picture_small : String
    let picture_medium : String
    let picture_big : String
    let picture_xl : String
    let type : String
}

   
    
    

