//
//  TodoItem.swift
//  Todoey
//
//  Created by Debora Del Vecchio on 10/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var content: String
    var checked: Bool = false
}
