//
//  SearchViewController.swift
//  Netflix Roulette
//
//  Created by Mauricio Chirino on 20/3/16.
//  Copyright © 2016 Mauricio Chirino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet var query: UITextField!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet var searchButton: UIButton!
    let pickerData = ["Title", "Director", "Actor/Actress"]
    var selectedType:Int = 0;
    var found = false;
    var queryResult : NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        query.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning");
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searching()
        return true
    }
    
    @IBAction func searchingQuery(sender: AnyObject) {
        query.resignFirstResponder()
        searching()
    }
    
    func searching() {
        isSerching(true)
        if let movie = query.text {
            let scriptUrl = "https://community-netflix-roulette.p.mashape.com/api.php?"
            let queryString = movie.stringByReplacingOccurrencesOfString(" ", withString: "+")
            let urlWithParams = scriptUrl + pickerData[selectedType] + "=\(queryString)"
            let myUrl = NSURL(string: urlWithParams.lowercaseString);
            let request = NSMutableURLRequest(URL:myUrl!);
            request.HTTPMethod = "GET"
            request.addValue("6g0AoCy9XomshdcqFcmjyAQLFAcFp11wQM0jsn88drQaix06wW", forHTTPHeaderField: "X-Mashape-Key")
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                if error != nil {
                    print("error=\(error)")
                    return
                }
                do {
                    if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        let errorCode = convertedJsonIntoDict["errorcode"] as? Int
                        if errorCode == 404 {
                            self.queryResult = ["Message": (convertedJsonIntoDict["message"] as? String)!]
                        }
                        else{
                            self.queryResult = convertedJsonIntoDict
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            self.isSerching(false)
                            self.query.text = ""
                            self.performSegueWithIdentifier("movieDetail", sender: self)
                        })
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        else{
            print("No query typed!")
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "movieDetail") {
            let destinationController = (segue.destinationViewController as! MovieDetailViewController)
            destinationController.result = self.queryResult
        }
    }

    func isSerching(searching: Bool) {
        if searching {
            loader.startAnimating()
        }
        else{
            loader.stopAnimating()
            loader.hidden = true
        }
        query.enabled = !searching;
        searchButton.enabled = !searching;
    }

}
