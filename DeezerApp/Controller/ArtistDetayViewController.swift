//
//  ArtistDetayViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import UIKit

class ArtistDetayViewController: UIViewController {
    
    
    @IBOutlet weak var artistKapakImageView: UIImageView!
    var artistId = 0
    
    var myArtistDetay: ArtistModelDetay? {
        didSet {
            DispatchQueue.main.async { [self] in
                //artistCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
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

        
    }
    

    

}
