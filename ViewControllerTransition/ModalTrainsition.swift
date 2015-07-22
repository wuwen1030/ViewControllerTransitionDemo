//
//  ModalTrainsition.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/20.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

enum ModalAnimationType: Int {
    case simple
    case door
}

class ModalTrainsition: NSObject, UIViewControllerTransitioningDelegate{
    
    var animationType:ModalAnimationType
    
    var presentAnimator:UIViewControllerAnimatedTransitioning
    var dismissAnimator:UIViewControllerAnimatedTransitioning
    var interactiveDismissAnimator:ModalInteractiveAnimation
    
    init(animationType: ModalAnimationType) {
        self.animationType = animationType
        if animationType == ModalAnimationType.simple {
            presentAnimator = SimplePresentAnimator()
            dismissAnimator = SimpleDismissAnimator()
            interactiveDismissAnimator = ModalInteractiveAnimation(direction:InteractiveDirection.horizental)
        }
        else {
            presentAnimator = DoorPresentAnimator()
            dismissAnimator = DoorDismissAnimator()
            interactiveDismissAnimator = ModalInteractiveAnimation(direction:InteractiveDirection.vertical)
        }
        super.init()
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveDismissAnimator.interacting ? interactiveDismissAnimator : nil
    }
}
