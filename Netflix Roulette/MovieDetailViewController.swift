//
//  MovieDetailViewController.swift
//  Netflix Roulette
//
//  Created by Mauricio Chirino on 21/3/16.
//  Copyright © 2016 Mauricio Chirino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var result : NSDictionary?
    var data: NSData?
    
    @IBOutlet var poster: UIImageView!
    @IBOutlet var noLuckMsg: UILabel!
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var year: UILabel!
    
    @IBOutlet var movieDirector: UILabel!
    
    @IBOutlet var movieDesc: UITextView!
    
    @IBOutlet var movieCast: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (result!["Message"] != nil) {
            noLuckMsg.hidden = false
            movieCast.hidden = true
            movieDesc.hidden = true
            movieDirector.hidden = true
            movieTitle.hidden = true
            poster.hidden = true
            year.hidden = true
        }
        else{
            if let movieDetails = result {
                //let url = NSURL(string:movieDetails["poster"] as! String)

                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    
                    self.poster.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:movieDetails["poster"] as! String)!)!)
                    
                })
                
                
                movieTitle.text = (movieDetails["show_title"] as! String)
                year.text = (movieDetails["release_year"] as! String)
                movieDirector.text = (movieDetails["director"] as! String)
                movieCast.text = (movieDetails["show_cast"] as! String)
                movieDesc.text = (movieDetails["summary"] as! String)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if data != nil {
            poster.image = UIImage(data:data!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
