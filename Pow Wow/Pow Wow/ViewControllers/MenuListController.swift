//
//  MenuListController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/26/21.
//

import UIKit

weak var refView = HomeViewController()

class MenuListController: UITableViewController {

    var items = ["Consultant Profile", "Business Profile", "Setting", "Log Out", "About Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    let darkColor = UIColor(red: 33/255.0,
                            green: 33/255.0,
                            blue: 33/255.0, alpha: 1)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (items[indexPath.row] == "Consultant Profile") {
            refView?.dismiss(animated: true, completion: nil)
            refView?.performSegue(withIdentifier: "HomeToPersonalProfile", sender: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
