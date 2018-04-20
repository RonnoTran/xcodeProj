//
//  Movie.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-15.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit
import os.log
import Foundation

class Movie : NSObject, NSCoding {
    
    //MARK: Types
    
    struct PropertyKey {
        static let movieName = "movieName"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Saving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let savingURL = DocumentsDirectory.appendingPathComponent("movies")
    
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
    
    //MARK: Encoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(movieName, forKey: PropertyKey.movieName)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Movie name is required. If we can't decode a name string, the initializer should fail
        guard let movieName = aDecoder.decodeObject(forKey: PropertyKey.movieName) as? String
            else {
                os_log("Unable to decode the name for movie object", log: OSLog.default, type: .debug)
                return nil
        }
        
        // photo is an optional
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // initializer
        self.init(movieName: movieName, photo: photo!, rating: rating)
    }
    
}
