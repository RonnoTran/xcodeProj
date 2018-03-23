//
//  ViewController.swift
//  Tracker
//
//  Created by Nam ML on 2018-03-22.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
   
    @IBOutlet weak var movieNameLbl: UILabel!
    
    @IBOutlet weak var MovieTb: UITextField!
    
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
    
    //MARK: Actions
    
    @IBAction func setDefault(_ sender: UIButton)
    {
        movieNameLbl.text = "Default"
    }
    
}

