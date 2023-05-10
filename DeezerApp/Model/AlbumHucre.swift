//
//  AlbumHucre.swift
//  DeezerApp
//
//  Created by Bartu Kara on 10.05.2023.
//

import UIKit

class AlbumHucre: UITableViewCell {
    
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumAdLabel: UILabel!
    @IBOutlet weak var albumTarihLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
