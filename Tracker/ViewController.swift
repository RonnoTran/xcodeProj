//
//  ViewController.swift
//  Tracker
//
//  Created by Nam ML on 2018-03-22.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
   
    @IBOutlet weak var movieNameLbl: UILabel!
    
    @IBOutlet weak var MovieTb: UITextField!
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field's user input through delegate callbacks
        MovieTb.delegate = self
    }

    //MARK: UITextFieldDelegate
    
    // this method got called when user tap return (Enter)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder();
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieNameLbl.text = MovieTb.text
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
        
        movieNameLbl.text = "Photo was added successfully"
        
    }
    @IBAction func setDefault(_ sender: UIButton)
    {
        movieNameLbl.text = "Default"
    }
    
}

