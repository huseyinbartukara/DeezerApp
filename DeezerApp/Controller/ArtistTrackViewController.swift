//
//  ArtistTrackViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 11.05.2023.
//

import UIKit
import AVFoundation

class ArtistTrackViewController: UIViewController {
    
    @IBOutlet weak var tracksTableView: UITableView!
    
    
    var albumId = 0
    var player: AVPlayer!
    var myArtistTracks : [ArtistTracks]? {
        didSet {
            DispatchQueue.main.async { [self] in
                tracksTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tracksTableView.delegate = self
        tracksTableView.dataSource = self
        
        self.tracksTableView.rowHeight = 80.0
        
        let artistTracksModelManager = ArtistTracksModelManager()
        
        artistTracksModelManager.fetchTracks { (tracks) in
            DispatchQueue.main.async { [self] in
               navigationItem.title = "Tracks"
            }
            self.myArtistTracks = tracks.data
        }
        
    }
    
    func secondsToHourMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    

}
extension ArtistTrackViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArtistTracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tracksHucre", for: indexPath) as! TrakcsHucre
        
        guard let tracks = myArtistTracks?[indexPath.row] else { return UITableViewCell() }
            
        
        
        cell.tracksAdLabel.text = tracks.title
        
        let (h,m,s) = secondsToHourMinutesSeconds(tracks.duration)
        
        if s < 10 {
            cell.tracksSureLabel.text = "\(m):0\(s)\""
        }else{
            cell.tracksSureLabel.text = "\(m):\(s)\""
        }
        
        cell.ekleButton.tag = indexPath.row
        cell.ekleButton.addTarget(self, action: #selector(ekleButton), for: .touchUpInside)
        
        
        
        
        
        //-----------------
        
        // resim yüklenicek olursa buradan yüklenicek
        
        //-----------------
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    @objc func ekleButton(sender:UIButton){
        print(" ekle button tıklandı")
        
        let indexpath = IndexPath(row: sender.tag,section: 0)
        print(indexpath.row)
        
        let tracks = myArtistTracks?[indexpath.row]
        
        TracksDao().tracksEkle(albumTitle: tracks?.title ?? "", albumDuration: tracks?.duration ?? 0, albumPreview: tracks?.preview ?? "")
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tıklanınca yapılacak işlemler")
        
        
        if let tracks = myArtistTracks?[indexPath.row]{
            let url = URL(string: tracks.preview)
            
            do {
                let playerItem = AVPlayerItem(url: url!)
                self.player = try AVPlayer(playerItem: playerItem)
                player.volume = 1.0
                player!.play()
            }catch let error as NSError {
                self.player = nil
                print(error.localizedDescription)
            } catch {
                print("AVAudioPlayer init failed")
            }
            
        }
    }
    
    
    
}
