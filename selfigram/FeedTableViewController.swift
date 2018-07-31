//
//  FeedTableViewController.swift
//  selfigram
//
//  Created by Inderpal Lehal on 2018-07-16.
//  Copyright © 2018 Inderpal Lehal. All rights reserved.
//

import UIKit
import Parse


class FeedTableViewController: UITableViewController {
    
        var words = ["Hello", "my", "name", "is", "Selfigram"]
        var posts = [Post]()
  

    
     override func viewDidLoad(){
        if let query = Post.query() {
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            if let posts = posts as? [Post]{
                self.posts = posts
                self.tableView.reloadData()
                
            }

            query.findObjectsInBackground(block: { (posts, error) -> Void in
                // this block of code will run when the query is complete
            })
        }
        super.viewDidLoad()
      
        var me: User = User(aUsername: "paul", aProfileImage: UIImage(named: "Grumpy-Cat")!)

       // let post0 = Post(imageURL: UIImage(named: "Grumpy-Cat")!, user: me, comment: "Grumpy Cat 0")
//        let post1 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "Grumpy Cat 1")
//        let post2 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "Grumpy Cat 2")
//        let post3 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "Grumpy Cat 3")
//        let post4 = Post(image: UIImage(named: "Grumpy-Cat")!, user: me, comment: "Grumpy Cat 4")
//
//
//        posts = [post0, post1, post2, post3, post4]
       // let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=4aee1e740c3fe2d9570cf200451bd017&tags=cat")!

//        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
//
//
//            // convert Data to JSON
//            if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []) {
//
//                let json = jsonUnformatted as? [String : AnyObject]
//                let photosDictionary = json?["photos"] as? [String : AnyObject]
//                if let photosArray = photosDictionary?["photo"] as? [[String : AnyObject]] {
//
//                    for photo in photosArray {
//
//                        if let farmID = photo["farm"] as? Int,
//                            let serverID = photo["server"] as? String,
//                            let photoID = photo["id"] as? String,
//                            let secret = photo["secret"] as? String {
//
//                            let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
//                            print(photoURLString)
//                            if let photoURL = URL(string: photoURLString) {
//
//                                let me = User(aUsername: "sam", aProfileImage: UIImage(named: "Grumpy-Cat")!)
//                                let post = Post(image: photoURL, user: me, comment: "A Flickr Selfie")
//                                self.posts.append(post)
//                            }
//                        }
//
//                    }
//
//                    // We use OperationQueue.main because we need update all UI elements on the main thread.
//                    // This is a rule and you will see this again whenever you are updating UI.
//                    OperationQueue.main.addOperation {
//                        self.tableView.reloadData()
//                    }
//                }
//
//            }else{
//                print("error with response data")
//            }
//
//        })
        
        //start or restart
       // task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func Camerabutton(_ sender: UIBarButtonItem)
        {
            
            let pickerController = UIImagePickerController()
            
            pickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                
            
            
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
                
                
                if let imageData = UIImageJPEGRepresentation(image, 0.9),
                    let imageFile = PFFile(data: imageData){
                    
                    
                    let post = Post(image: imageFile, user: PFUser.current()!, comment: "A Selfie")

                    post.saveInBackground(block: { (success, error) -> Void in
                        if success {
                            print("Post successfully saved in Parse")
                            
                            self.posts.insert(post, at: 0)
                            
                            let indexPath = IndexPath(row: 0, section: 0)
                            self.tableView.insertRows(at: [indexPath], with: .automatic)
                            
                        }
                    })
                }
            }
            
            dismiss(animated: true, completion: nil)
            
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! SelfieCell
        
        let post = self.posts[indexPath.row]


        
        // I've added this line to prevent flickering of images
        // We are inside the cellForRowAtIndexPath method that gets called everything we layout a cell
        // Because we are reusing "postCell" cells, a reused cell might have an image already set on it.
        // This always resets the image to blank, waits for the image to download, and then sets it
        cell.selfieImageView.image = nil
        
        let imageFile = post.image
        imageFile.getDataInBackground(block: {(data, error) -> Void in
            if let data = data {
                let image = UIImage(data: data)
                cell.selfieImageView.image = image
            }
        })
        
        cell.selfiecellLabel.text = post.user.username
        cell.selfiecellLabel.text = post.comment

        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
