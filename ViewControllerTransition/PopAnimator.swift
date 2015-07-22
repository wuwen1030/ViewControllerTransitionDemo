//
//  PopAnimator.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/21.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()

        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PushCollectionViewController
        let destImageView = toViewController.selectedImageView
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)

        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PopDetailViewController
        let sourceImageView = fromViewController.imageView
        
        let snapView = sourceImageView?.snapshotViewAfterScreenUpdates(false)
        snapView?.frame = containerView.convertRect(sourceImageView!.frame, fromView: sourceImageView!.superview)

//        let destSnapFrame = containerView.convertRect(destImageView!.frame, fromView: destImageView!.superview)
        let destSnapFrame = toViewController.imageRect

        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        containerView.addSubview(snapView!)
        destImageView?.hidden = true
        sourceImageView.hidden = true


        UIView.animateWithDuration(transitionDuration(transitionContext),
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                fromViewController.view.alpha = 0
                snapView?.frame = destSnapFrame
            },
            completion: { (finished) -> Void in
                snapView?.removeFromSuperview()
                destImageView?.hidden = false
                sourceImageView.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }

}
