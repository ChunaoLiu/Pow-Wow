//
//  ATCClassicMainViewController.swift
//  Pow Wow
//

//  Created by 刘淳傲 on 3/24/21.
//

import Foundation
import UIKit
import AlamofireImage
import SideMenu
import FirebaseAuth

class ATCClassicMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ConfirmFilter: UIButton!
    @IBOutlet weak var TypeFilter: UITextField!
    var menu : SideMenuNavigationController?
    let SignInManager = FirebaseAuthManager()
    var selectedType: String?
    var TypeList = ["All", "Business", "Psychology", "Programming", "Gaming", "Meme"]
    
    @IBOutlet weak var SelectedFilter: UISegmentedControl!
    
    @IBAction func ProfileButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    var profiles: [Pro] = [] // All the profiles rendered to tableView
    
    let FirebaseDataManager = FirebaseDataAccessManager()
    
    @IBOutlet weak var tableView: UITableView! // Main table view on view controller
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createArray()
    }
    
    func createArray() {
        var tempProfiles: [Pro] = [] // Array of Pro objects used to return profiles to tableView
        
        // I'll place system image for now to test how it looks
        
        FirebaseDataManager.getAllUser { (ProList) in
            tempProfiles = ProList
            self.profiles = tempProfiles
            print("Count in createArray function is: " + String(self.profiles.count))
            self.tableView.reloadData()
        }
    }
    
    func createFilteredArray(Input_type: String, Input_keyword: String) {
        var tempProfiles: [Pro] = [] // Array of Pro objects used to return profiles to tableView
        
        FirebaseDataManager.getFilteredUser (type: Input_type, keyword: Input_keyword){  (ProList) in
            tempProfiles = ProList
            self.profiles = tempProfiles
            print("Count in function is: " + String(self.profiles.count))
            self.tableView.reloadData()
        }
    }
    
    func callAlart(title: String, message:String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Action) in
            completion()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onConfirmFilter(_ sender: Any) {
        print("Changed!")
        var SelectedType = ""
        switch self.SelectedFilter.selectedSegmentIndex {
        case 0:
            SelectedType = "All"
        case 1:
            SelectedType = "Consultant"
        case 2:
            SelectedType = "Employer"
        default:
            break;
        }
        self.createFilteredArray(Input_type: SelectedType, Input_keyword: self.TypeFilter.text!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if (Auth.auth().currentUser == nil) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refView = self
        
        self.tableView.register(UINib(nibName: "TableviewCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        
        self.ConfirmFilter.layer.borderWidth = 0.5
        self.ConfirmFilter.layer.cornerRadius = 0.2 * self.ConfirmFilter.bounds.size.width
        
        self.ConfirmFilter.clipsToBounds = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        definesPresentationContext = true
        // Initialize the SideMenu When it loads
        menu = SideMenuNavigationController(rootViewController: ATCClassicMenuListViewController())
        // Menu will pop up at left
        menu?.leftSide = true
        
        createArray() // Calls createArray() function to update profiles array
        
        // Let the SideMenuManager take control over the left menu
        SideMenuManager.default.leftMenuNavigationController = menu
        // This allow the user to scroll right to see the menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        self.createAndSetupPickerView()
        self.dismissAndClosePickerView()

        // Do any additional setup after loading the view.
    }
    
    func createAndSetupPickerView(){
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        self.TypeFilter.inputView=pickerview
    }
    
    // This will change the text field to a picker
    func dismissAndClosePickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(self.dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.TypeFilter.inputAccessoryView = toolBar
    }
    
    @objc func dismissAction(){
        self.view.endEditing(true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Allocates space
        return profiles.count // Returns number of profiles in tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = profiles[indexPath.row] // Current profile set to index indexPath.row of profiles array
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        
        cell.setProfile(profile: profile) // Current profile set to current cell
        
        return cell // Returns current profile cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = profiles[indexPath.row]
        let otherProfile = ATCClassicOtherProfileViewController(nibName: "ATCClassicOthersProfileViewController", bundle: nil)
        otherProfile.BannerImage = profile.banner
        otherProfile.IconImage = profile.image
        otherProfile.UName = profile.name
        otherProfile.UBio = profile.description
        otherProfile.UType = profile.type
        otherProfile.UKeywords = profile.keywords
        
        self.navigationController?.pushViewController(otherProfile, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// Extending ATCClassicMainViewController for a picker
extension ATCClassicMainViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.TypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.TypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedType = self.TypeList[row]
        self.TypeFilter.text = self.selectedType
    }
}

