//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by De La Cruz, Eduardo on 27/02/2019.
//  Copyright © 2019 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Global variables
    
    let cellID = "cellID"
    var twoDimentionalArray = [
        ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"].map { Contact(name: $0, isFavourite: false) },
        ["Carl", "Chris", "Christina", "Cameron"].map { Contact(name: $0, isFavourite: false) },
        ["David", "Dan"].map { Contact(name: $0, isFavourite: false) },
        ["Patric", "Patty"].map { Contact(name: $0, isFavourite: false) }
        ].map { ExpandableNames(isExpanded: true, contacts: $0) }
    var showIndexPaths = false
    
    // MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = .orange
        label.textAlignment = .center
        let button = UIButton(type: .system)
        button.setTitle("Collapse", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handelExpandClose), for: .touchUpInside)
        button.tag = section
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        return stackView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimentionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if twoDimentionalArray[section].isExpanded {
            return twoDimentionalArray[section].contacts.count
        } else {
            return 0
        }
    }
    
    // MARK: - TableView data sourse methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDimentionalArray[indexPath.section].contacts[indexPath.row]
        var navBarButtonTitle = String()
        
        cell.accessoryView?.tintColor = contact.isFavourite ? UIColor.red : .lightGray
        
        if showIndexPaths {
            cell.textLabel?.text = "\(contact.name) Section: \(indexPath.section) Row: \(indexPath.row)"
            navBarButtonTitle = "Hide IndexPath"
        } else {
            cell.textLabel?.text = contact.name
            navBarButtonTitle = "Show IndexPath"
        }
        
        navigationItem.rightBarButtonItem?.title = navBarButtonTitle
        return cell
    }
    
    // MARK: - Custom methods
    
    @objc func handleShowIndexPath() {
        var pairIndicesArray = [IndexPath]()
        var oddIndicesArray = [IndexPath]()
        for section in twoDimentionalArray.indices {
            if twoDimentionalArray[section].isExpanded {
                for row in twoDimentionalArray[section].contacts.indices {
                    if row % 2 == 0 {
                        pairIndicesArray.append(IndexPath(row: row, section: section))
                    } else {
                        oddIndicesArray.append(IndexPath(row: row, section: section))
                    }
                }
            }
        }
        
        showIndexPaths = !showIndexPaths
        
        tableView.reloadRows(at: pairIndicesArray, with: .left)
        tableView.reloadRows(at: oddIndicesArray, with: .right)
    }
    
    @objc func handelExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        
        for row in twoDimentionalArray[section].contacts.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimentionalArray[section].isExpanded
        twoDimentionalArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Expand" : "Collapse", for: .normal)
        
        if twoDimentionalArray[section].isExpanded {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    func someMethodWantToCall(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        let contact = twoDimentionalArray[indexPathTapped.section].contacts[indexPathTapped.row]
        twoDimentionalArray[indexPathTapped.section].contacts[indexPathTapped.row].isFavourite = !contact.isFavourite
        cell.accessoryView?.tintColor = contact.isFavourite ? UIColor.lightGray : .red
    }
}
