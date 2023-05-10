//
//  ViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 9.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var kategoriImageView: UIImageView!
    @IBOutlet weak var kategoriLabel: UILabel!
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    
    var genderId : Int = 0
    
    var myKategoriler: [Data]? {
        didSet {
          DispatchQueue.main.async { [self] in
              kategoriCollectionView.reloadData()
          }
        }
      }
      
      override func viewDidLoad() {
        super.viewDidLoad()
          
          kategoriCollectionView.delegate = self
          kategoriCollectionView.dataSource = self
          
          let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
          
          let genislik = self.kategoriCollectionView.frame.size.width
          
          tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
          
          tasarim.minimumInteritemSpacing = 10
          tasarim.minimumLineSpacing = 10
          
          let hucreGenislik = (genislik-30) / 2
          
          tasarim.itemSize = CGSize(width: (hucreGenislik), height: hucreGenislik*1.65)
          
          kategoriCollectionView!.collectionViewLayout = tasarim
        
        
        
        let kategoriManager = KategoriManager()
        
          kategoriManager.fetchKategori { (kategori) in
          DispatchQueue.main.async { [self] in
              navigationItem.title = "Kategoriler"
          }
          
              self.myKategoriler = kategori.data
        }
      }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! ArtistViewController
        gidilecekVC.genderId = indeks ?? 0
        
    }
    

    
    

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myKategoriler?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategoriHucre", for: indexPath) as! KategoriHucre
        
        guard let kategori = myKategoriler?[indexPath.row] else { return UICollectionViewCell() }
            
            
        
        cell.kategoriLabel.text = kategori.name
        //print(kategori.id)
        
        //-----------------
        let kategoriPictureURL = URL(string: kategori.picture_big)!

        let session = URLSession(configuration: .default)

        
        let downloadPicTask = session.dataTask(with: kategoriPictureURL) { (data, response, error) in
            
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                
                if let res = response as? HTTPURLResponse {
                    
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        _ = UIImage(data: imageData)
                        
                        DispatchQueue.main.sync {
                            cell.kategoriImageView.image = UIImage(data: imageData)
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
        
        if let kategori = myKategoriler?[indexPath.row]{
            print(kategori.id)
            genderId = kategori.id
            self.performSegue(withIdentifier: "toArtistVc", sender: kategori.id)
        }
        
        
        
    }
    
    
}


