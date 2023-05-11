//
//  TrakcsHucre.swift
//  DeezerApp
//
//  Created by Bartu Kara on 11.05.2023.
//

import UIKit

class TrakcsHucre: UITableViewCell {
    
    
    @IBOutlet weak var tracksImageView: UIImageView!
    @IBOutlet weak var tracksAdLabel: UILabel!
    @IBOutlet weak var tracksSureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
