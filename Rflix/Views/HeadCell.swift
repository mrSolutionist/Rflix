//
//  HeadCell.swift
//  Rflix
//
//  Created by  Robin George  on 16/11/21.
//

import UIKit


class HeadCell: UITableViewCell {

    @IBOutlet weak var trendingMovieImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configCell(imageData: Data, url:String){
            trendingMovieImage.image = UIImage(data: imageData)
    }
    


}
