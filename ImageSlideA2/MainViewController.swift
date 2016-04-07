//
//  MainViewController.swift
//  ImageSlideA2
//
//  Created by admin on 4/7/2559 BE.
//  Copyright © 2559 All2Sale. All rights reserved.
//

import UIKit
import Auk

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell0 = tableView.dequeueReusableCellWithIdentifier("tableCell0")
        
        return cell0!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        for autoImage in Banner.remoteImages {
            //let url = "\(Banner.remoteImageBaseUrl)\(remoteImages.fileName)"
            let url = "\(Banner.remoteImageBaseUrl)\(autoImage.fileName)"
            print(url)
            scrollView.auk.show(url: url)
            scrollView.auk.startAutoScroll(delaySeconds: 2)
            
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
