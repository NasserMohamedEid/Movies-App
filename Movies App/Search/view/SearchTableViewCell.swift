//
//  SearchTableViewCell.swift
//  Movies App
//
//  Created by Nasser Mohamed on 11/08/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var imageSearch: UIImageView!
    @IBOutlet weak var buttonMovie: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
