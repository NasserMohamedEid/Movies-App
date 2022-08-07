//
//  commingTableViewCell.swift
//  Movies App
//
//  Created by Nasser Mohamed on 06/08/2022.
//

import UIKit
import SDWebImage
class commingTableViewCell: UITableViewCell {

    @IBAction func Button(_ sender: UIButton) {
    }
    @IBOutlet weak var commingImage: UIImageView!
    @IBOutlet weak var CommingMovieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func commingSetup(url:String,name:String){
        commingImage.sd_setImage(with:URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
        CommingMovieName.text=name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
