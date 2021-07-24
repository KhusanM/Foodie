//
//  Tabbar.swift
//  Foodie
//
//  Created by Ahliddin on 7/5/21.
//

import UIKit

class Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = DeliciousFoodVC(nibName: "DeliciousFoodVC", bundle: nil)
        vc1.tabBarItem.image =  UIImage(named: "home")
        
        
        view.backgroundColor = #colorLiteral(red: 0.9313751459, green: 0.2852953076, blue: 0.2035402358, alpha: 1)
        
        let vc2 = DeliciousFoodVC(nibName: "DeliciousFoodVC", bundle: nil)
        vc2.tabBarItem.image = UIImage(named: "heartGray")
        

        

        let vc3 = OrderVC(nibName: "OrderVC", bundle: nil)
        vc3.tabBarItem.image = UIImage(systemName: "cart")
        
        
        let vc4 = ProfileVC(nibName: "ProfileVC", bundle: nil)
        vc4.tabBarItem.image = UIImage(named: "user")
        
        self.tabBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)

        
        tabBar.layer.shadowColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowOpacity = 1
            
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        
        viewControllers = [nav1,nav2,nav3,nav4]
        
        selectedIndex = 0

    }
    

  

}
