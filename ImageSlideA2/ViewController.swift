//
//  ViewController.swift
//  ImageSlideA2
//
//  Created by admin on 4/7/2559 BE.
//  Copyright © 2559 All2Sale. All rights reserved.
//

import UIKit
import Auk

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //scrollView.auk.show(url: "http://sunny-juof.com/app/banner/1.png")
        
        for autoImage in Banner.remoteImages {
            //let url = "\(Banner.remoteImageBaseUrl)\(remoteImages.fileName)"
            let url = "\(Banner.remoteImageBaseUrl)\(autoImage.fileName)"
            print(url)
            scrollView.auk.show(url: url)
            scrollView.auk.startAutoScroll(delaySeconds: 2)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

