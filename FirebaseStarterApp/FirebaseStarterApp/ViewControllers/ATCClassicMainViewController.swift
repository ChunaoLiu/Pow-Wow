//
//  ATCClassicMainViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/24/21.
//

import UIKit
import AlamofireImage
import SideMenu

class ATCClassicMainViewController: UIViewController {
    
    @IBOutlet weak var TypeFilter: UITextField!
    var menu : SideMenuNavigationController?
    var selectedType: String?
    var TypeList = ["Business", "Psychology", "Programming", "Gaming", "Meme"]
    
    @IBAction func ProfileButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBOutlet weak var ConsultantCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refView = self
        definesPresentationContext = true
        // Initialize the SideMenu When it loads
        menu = SideMenuNavigationController(rootViewController: ATCClassicMenuListViewController())
        // Menu will pop up at left
        menu?.leftSide = true
        
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
