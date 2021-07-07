//
//  Menu.swift
//  Foodie
//
//  Created by Oybek Iskandarov on 7/4/21.
//

import UIKit

class Menu: UIViewController {
    @IBOutlet weak var bigBackgroundView: UIView!
    @IBOutlet var menuViews: [UIView]!
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var bottomSignOutButton: UIView!
    @IBOutlet weak var buttonDismis: UIButton!
    @IBOutlet weak var smallViewBack: UIView!
    @IBOutlet var labels: [UILabel]!
    
    
    
    
    
    @IBOutlet var lines: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.981633842, green: 0.2908881307, blue: 0.04805722088, alpha: 1)
        if UIScreen.main.bounds.height < 650 {
            for l in lines {
                l.widthAnchor.constraint(equalToConstant: 100).isActive = true
                for m in menuViews {
                    l.rightAnchor.constraint(equalTo: m.rightAnchor, constant: -70).isActive = true
                }
            }
            for i in labels {
                i.font = UIFont.systemFont(ofSize: 13)
            }
            for u in menuViews {
                u.heightAnchor.constraint(equalToConstant: 45).isActive = true
                u.transform = CGAffineTransform(translationX: -200, y: 0)
            }
            self.signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            self.bottomSignOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            self.bottomSignOutButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
            self.bottomSignOutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        }
        for u in menuViews {
            u.transform = CGAffineTransform(translationX: -300, y: 0)
        }
        self.bottomSignOutButton.transform = CGAffineTransform(translationX: -300, y: 0)
    }
    @IBAction func menuButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.bigBackgroundView.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0).scaledBy(x: 0.66, y: 0.66)
            self.smallViewBack.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0).scaledBy(x: 0.66, y: 0.66)
            self.bigBackgroundView.layer.cornerRadius = 30
            self.smallViewBack.layer.cornerRadius = 30
            self.buttonDismis.isHidden = false
        } completion: { _ in
            UIView.animate(withDuration: 0.7) {
                self.smallViewBack.transform = CGAffineTransform(translationX: self.bigBackgroundView.frame.minY + 45 , y: 15).scaledBy(x: 0.66, y: 0.66)
            }
            self.smallViewBack.layer.cornerRadius = 30
        }
  
        UIView.animate(withDuration: 1.25) {
            self.menuViews[0].transform = CGAffineTransform(translationX: 0, y: 0)
         
        }
        UIView.animate(withDuration: 1.5) {
            self.menuViews[1].transform = CGAffineTransform(translationX: 0, y: 0)
        }
        UIView.animate(withDuration: 1.75) {
            self.menuViews[2].transform = CGAffineTransform(translationX: 0, y: 0)
         
        }
        UIView.animate(withDuration: 2) {
            self.menuViews[3].transform = CGAffineTransform(translationX: 0, y: 0)
        }
        UIView.animate(withDuration: 2.25) {
            self.menuViews[4].transform = CGAffineTransform(translationX: 0, y: 0)
        }
        UIView.animate(withDuration: 2.50) {
            self.bottomSignOutButton.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    @IBAction func menuDismisButton(_ sender: Any) {
            UIView.animate(withDuration: 1) {
                self.bigBackgroundView.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 1, y: 1)
                self.buttonDismis.isHidden = true
                self.bigBackgroundView.layer.cornerRadius = 0
            }
        UIView.animate(withDuration: 1.25) {
            self.menuViews[0].transform = CGAffineTransform(translationX: -300, y: 0)
         
        }
        UIView.animate(withDuration: 1.5) {
            self.menuViews[1].transform = CGAffineTransform(translationX: -300, y: 0)
        }
        UIView.animate(withDuration: 1.75) {
            self.menuViews[2].transform = CGAffineTransform(translationX: -300, y: 0)
         
        }
        UIView.animate(withDuration: 2) {
            self.menuViews[3].transform = CGAffineTransform(translationX: -300, y: 0)
        }
        UIView.animate(withDuration: 2.25) {
            self.menuViews[4].transform = CGAffineTransform(translationX: -300, y: 0)
        }
        UIView.animate(withDuration: 5) {
            self.bottomSignOutButton.transform = CGAffineTransform(translationX: -300, y: 0)
        }
    }
    
    
    @IBAction func profilButton(_ sender: Any) {
    }
    
    @IBAction func ordersButton(_ sender: Any) {
        
    }
    
    @IBAction func branchesButton(_ sender: Any) {
        let vc = BranchesMapVC(nibName: "BranchesMapVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func privacybutton(_ sender: Any) {
    }
    
    @IBAction func securityButton(_ sender: Any) {
    }
    
    
}
