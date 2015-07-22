//
//  SimpleDismissAnimator.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/20.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class SimpleDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let screenBounds = UIScreen.mainScreen().bounds
        
        let containerView = transitionContext.containerView()
        toViewController?.view.frame = screenBounds
        containerView.addSubview((toViewController?.view)!)
        containerView.sendSubviewToBack((toViewController?.view)!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                fromViewController?.view.frame = CGRectOffset(screenBounds, screenBounds.size.width, 0)
            },
            completion: { (finished) -> Void in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
                if cancelled {
                    toViewController?.view.removeFromSuperview()
                }
            })
    }
}
