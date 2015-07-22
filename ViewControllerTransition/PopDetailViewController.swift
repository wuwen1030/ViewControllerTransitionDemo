//
//  PopDetailViewController.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/21.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class PopDetailViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            if let aImageView = imageView {
                imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
