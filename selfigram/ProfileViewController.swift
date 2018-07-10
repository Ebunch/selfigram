//
//  ProfileViewController.swift
//  selfigram
//
//  Created by Inderpal Lehal on 2018-07-09.
//  Copyright © 2018 Inderpal Lehal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBAction func cameraButtonPressed(_ sender: Any)
    {
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        if TARGET_OS_SIMULATOR == 1 {
    
            pickerController.sourceType = .photoLibrary
        } else {
            
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        self.present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      
            profileImageView.image = image
            
        }

        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
usernameLabel.text = "yourName"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
