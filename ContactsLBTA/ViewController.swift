//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by De La Cruz, Eduardo on 27/02/2019.
//  Copyright © 2019 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellID = "cellID"
    
    let twoDimentionalArray = [["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"], ["Carl", "Chris", "Christina", "Cameron"], ["David", "Dan"], ["Patric", "Patty"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    @objc func handleShowIndexPath() {
        var pairIndicesArray = [IndexPath]()
        var oddIndicesArray = [IndexPath]()
        
        for section in twoDimentionalArray.indices {
            for row in twoDimentionalArray[section].indices {
                if row % 2 == 0 {
                    pairIndicesArray.append(IndexPath(row: row, section: section))
                } else {
                    oddIndicesArray.append(IndexPath(row: row, section: section))
                }
            }
        }
        
        tableView.reloadRows(at: pairIndicesArray, with: .left)
        tableView.reloadRows(at: oddIndicesArray, with: .right)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = .lightGray
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimentionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimentionalArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name = twoDimentionalArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(name) Section: \(indexPath.section) Row: \(indexPath.row)"
        
        return cell
    }
}
