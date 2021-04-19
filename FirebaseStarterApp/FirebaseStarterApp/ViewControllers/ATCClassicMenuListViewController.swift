//
//  ATCClassicMenuListViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/26/21.
//

import UIKit

weak var refView = ATCClassicMainViewController()

class ATCClassicMenuListViewController: UITableViewController {

    var items = ["Profile", "Setting", "Log Out", "About Us"]
    
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
        if (items[indexPath.row] == "Profile") {
            refView?.dismiss(animated: true, completion: nil)
            let ProfileVC = ATCClassicProfileViewController(nibName: "ATCClassicProfileViewController", bundle: nil)
            refView?.navigationController?.pushViewController(ProfileVC, animated: true)
        }
        else if (items[indexPath.row] == "Setting") {
            refView?.dismiss(animated: true, completion: nil)
            refView?.performSegue(withIdentifier: "toSettingSegue", sender: self)
        }
        else if (items[indexPath.row] == "Log Out") {
            refView?.dismiss(animated: true, completion: nil)
            refView?.performSegue(withIdentifier: "BackToLoginSegue", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
