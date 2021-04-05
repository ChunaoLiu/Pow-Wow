//
//  SettingViewController.swift
//  Pow Wow
//
//  Created by 刘淳傲 on 4/3/21.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var Account: UILabel!
    @IBOutlet weak var About_Us: UILabel!
    @IBOutlet weak var left_menu: UITextView!
    @IBOutlet weak var Setting_Font: UITextView!
    
    
    @IBAction func onReturn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAccount(_ sender: Any) {
        print("Yoo")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Account.isUserInteractionEnabled = true
        addTopBorder(with: .gray, andWidth: 3.0, andSubject: left_menu)
        addRightBorder(with: .gray, andWidth: 3.0, andSubject: left_menu)
        addBottomBorder(ith: .gray, andWidth: 3.0, andSubject: Setting_Font)
        addLeftBorder(with: .gray, andWidth: 3.0, andSubject: Setting_Font)
        addBottomBorder(ith: .gray, andWidth: 3.0, andSubject: Account)
        addBottomBorder(ith: .gray, andWidth: 3.0, andSubject: About_Us)

        // Do any additional setup after loading the view.
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat, andSubject subject: UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: subject.frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        subject.addSubview(border)
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat, andSubject subject: UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: subject.frame.size.width, height: borderWidth)
        subject.addSubview(border)
    }
    
    func addBottomBorder(ith color: UIColor?, andWidth borderWidth: CGFloat, andSubject subject: UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: subject.frame.size.height - borderWidth, width: subject.frame.size.width, height: borderWidth)
        subject.addSubview(border)
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat, andSubject subject: UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: subject.frame.size.width - borderWidth, y: 0, width: borderWidth, height: subject.frame.size.height)
        subject.addSubview(border)
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
