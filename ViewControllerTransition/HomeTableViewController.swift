//
//  HomeTableViewController.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/20.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let modalTransition = ModalTrainsition(animationType: ModalAnimationType.simple)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func modalControllerDismiss(sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "modalViewController" {
            let destinationViewController = segue.destinationViewController as! UIViewController
            destinationViewController.transitioningDelegate = modalTransition
            modalTransition.interactiveDismissAnimator.wireToViewController(destinationViewController)
        }
    }
}
