//
//  ArtistViewController.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    var genderId  =  0

    override func viewDidLoad() {
        super.viewDidLoad()

        idLabel.text = String(genderId)
    }
    

    

}
