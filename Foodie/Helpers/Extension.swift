//
//  Extension.swift
//  Foodie
//
//  Created by Kh's MacBook on 23.07.2021.
//

import UIKit


//MARK: - UINavigation Bar
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        self.setValue(value, forKey: "hidesShadow")
    }
}


