//
//  PushAnimator.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/21.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PushCollectionViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PopDetailViewController
        let containerView = transitionContext.containerView()
        
        let selectedImageView = fromViewController.selectedImageView
        let snapView = selectedImageView?.snapshotViewAfterScreenUpdates(false)
        let snapFrame = containerView.convertRect(selectedImageView!.frame, fromView: selectedImageView!.superview)
        snapView?.frame = snapFrame
        fromViewController.imageRect = snapFrame
        selectedImageView?.hidden = true
        
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
        toViewController.imageView.hidden = true
        toViewController.view.layoutIfNeeded()
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapView!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                toViewController.view.alpha = 1
                snapView?.frame = containerView.convertRect(toViewController.imageView.frame, fromView: toViewController.view)
            },
            completion: { (finished) -> Void in
                snapView?.removeFromSuperview()
                toViewController.imageView.hidden = false
                selectedImageView?.hidden = false
                transitionContext.completeTransition(true)
            })
    }
}
