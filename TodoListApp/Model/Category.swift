//
//  Category.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 09/12/2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
