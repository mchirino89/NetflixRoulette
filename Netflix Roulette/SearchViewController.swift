//
//  SearchViewController.swift
//  Netflix Roulette
//
//  Created by Mauricio Chirino on 20/3/16.
//  Copyright © 2016 Mauricio Chirino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate  {

    @IBOutlet var searchType: UIPickerView!
    let pickerData = ["Title", "Director", "Actor/Actress"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchType.dataSource = self
        self.searchType.delegate = self
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
         print("Selected: ", pickerData[row])
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!, NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
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
