//
//  PushCollectionViewController.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/21.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class PushCollectionViewController: UICollectionViewController {
    
    var selectedImageView:UIImageView?
    var imageRect = CGRectZero
    let navigationTransition = NavigationTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = navigationTransition
        navigationTransition.wireToNavigationController(navigationController!)
    }
    
    deinit {
        navigationController?.delegate = nil
    }
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let cell = sender as! UICollectionViewCell
            let imageView = cell.contentView.viewWithTag(100)
            if let aView = imageView {
                let detailController = segue.destinationViewController as! PopDetailViewController
                detailController.image = (imageView as! UIImageView).image
                selectedImageView = imageView as? UIImageView
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        return cell
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    }
}
