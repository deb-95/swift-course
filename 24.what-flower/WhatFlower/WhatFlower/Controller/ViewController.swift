//
//  ViewController.swift
//  WhatFlower
//
//  Created by Debora Del Vecchio on 14/09/21.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let pickerController = UIImagePickerController()
    var userImage: UIImage?
    
    let httpService = HttpService()
    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    @IBOutlet weak var flowerDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .camera
        flowerDescription.text = ""
    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(pickerController, animated: true, completion: nil)
    }
    
    func detect(flowerImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("Error creating model for FlowerClassification")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if error == nil {
                let results = request.results as? [VNClassificationObservation]
                if let result = results?.first {
                    self.httpService.getFlowerInfo(
                        flowerName: result.identifier,
                        onSuccess: self.onSuccess,
                        onError: self.onError
                    )
                    DispatchQueue.main.async {
                        self.navigationItem.title = result.identifier.capitalized
                    }
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func onSuccess(response: WikipediaResponse) {
        // this is not the best way to implement this. It should have another layer of abstraction for business logic
        let model = WikipediaVM.fromDto(dto: response)
        DispatchQueue.main.async {
            self.flowerDescription.text = model.extract
            self.loadImage(url: model.image)
        }
    }
    
    func loadImage(url: String?) {
        if let imageURL = url, let url = URL(string: imageURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    self.pickedImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        } else {
            self.pickedImageView.image = userImage!
        }
        
    }
    
    func onError(error: Error) {
        print(error)
    }
    
    // MARK:- Image Picker Controller Delegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
//            pickedImageView.image = userPickedImage
            userImage = userPickedImage
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert user image to CIImage")
            }
            
            detect(flowerImage: ciImage)
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
}

