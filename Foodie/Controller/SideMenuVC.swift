//
//  SideMenuVC.swift
//  Foodie
//
//  Created by Kh's MacBook on 19.07.2021.
//

import UIKit

protocol MenuDelegate {
    func backTo()
}

class SideMenuVC: UIViewController {

    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var widthForStack: NSLayoutConstraint!{
        didSet{
            if UIScreen.main.bounds.height < 650{
                widthForStack.constant = 190
            }
        }
    }
    
    var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conteinerView.transform = CGAffineTransform(translationX: -conteinerView.bounds.width, y: 0)
            
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {[self] in
            conteinerView.transform = .identity
            
        }
    }

    
    
    @IBAction func dismissBtnTapped(_ sender: Any) {
        self.delegate?.backTo()
        UIView.animate(withDuration: 1) {
            self.conteinerView.transform = CGAffineTransform(translationX: -self.conteinerView.bounds.width, y: 0)
            
        }completion: { (_) in
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func profilButton(_ sender: Any) {
        let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ordersButton(_ sender: Any) {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func branchesButton(_ sender: Any) {
        let vc = BranchesMapVC(nibName: "BranchesMapVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func privacybutton(_ sender: Any) {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func securityButton(_ sender: Any) {
    }
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        Cache.saveUserToken(token: nil)
       if let window = UIApplication.shared.keyWindow{
        window.rootViewController = WelcomeVC(nibName: "WelcomeVC", bundle: nil)
        }
    }

}
