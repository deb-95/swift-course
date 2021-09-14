//
//  ViewController.swift
//  SeeFood
//
//  Created by Debora Del Vecchio on 14/09/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func detect(image: CIImage) {
        do {
            let inceptionV3 = try Inceptionv3(configuration: MLModelConfiguration())
            let model = try VNCoreMLModel(for: inceptionV3.model)
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Model failed to process image")
                }
                if let firstResult = results.first {
//                    if firstResult.identifier.contains("hotdog") {
//                        self.navigationItem.title = "Hotdog!"
//                    } else {
//                        self.navigationItem.title = "Not Hotdog!"
//                    }
                    self.navigationItem.title = firstResult.identifier
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            try handler.perform([request])
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Delegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage

            guard let ciImage = CIImage(image: pickedImage) else {
                fatalError("Unable to convert UIImage into CIImage")
            }
            
            detect(image: ciImage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

