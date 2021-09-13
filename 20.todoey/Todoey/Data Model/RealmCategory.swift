//
//  Data.swift
//  Todoey
//
//  Created by Debora Del Vecchio on 13/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCategory: Object {
    @Persisted var name: String = ""
    @Persisted var items: List<RealmToDoItem> = List()
    @Persisted var color: String
}
