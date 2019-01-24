//
//  ViewController.swift
//  SeeDog
//
//  Created by Brian De Maio on 1/23/19.
//  Copyright © 2019 Brian De Maio. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func CameraTapped(_ sender: Any) {
    }
}

