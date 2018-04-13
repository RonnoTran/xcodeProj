//
//  RatingView.swift
//  Tracker
//
//  Created by Nam ML on 2018-04-12.
//  Copyright © 2018 Ron Tran. All rights reserved.
//

import UIKit

// IBDesignabke lets the interface builder instantiate and draw a copy of controller into the canvas
@IBDesignable class RatingViewControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    // need a property observer to respond to changes of value
    var starSize:CGSize = CGSize(width: 44.0, height:44.0) {
        didSet {
            setupButtons()
        }
    }
    
    var numberOfStar:Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // Load Button Images from the assets catalog
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        // Clear any existing button
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Create the button
        for index in 0..<numberOfStar {
            let button = UIButton()
        
            // button can have 5 different states : normal, highlighted, focused, selected and disabled
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints to the button
            // disable the button's automatically generated constraint
            button.translatesAutoresizingMaskIntoConstraints = false
            // constraints that defines the view's height
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            // constraints that defines the view's width
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup the button Action
            button.addTarget(self, action: #selector(RatingViewControl.ratingButtonPressed(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    //MARK: Button Action
    @objc func ratingButtonPressed(button: UIButton) {
        // index(of: ...)
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the rating array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected of the selected button
        let selectedRating = index + 1;
        
        if selectedRating == rating {
            // reset the rating to 0 if the button is selected
            rating = 0
        } else {
            // set the rating to the selected star
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // if the index is less than the rating, selected the button of that index
            button.isSelected = index < rating
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating"
            } else {
                hintString = nil
            }
            
            // calculate the value string
            let valueString: String
            switch(rating) {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
