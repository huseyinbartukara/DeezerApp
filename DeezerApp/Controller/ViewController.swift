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
        
        
        
        let kategoriManager = KategoriManager()
        
          kategoriManager.fetchKategori { (kategori) in
          DispatchQueue.main.async { [self] in
              navigationItem.title = "kategori"
          }
          
              self.myKategoriler = kategori.data
        }
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
            
            //cell.textLabel?.text = "\(movie.title) - \(movie.releaseYear)"
        print(kategori.name)
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("tıklanınca yapılacak işlemler")
    }
    
    
}


