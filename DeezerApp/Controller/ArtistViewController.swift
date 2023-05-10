//
//  ArtistViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import UIKit

class ArtistViewController: UIViewController {
    
    
    @IBOutlet weak var artistCollectionView: UICollectionView!
    
    var genderId  =  0
    
    
    var myArtistler: [Artist]? {
        didSet {
            DispatchQueue.main.async { [self] in
                artistCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
       
       let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
       
       let genislik = self.artistCollectionView.frame.size.width
       
       tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       
       tasarim.minimumInteritemSpacing = 10
       tasarim.minimumLineSpacing = 10
       
       let hucreGenislik = (genislik-30) / 2
       
       tasarim.itemSize = CGSize(width: (hucreGenislik), height: hucreGenislik*1.65)
       
       artistCollectionView!.collectionViewLayout = tasarim
       
        
        let artistManager = ArtistManager()
        
        artistManager.fetchArtist { (artist) in
            DispatchQueue.main.async { [self] in
               navigationItem.title = ""
            }
            
            self.myArtistler = artist.data
        }
        
        
    }
    
}

extension ArtistViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArtistler?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistHucre", for: indexPath) as! ArtistHucre
        
        guard let artist = myArtistler?[indexPath.row] else { return UICollectionViewCell() }
            
        cell.artistAdLabel.text = artist.name
        
        
        //-----------------
        let artistPictureURL = URL(string: artist.picture_big)!

        let session = URLSession(configuration: .default)

        
        let downloadPicTask = session.dataTask(with: artistPictureURL) { (data, response, error) in
            
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                
                if let res = response as? HTTPURLResponse {
                    
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        _ = UIImage(data: imageData)
                        
                        DispatchQueue.main.sync {
                            //cell.kategoriImageView.image = UIImage(data: imageData)
                           cell.artistImageView.image = UIImage(data: imageData)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("tıklanınca yapılacak işlemler")
        
        /*if let kategori = myKategoriler?[indexPath.row]{
            print(kategori.id)
            genderId = kategori.id
            self.performSegue(withIdentifier: "toArtistVc", sender: kategori.id)
        }*/
        
        
        
    }
    
    
}
