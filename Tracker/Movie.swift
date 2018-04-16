//
//  Movie.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-15.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit
import Foundation

class Movie {
    
    //MARK: Properties
    
    var movieName: String
    var photo: UIImage
    var rating: Int
    
    //MARK: Initialization
    init?(movieName: String, photo: UIImage, rating: Int) {
        
        // The name must not be empty
        guard !movieName.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties
        self.movieName = movieName
        self.photo = photo
        self.rating = rating
    }
}
