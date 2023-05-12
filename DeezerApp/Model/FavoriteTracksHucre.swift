//
//  FavoriteTracksHucre.swift
//  DeezerApp
//
//  Created by Bartu Kara on 12.05.2023.
//

import UIKit

class FavoriteTracksHucre: UITableViewCell {
    
    
    @IBOutlet weak var albumAdLabel: UILabel!
    @IBOutlet weak var albumSureLabel: UILabel!
    @IBOutlet weak var silButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
