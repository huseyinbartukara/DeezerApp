//
//  FavoriteTracksViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 12.05.2023.
//

import UIKit

class FavoriteTracksViewController: UIViewController {

    @IBOutlet weak var favoriteTracksTableView: UITableView!
    
    var tracksListe = [Tracks]()
    var myArtistTracks : [ArtistTracks]? {
        didSet {
            DispatchQueue.main.async { [self] in
                favoriteTracksTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        veritabaniKopyala()
        
        favoriteTracksTableView.delegate = self
        favoriteTracksTableView.dataSource = self
        
        self.favoriteTracksTableView.rowHeight = 80.0
        
        tracksListe = TracksDao().tumTracksAl()
        
        
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tracksListe = TracksDao().tumTracksAl()
        favoriteTracksTableView.reloadData()
    }
    
    
    
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "trakcs", ofType: ".sqlite")
        
        let hedefyol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefyol).appendingPathComponent("trakcs.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
           
            print("Veri tabanı zaten var kopyalamaya gerek yok")
            
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                
            }catch{
                print(error)
            }
        }
        
    }

    
}

extension FavoriteTracksViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracksListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let track = tracksListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTracksHucre", for: indexPath) as! FavoriteTracksHucre
        
        cell.albumAdLabel.text = track.albumTitle
        cell.albumSureLabel.text = "\(track.albumDuration)"
        
        cell.silButton.tag = indexPath.row
        cell.silButton.addTarget(self, action: #selector(silButton), for: .touchUpInside)
        
                
        return cell
        
    }
    @objc func silButton(sender:UIButton){
        print(" sil button tıklandı")
        
        let indexpath = IndexPath(row: sender.tag,section: 0)
        print(indexpath.row)
        
        let tracks = tracksListe[indexpath.row]
        print(tracks.albumId)
        TracksDao().tracksSil(albumId: tracks.albumId!)
        
        tracksListe = TracksDao().tumTracksAl()
        favoriteTracksTableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Şarkı Çaldırma yeri Burası.")
    }
    
    
}
