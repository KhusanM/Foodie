//
//  CheckoutVC.swift
//  Foodie
//
//  Created by Kh's MacBook on 04.07.2021.
//

import UIKit

class CheckoutVC: UIViewController {

    
    
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var textView: UIView!{
        didSet{
            textView.layer.cornerRadius = textView.bounds.height * 0.2
        }
    }
    @IBOutlet weak var paymentView: UIView!{
        didSet{
            paymentView.layer.cornerRadius = paymentView.bounds.height * 0.2
        }
    }
    @IBOutlet weak var bottomView: UIView!{
        didSet{
            bottomView.layer.cornerRadius = bottomView.bounds.height * 0.2
        }
    }
    @IBOutlet weak var redBtn: UIButton!{
        didSet{
            redBtn.layer.cornerRadius = redBtn.bounds.height / 2
        }
    }
    @IBOutlet weak var circleRedImg: UIImageView!
    @IBOutlet weak var circleGrayImg: UIImageView!
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var shadowBtn: UIButton!
    @IBOutlet weak var middleView: UIView!{
        didSet{
            middleView.layer.cornerRadius = middleView.bounds.height * 0.15
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        title = "Checkout"
    }

    @IBAction func procedBtnTapped(_ sender: Any) {
    }
    @IBAction func shadowBtnTapped(_ sender: Any) {
        shadowBtn.isHidden = true
        middleView.isHidden = true
    }
    
    @IBAction func cardBtnTapped(_ sender: Any) {
        cardImg.image = #imageLiteral(resourceName: "circleRed")
        bankImg.image = #imageLiteral(resourceName: "circleGray")
    }
    @IBAction func bankBtnTapped(_ sender: Any) {
        cardImg.image = #imageLiteral(resourceName: "circleGray")
        bankImg.image = #imageLiteral(resourceName: "circleRed")
        bankImg.tintColor = .red
    }
    
    @IBAction func pickBtnTapped(_ sender: Any) {
        circleRedImg.image = #imageLiteral(resourceName: "circleGray")
        circleGrayImg.image = #imageLiteral(resourceName: "circleRed")
        circleGrayImg.tintColor = .red
    }
    @IBAction func doorBtnTapped(_ sender: Any) {
        circleRedImg.image = #imageLiteral(resourceName: "circleRed")
        circleGrayImg.image = #imageLiteral(resourceName: "circleGray")
    }
    @IBAction func changeBtnTapped(_ sender: Any) {
        changeBtn.isHidden = true
        adressLbl.text = "Payment method"
        textView.isHidden = true
        paymentView.isHidden = false
    }
    @IBAction func redBtnTapped(_ sender: Any) {
        middleView.isHidden = false
        shadowBtn.isHidden = false
    }
    
}
