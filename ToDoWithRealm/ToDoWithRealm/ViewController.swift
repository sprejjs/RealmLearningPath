//
//  ViewController.swift
//  ToDoWithRealm
//
//  Created by Allan Spreys on 22/04/2023.
//

import UIKit
import Realm

final class ViewController: UITableViewController {
  var todos: RLMResults<AnyObject> {
    ToDoItem.allObjects()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")

    setupNavigationBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Int(todos.count)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

    guard let todoItem = todos.object(at: UInt(indexPath.row)) as? ToDoItem else {
      return cell
    }

    cell.textLabel?.text = todoItem.name
    return cell
  }

  private func setupNavigationBar() {
    let addButton = UIBarButtonItem(systemItem: .add)
    addButton.primaryAction = UIAction { [weak self] _ in
      self?.navigationController?.pushViewController(AddViewController(), animated: true)
    }
    navigationItem.rightBarButtonItem = addButton
  }
}

