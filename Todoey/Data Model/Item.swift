//
//  Item.swift
//  Todoey
//
//  Created by Dheeraj Kumar Sharma on 15/12/18.
//  Copyright © 2018 Dheeraj Kumar Sharma. All rights reserved.
//


import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdAt: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

//func getDate() -> String{
//    let dateFormatterGet = DateFormatter()
//    dateFormatterGet.dateFormat = "dd MMM yyyy HH:mm"
//    
//    let dateFormatterPrint = DateFormatter()
//    dateFormatterPrint.dateFormat = "dd MMM yyyy HH:mm"
//    
//    if let date = dateFormatterGet.date(from: "29 Dec 2018 12:24") {
//        let newDate =  dateFormatterPrint.string(from: date)
//        return newDate
//    } else {
//        return "There was an error decoding the string"
//    }
//}
