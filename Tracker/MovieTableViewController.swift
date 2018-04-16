//
//  MovieTableViewController.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-15.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var movies = [Movie]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // load the data
        loadSampleMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    
    @IBAction func unwindToMovieList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MovieViewController, let movie = sourceViewController.movie {
            // Add new Movie
            let newIndexPath = IndexPath(row: movies.count, section: 0)
            // append to the list after added new movie
            movies.append(movie)
            // animates the addition of a new row to the table view
            tableView.insertRows(at: [newIndexPath], with: .automatic)
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

}
