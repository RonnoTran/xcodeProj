//
//  MovieTableViewController.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-15.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit
import os.log

class MovieTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var movies = [Movie]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller become the left button of the nav bar
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.title = "Change"
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        
        // load any changes/saves from before otherwise load sample data 
        if let savedMovies = loadMovies() {
            movies += savedMovies
        } else {
            // load the data
            loadSampleMovies()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (self.isEditing) {
            self.editButtonItem.title = "Finish"
        } else {
            self.editButtonItem.title = "Change"
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MovieTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("the dequeued cell is not an instance of MovieTableViewCell")
        }
        
        // fetches the appropriate data
        let movie = movies[indexPath.row]

        // Configure the cell...
        cell.movieNameLbl.text = movie.movieName
        cell.movieImage.image = movie.photo
        cell.ratingStar.rating = movie.rating

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // remove the movie object from the array
            movies.remove(at: indexPath.row)
            saveMovies()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddMovie":
            os_log("Adding new Movie", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let movieDetailViewController = segue.destination as? MovieViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMovieCell = sender as? MovieTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMovieCell) else {
                fatalError("The selected cell is not displaying")
            }
            
            let selectedMovie = movies[indexPath.row]
            movieDetailViewController.movie = selectedMovie
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMovieList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MovieViewController, let movie = sourceViewController.movie {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update the existing movie
                movies[selectedIndexPath.row] = movie
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add new Movie
                let newIndexPath = IndexPath(row: movies.count, section: 0)
                // append to the list after added new movie
                movies.append(movie)
                // animates the addition of a new row to the table view
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the movies
            saveMovies()
            
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleMovies() {
        let image1 = UIImage(named: "5cm")
        let image2 = UIImage(named: "yourName")
        let image3 = UIImage(named: "tsuki")
        
        guard let movie1 = Movie(movieName: "5cm per second", photo: image1!, rating: 5) else {
            fatalError("Unable to load or initiate movie1")
        }
        
        guard let movie2 = Movie(movieName: "Kimi No Na Wa", photo: image2!, rating: 4) else {
            fatalError("Unable to load or initiate movie2")
        }
        
        guard let movie3 = Movie(movieName: "Tsuki Ga Kirei", photo: image3!, rating: 5) else {
            fatalError("Unable to load or initiate movie3")
        }
        
        movies += [movie1, movie2, movie3]
    }
    
    private func saveMovies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(movies, toFile: Movie.savingURL.path)
        if isSuccessfulSave {
            os_log("Movies were saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save movies...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMovies() -> [Movie]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Movie.savingURL.path) as? [Movie]
    }

}
