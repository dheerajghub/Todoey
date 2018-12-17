//
//  Category.swift
//  Todoey
//
//  Created by Dheeraj Kumar Sharma on 15/12/18.
//  Copyright © 2018 Dheeraj Kumar Sharma. All rights reserved.
//

import Foundation
import RealmSwift 

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
