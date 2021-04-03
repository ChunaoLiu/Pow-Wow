//
//  EditAuthViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 4/3/21.
//

import UIKit

class EditAuthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    var list = ["1", "2", "3"]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
     
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
     
    }
     
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
     
        return list.count
     
    }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        self.view.endEditing(true)
        return list[row]
     
    }
     
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        self.textBox.text = self.list[row]
        self.dropDown.isHidden = true
     
    }
     
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
        if textField == self.textBox {
            self.dropDown.isHidden = false
            //if you dont want the users to se the keyboard type:
     
            textField.endEditing(true)
        }
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
