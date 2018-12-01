//
//  RegisterViewController.swift
//  Registration
//
//  Created by MIT App Dev on 11/30/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import SDWebImage

class RegisterViewController: ImageUploadViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nrc: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var imageUrl = ""
    var stu = StudentVos()
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text! = stu.name ?? ""
        nrc.text! = stu.nrc ?? ""
        dob.text! = stu.dob ?? ""
        //user.gender = gender.hashValue
        major.text! = stu.major ?? ""
        university.text! = stu.university ?? ""
        address.text! = stu.address ?? ""
        email.text! = stu.email ?? ""
        
        phone.text! = stu.phone ?? ""
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveStudent(_ sender: Any) {
        let user = StudentVos()
      //  user.image = image.text!
        user.name = name.text!
        user.nrc = nrc.text!
        user.dob = dob.text!
        //user.gender = gender.hashValue
        user.major = major.text!
        user.university = university.text!
        user.address = address.text!
        user.email = email.text!
        user.password = password.text!
        user.confirmPassword = confirmPassword.text!
        user.phone = phone.text!
        user.image = imageUrl
        
        DataModel.shared.addUser(post: user, success: {
            self.dismiss(animated: true, completion: nil)
        }) {
            
        }
    }
    
     @IBAction func ImageUpload(_ sender: UIButton) {
        self.chooseUpload(sender, imagePickerControllerDelegate : self)
     }
    /*
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
                
                self.image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "user-icon"))
                self.imageUrl = url;
            }) {
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
        
    }
    
}
