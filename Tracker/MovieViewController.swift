//
//  MovieViewController.swift
//  Tracker
//
//  Created by Nam ML on 2018-03-22.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit
// this gives you more control over the messages appear and how they are saved
import os.log

class MovieViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
   
    
    @IBOutlet weak var MovieTb: UITextField!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingViewControl!
    
    var movie:Movie?
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field's user input through delegate callbacks
        MovieTb.delegate = self
        // Enable the save button only if the text field has a valid name
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    
    // this method got called when user tap return (Enter)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder();
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // movieNameLbl.text = MovieTb.text
        updateSaveButtonState()
        // make the textFiled text become navigation title
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable Save Btn while editing
        saveBtn.isEnabled = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancelAdding(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // configure the controller before it is presented
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // need to call super since it is an override function
        super.prepare(for: segue, sender: sender)
        // configure the destination view controller when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button == saveBtn else {
            os_log("The button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let movieName = MovieTb.text ?? "" // unwrap the optional string
        let photo = photoView.image
        let rating = ratingControl.rating
        
        // Set the movie data to be passed to MovieTableViewController after the unwind seque
        movie = Movie(movieName: movieName, photo: photo!, rating: rating)
    }
    
    //MARK: Actions
    
    @IBAction func choosePhotos(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        MovieTb.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        // movieNameLbl.text = "Photo was added successfully"
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable save if the name is empty
        let text = MovieTb.text ?? ""
        saveBtn.isEnabled = !text.isEmpty
    }
    
    
}

