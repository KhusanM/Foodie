//
//  PresonalDetailsVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/4/21.
//

import UIKit

struct PersonalDetailsDM {
    var name: String
    var email: String
    var phoneNumber: String
    var address: String

}

protocol DMDelegate {
    func sendData(_ a : PersonalDetailsDM )
}


import MobileCoreServices
class PresonalDetailsVC: UIViewController{
    @IBOutlet weak var editBtnOutlet: UIButton!
    
    @IBOutlet weak var containerViewBig: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtViewAddress: UITextView!{
        didSet {
            txtViewAddress.layer.borderWidth = 1
            txtViewAddress.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            txtViewAddress.layer.cornerRadius = 10
            txtViewAddress.delegate =  self
            
        }
    }
    @IBOutlet weak var imgContainerView: UIView!
       
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    var dat : PersonalDetailsDM?
    var delegate : DMDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtViewAddress.text = "Address"
        txtViewAddress.textColor = UIColor.lightGray
        keyboard()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgContainerView.layer.cornerRadius = imgContainerView.frame.width/2
        imgContainerView.clipsToBounds = true
    }
    
    
    func check() -> Bool{
        if
        (!txtName.text!.isEmpty &&
            !txtEmail.text!.isEmpty &&
           !txtPhoneNumber.text!.isEmpty &&
            !txtViewAddress.text!.isEmpty) {
            
            return true
                    }else {
                        
                        editBtnOutlet.setTitle("barcha maydonlar to'ldirilsin", for: .normal)
                        editBtnOutlet.backgroundColor = .red

            return false
        }
    
    
    }
        
        
        
    
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        if check() {
        dat = PersonalDetailsDM(name: txtName.text!, email: txtEmail.text!, phoneNumber: txtPhoneNumber.text!, address: txtViewAddress.text!)
        guard let a = dat else {
            return
        }
            UserDefaults.standard.setImage(image: imgView.image, forKey: "Img")
        delegate?.sendData(a)
        dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func dismisBtnPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func chooseImgBtnPressed(_ sender: Any) {
        let vc = UIImagePickerController()
              
              vc.sourceType = .photoLibrary
              vc.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
              
              vc.allowsEditing = true
              
              vc.delegate = self
        UserDefaults.standard.setImage(image: imgView.image, forKey: "Img")
              present(vc, animated: true, completion: nil)

        
    }
    
    
}
extension PresonalDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Check for the media type

          let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString

          switch mediaType {

          case kUTTypeImage:

            // Handle image selection result

            print("Selected media is image")

            let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

            imgView.image = editedImage




            let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

            imgView.image = originalImage
            
          case kUTTypeMovie:

            // Handle video selection result

            print("Selected media is video")

            let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as! URL

            

          default:

            print("Mismatched type: \(mediaType)")

          }

          picker.dismiss(animated: true, completion: nil)

        

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("CANCELLED")
    }
    
    
    
}


extension PresonalDetailsVC : UITextViewDelegate {
    
    
   

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            txtViewAddress.text = ""
            txtViewAddress.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewAddress.text == "" {
            txtViewAddress.text = "Address"
            txtViewAddress.textColor = UIColor.lightGray
        }
    }
    
    
}
extension UserDefaults {
    
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
    
}

//MARK: Hide KeyBoard
extension PresonalDetailsVC {
    func keyboard() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey]as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        UIView.animate(withDuration: 0.5) {
            self.containerViewBig.transform = .init(translationX: 0, y: -keyboardSize.height+20)
        }
    }
    
  
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5) {
            self.containerViewBig.transform = .identity
        }
    }
}
