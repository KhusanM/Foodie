//
//  LoginVC.swift
//  figma_food_delivery_app
//
//  Created by Zokirov Firdavs on 04/07/21.
//

import UIKit
import Alamofire
import SwiftyJSON

let base_URL = "https://foodie-backend-v7tmm.ondigitalocean.app"
class LoginVC: UIViewController {
    
    
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var brithDayStack: UIStackView!
    
    @IBOutlet weak var heightForStack: NSLayoutConstraint!
    @IBOutlet weak var forgotPasscode: UIButton!
    
    @IBOutlet weak var heightForBtn: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var topConteinerView: UIView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var nameTFSignup: UITextField!
    
    var datePicker = UIDatePicker()
    var isPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "isLogged")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.datePickerMode = UIDatePicker.Mode.date
        dataTF.inputView = datePicker
        datePicker.addTarget(self, action: #selector(pickerDateChengedValue), for: .valueChanged)
        
        setupCornerRadius()
        toolbar()
    }
    
    func postRegister() {
            let params: [String : String] = [
                "name":nameTFSignup.text!,
                "phone":phoneNumberTF.text!,
                "birthday":dataTF.text!,
                "password":passwordTF.text!
            ]
        AF.request(base_URL + "/api/users", method: .post, parameters: params, encoding: URLEncoding.queryString).responseJSON { response in
            
            let status = response.response?.statusCode
            switch status {
            case 200:
                if let data = response.data {
                    let d = JSON(data)
                    print(d, "Register data:")
                    let token = d["token"].stringValue
                    print(token, "token")
                    Cache.saveUserToken(token: token)
                    
                    let vc = Tabbar()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
            case 400:
                print(response.error?.errorDescription)
            default:
                break
            }
            
        }
    }
    func postLogin() {
            
            let params: [String : String] = [
                "phone":phoneNumberTF.text!,
                "password":passwordTF.text!
            ]
            
        AF.request(base_URL + "/api/auth", method: .post, parameters: params, encoding: URLEncoding.queryString).responseJSON { response in
            let status = response.response?.statusCode
            
            switch status {
            case 200:
                let d = JSON(response.data)
                let token = d["token"].stringValue
                print(token)
                Cache.saveUserToken(token: token)
                let vc = Tabbar()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            case 400:
                print(response.error?.errorDescription)
            case 403:
                print(response.error?.errorDescription)
            default:
                break
            }
        }
    }
    
    @objc func pickerDateChengedValue() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dataTF.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    func toolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.isTranslucent = true
        let selectedBtn = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBtnPressed))
        var spaceBtn =  UIBarButtonItem()
        if #available(iOS 14.0, *) {
            spaceBtn =  UIBarButtonItem(systemItem: .flexibleSpace)
        } else {
            // Fallback on earlier versions
        }
        selectedBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dataTF.inputAccessoryView = toolbar
        //passwordTF.inputAccessoryView = toolbar
        toolbar.items = [spaceBtn,selectedBtn]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tap)
    }
    @objc func tapped(){
        self.view.endEditing(true)
    }
    
    func setupCornerRadius(){
        loginBtn.layer.cornerRadius = loginBtn.bounds.height * 0.3
        
        topConteinerView.layer.cornerRadius = topConteinerView.bounds.height * 0.1
        topConteinerView.backgroundColor = .white
        topConteinerView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        topConteinerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        topConteinerView.layer.shadowRadius = 3
        topConteinerView.layer.shadowOpacity = 0.5
        nameStack.isHidden = true
        brithDayStack.isHidden = true
        
        if UIScreen.main.bounds.height < 650{
            heightForBtn.constant = 40
            heightForStack.constant = 45
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if isPressed{
            postRegister()
            print("register btn")
        }else{
            postLogin()
            print("login btn")
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        forgotPasscode.isHidden = false
        nameStack.isHidden = true
        brithDayStack.isHidden = true
        phoneNumberTF.text = ""
        passwordTF.text = ""
        UIView.animate(withDuration: 0.3) { [self] in
            self.lineView.transform = .identity
        }
        isPressed = false
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        nameStack.isHidden = false
        brithDayStack.isHidden = false
        forgotPasscode.isHidden = true
        phoneNumberTF.text = ""
        passwordTF.text = ""
        UIView.animate(withDuration: 0.3) { [self] in
            self.lineView.transform = CGAffineTransform(translationX:lineView.bounds.width, y: 0)
        }
        isPressed = true
    }
    @objc func selectBtnPressed() {
        if passwordTF.isFirstResponder {
            passwordTF.resignFirstResponder()
            dataTF.becomeFirstResponder()
        } else {
            dataTF.resignFirstResponder()
        }
    }
    
}
