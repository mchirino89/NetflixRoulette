//
//  SearchViewController.swift
//  Netflix Roulette
//
//  Created by Mauricio Chirino on 20/3/16.
//  Copyright © 2016 Mauricio Chirino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate  {
    @IBOutlet var query: UITextField!
    @IBOutlet var searchType: UIPickerView!
    let pickerData = ["Title", "Director", "Actor/Actress"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        searchType.dataSource = self
        searchType.delegate = self
        query.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning");
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        query.placeholder = "Search for " + pickerData[row].lowercaseString
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: pickerData[row], attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!, NSForegroundColorAttributeName:UIColor(red:CGFloat((0xAE0D14 & 0xFF0000) >> 16)/256.0, green:CGFloat((0xAE0D14 & 0xFF00) >> 8)/256.0, blue:CGFloat(0xAE0D14 & 0xFF)/256.0, alpha:1.0)])
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        query.resignFirstResponder()
        if let movie = query.text {
            print("Searching for: ", movie.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
        }
        else{
            print("No query typed!")
        }

        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
