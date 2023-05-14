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
    var tracksListe = [Tracks]()
    var myArtistTracks : [ArtistTracks]? {
        didSet {
            DispatchQueue.main.async { [self] in
                tracksTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracksListe = TracksDao().tumTracksAl()

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
        
        cell.ekleButton.setTitle("", for: .normal)
        let kalpImage = UIImage(named: "kalp")
        cell.ekleButton.setImage(kalpImage?.withRenderingMode(.automatic),for: .normal)
        cell.ekleButton.imageView?.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        
        for track in tracksListe{
            if tracks.title == track.albumTitle{
                cell.ekleButton.setTitle("", for: .normal)
                let kalpImage = UIImage(named: "doluKalp")
                cell.ekleButton.setImage(kalpImage?.withRenderingMode(.automatic),for: .normal)
                cell.ekleButton.imageView?.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
            }
        }
        
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
        
        
        var tracks = myArtistTracks?[indexpath.row]
        
        
        
        TracksDao().tracksEkle(albumTitle: tracks?.title ?? "", albumDuration: tracks?.duration ?? 0, albumPreview: tracks?.preview ?? "")
        
        sender.setTitle("", for: .normal)
        let kalpImage = UIImage(named: "doluKalp")
        sender.setImage(kalpImage?.withRenderingMode(.automatic),for: .normal)
        sender.imageView?.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        
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
