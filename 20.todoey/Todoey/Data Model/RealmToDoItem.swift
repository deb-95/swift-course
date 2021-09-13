//
//  RealmToDoItem.swift
//  Todoey
//
//  Created by Debora Del Vecchio on 13/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class RealmToDoItem: Object {
    @Persisted var content: String = ""
    @Persisted var checked: Bool = false
    @Persisted var dateCreated: Date

    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<RealmCategory>
}
