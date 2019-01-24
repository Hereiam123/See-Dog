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
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageView.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {fatalError("Couldn't Convert Image to CIImage")}
            
            processImage(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func processImage(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{ fatalError("Could not access VNCoreMLModel") }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("Could not cast results as VNClassificationObservation")}
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch{
            print("Could not perform request on image classification")
        }
    }
    
    @IBAction func CameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
}

