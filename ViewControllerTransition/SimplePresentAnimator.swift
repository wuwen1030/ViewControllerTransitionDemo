//
//  SimplePresentAnimator.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/20.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

// 显示 Animator
class SimplePresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 目标View Controller
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let screenBounds = UIScreen.mainScreen().bounds
        toViewController?.view.frame = CGRectOffset(screenBounds, screenBounds.size.width, 0)
        
        // 容器View
        let containerView = transitionContext.containerView()
        containerView.addSubview((toViewController?.view)!)
        
        // 动画
        UIView.animateWithDuration(transitionDuration(transitionContext),
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                toViewController?.view.frame = screenBounds
            },
            completion: { (finished) -> Void in
                transitionContext.completeTransition(true)
            })
    }
}
