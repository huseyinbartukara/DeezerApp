//
//  TracksDao.swift
//  DeezerApp
//
//  Created by Bartu Kara on 12.05.2023.
//

import Foundation

class TracksDao {
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("tracks.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func tumTracksAl() -> [Tracks] {
        var liste = [Tracks]()
        
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM tracks", values: nil)
            
            while rs.next(){
                let track = Tracks(albumId: Int(rs.string(forColumn: "albumId"))!
                                   ,albumTitle: rs.string(forColumn: "albumTitle")!
                                   ,albumDuration: Int(rs.string(forColumn: "albumDuration"))!)
                
                liste.append(track)
            }
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func tracksEkle (albumTitle:String, albumDuration:Int){
        
        db?.open()
        
        do {
            try db?.executeUpdate("INSERT INTO tracks (albumId, albumDuration) VALUES (?,?)", values: [albumTitle,albumDuration])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func tracksSil(albumId : Int){
        db?.open()
        do {
            try db?.executeUpdate("DELETE FROM trakcs WHERE albumId = ?", values: [albumId])
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }

}

