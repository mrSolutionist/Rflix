//
//  HeadCell.swift
//  Rflix
//
//  Created by  Robin George  on 16/11/21.
//

import UIKit


class HeadCell: UITableViewCell {

    @IBOutlet weak var trendingMovieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configCell(json:GenreTypeModel, url:String){
//        trendingMovieImage.image = UIImage()
      
    }

}
