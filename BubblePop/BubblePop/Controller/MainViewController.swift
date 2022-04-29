//
//  MainViewController.swift
//  BubblePop
//
//  Created by Matthew Horner on 27/4/2022.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var bubbleSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            let VC = segue.destination as! GameViewController
            VC.name = nameTextField.text
            VC.time = Int(timeSlider.value)
            VC.maxBubbles = Int(bubbleSlider.value)
        }
    }

}
