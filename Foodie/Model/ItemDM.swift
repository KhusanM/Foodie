//
//  ItemDM.swift
//  Foodie
//
//  Created by Kh's MacBook on 09.07.2021.
//

import Foundation
import RealmSwift

class ItemDM: Object {
    @objc dynamic var _id : String?
    @objc dynamic var name: String?
    @objc dynamic var cost: Int = 0
    @objc dynamic var discription: String?
    @objc dynamic var count: Int = 1
    var photo: List<PhotoDM> = List<PhotoDM>()
    
    override class func primaryKey() -> String? {
        "_id"
    }
}


class PhotoDM: Object {
    @objc dynamic var url: String?
}
