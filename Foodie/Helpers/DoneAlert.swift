//
//  DoneAlert.swift
//  Foodie
//
//  Created by Kh's MacBook on 22.07.2021.
//

import UIKit
import SnapKit
import Lottie

class DoneAlert{
    
    static var completion: ((Bool) -> Void)?
    
    class func showAlert(title: String){
        
        let viewController = UIViewController()
        
        let backView = UIButton(frame: UIScreen.main.bounds)
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        
        let containerView = UIView()
        
        let titleLbl: UILabel = {
            let l = UILabel()
            l.text = title
            l.textAlignment = .center
            l.textColor = .black
            l.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            
            return l
        }()
        
        let animationView: AnimationView = {
            let v = AnimationView(name: "done")
           
            return v
        }()
        
        let okBtn: UIButton = {
            let b = UIButton()
            b.setTitle("Ok", for: .normal)
            b.layer.cornerRadius = 10
            b.backgroundColor = .systemBlue
            b.addTarget(self, action: #selector(okBtnTapped), for: .touchUpInside)
            return b
        }()
        
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        animationView.play()
        
        backView.tag = 511
        
        backView.addSubview(containerView)
        
        
        containerView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(16)
            m.centerX.equalToSuperview()
        }
        
        containerView.addSubview(animationView)
        
        animationView.snp.makeConstraints { (m) in
            m.height.equalTo(100)
            m.width.equalTo(100)
            m.centerX.equalToSuperview()
            m.top.equalTo(titleLbl.snp.bottom).offset(10)
        }
        
        
        
        containerView.addSubview(okBtn)
        okBtn.snp.makeConstraints { (m) in
            m.height.equalTo(50)
            m.right.equalToSuperview().offset(-10)
            m.left.equalToSuperview().offset(10)
            m.bottom.equalToSuperview().offset(-10)
            m.top.equalTo(animationView.snp.bottom).offset(10)
        }
        
        containerView.snp.makeConstraints { (m) in
            m.center.equalTo(backView)
            
            m.left.equalToSuperview().offset(20)
            m.right.equalToSuperview().offset(-20)
            
        }
        
        if let window = UIApplication.shared.keyWindow {
            if let v = window.viewWithTag(511) {
                v.removeFromSuperview()
            }
            window.addSubview(backView)
        }
        
        
        containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseIn]) {
            containerView.transform = .identity
        } completion: { (_) in }
        
        
    }
    
    @objc private class func okBtnTapped(){
        removeFromSuperView()
    }
    
    
    private class func removeFromSuperView() {
        if let _ = UIApplication.shared.keyWindow {
            if let vi = UIApplication.shared.keyWindow?.viewWithTag(511) {
                vi.removeFromSuperview()
                self.completion = nil
            }
        }
    }
}
