//
//  ToDoItem.swift
//  ToDoWithRealm
//
//  Created by Allan Spreys on 22/04/2023.
//

import Realm

final class ToDoItem: RLMObject {
  @objc dynamic var name = ""
  @objc dynamic var finished = false
}
