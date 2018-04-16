//
//  MovieTableViewCell.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-15.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var movieNameLbl: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var ratingStar: RatingViewControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
