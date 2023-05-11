//
//  ArtistDetayViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import UIKit

class ArtistDetayViewController: UIViewController {
    
    
    @IBOutlet weak var artistAlbumCollectionView: UITableView!
    @IBOutlet weak var artistKapakImageView: UIImageView!
    var artistId = 0
    var artistTracksModelManager = ArtistTracksModelManager()
    
    var myArtistDetay: ArtistModelDetay? {
        didSet {
            DispatchQueue.main.async { [self] in
                //artistCollectionView.reloadData()
            }
        }
    }
    
    var myArtistAlbumDetay : [ArtistModelAlbumDetay]? {
        didSet {
            DispatchQueue.main.async { [self] in
                artistAlbumCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistAlbumCollectionView.delegate = self
        artistAlbumCollectionView.dataSource = self

        self.artistAlbumCollectionView.rowHeight = 80.0
        
        let artistDetayManager = ArtistDetayManager()
        
        artistDetayManager.fetchArtistDetay { (artistDetay) in
            self.myArtistDetay?.name = artistDetay.name
            self.myArtistDetay?.picture = artistDetay.picture
            DispatchQueue.main.async { [self] in
                navigationItem.title = artistDetay.name
                // --------------
                let artistDetayPictureURL = URL(string: artistDetay.picture_xl)!

                let session = URLSession(configuration: .default)

                
                let downloadPicTask = session.dataTask(with: artistDetayPictureURL) { (data, response, error) in
                    
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        
                        if let res = response as? HTTPURLResponse {
                            
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                _ = UIImage(data: imageData)
                                
                                DispatchQueue.main.sync {
                                    //cell.kategoriImageView.image = UIImage(data: imageData)
                                    artistKapakImageView.image = UIImage(data: imageData)
                                }
                                
                                
                                
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }

                downloadPicTask.resume()
            
                //--------------
            }
        }
        
        artistDetayManager.fetchArtistAlbumDetay { (album) in
        DispatchQueue.main.async { [self] in
            //navigationItem.title = "Kategoriler"
        }
            self.myArtistAlbumDetay = album.data
      }
        
        
        

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
       let albumId = sender as? Int
       let gidilecekVC = segue.destination as! ArtistTrackViewController
       gidilecekVC.albumId = albumId ?? 0
       artistTracksModelManager.getAlbumTracksID(albumId: albumId ?? 0)
    }
    

}

extension ArtistDetayViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArtistAlbumDetay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumHucre", for: indexPath) as! AlbumHucre
        
        guard let album = myArtistAlbumDetay?[indexPath.row] else { return UITableViewCell() }
            
        
        cell.albumAdLabel.text = album.title
        cell.albumTarihLabel.text = album.release_date
        
        //-----------------
        let albumPictureURL = URL(string: album.cover_big)!

        let session = URLSession(configuration: .default)

        
        let downloadPicTask = session.dataTask(with: albumPictureURL) { (data, response, error) in
            
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                
                if let res = response as? HTTPURLResponse {
                    
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        _ = UIImage(data: imageData)
                        
                        DispatchQueue.main.sync {
                            cell.albumImageView.image = UIImage(data: imageData)
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }

        downloadPicTask.resume()
        
        //-----------------
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 20
        
        return cell
        
    }
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tıklanınca yapılacak işlemler")
        if let album = myArtistAlbumDetay?[indexPath.row]{
            print(album.id)
           self.performSegue(withIdentifier: "toArtistTrackVc", sender: album.id)
        }
    }
    
    
}
