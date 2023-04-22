//
//  AddViewController.swift
//  ToDoWithRealm
//
//  Created by Allan Spreys on 22/04/2023.
//

import UIKit
import Realm

final class AddViewController: UIViewController {
  private(set) lazy var textField: UITextField = {
    let textFiled = UITextField(frame: .zero)
    textFiled.translatesAutoresizingMaskIntoConstraints = false
    textFiled.placeholder = "Type in item"
    textFiled.delegate = self
    return textFiled
  }()

  var newItemText: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTextField()
    setupNavigationBar()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textField.becomeFirstResponder()
  }

  func setupTextField() {
    view.addSubview(textField)

    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
    ])
  }

  func setupNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
  }

  @objc func doneAction() throws {
    let realm = RLMRealm.default()
    if let name = textField.text, !name.isEmpty {
      let newItem = ToDoItem()
      newItem.name = name
      try realm.transaction {
        realm.add(newItem)
      }
    }
    navigationController?.popViewController(animated: true)
  }
}

extension AddViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    try? doneAction()
    textField.resignFirstResponder()
    return true
  }
}
