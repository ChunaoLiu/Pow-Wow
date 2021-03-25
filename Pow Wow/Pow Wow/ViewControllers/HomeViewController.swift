//
//  HomeViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 3/24/21.
//

import UIKit
import AlamofireImage
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var TypeFilter: UITextField!
    var selectedType: String?
    var TypeList = ["Business", "Psychology", "Programming", "Gaming", "Meme"]
    
    @IBAction func ProfileButton(_ sender: Any) {
        let menu = SideMenuNavigationController(rootViewController: HomeViewController)
        present(menu, animated: true, completion: nil)
    }
    
    @IBOutlet weak var ConsultantCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Bubble")
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

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
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
