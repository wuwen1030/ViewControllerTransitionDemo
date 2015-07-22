//
//  NavigationTransition.swift
//  ViewControllerTransition
//
//  Created by Ben on 15/7/21.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

import UIKit

class NavigationTransition: NSObject, UINavigationControllerDelegate {
    
    let pushAnimator = PushAnimator()
    let popAnimator = PopAnimator()
    private var popInteractiveAnimator: UIPercentDrivenInteractiveTransition?
    weak var navigationController: UINavigationController?
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == UINavigationControllerOperation.Push {
            return pushAnimator
        } else {
            return popAnimator
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return animationController is PopAnimator ? popInteractiveAnimator : nil
    }
    
    func wireToNavigationController(navigationController:UINavigationController) {
        self.navigationController = navigationController
        let gestureRecognizer = navigationController.interactivePopGestureRecognizer
        gestureRecognizer.enabled = false
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        navigationController.view.addGestureRecognizer(pan)
    }
    
    func handlePan(gestureRecognizer:UIPanGestureRecognizer) -> Void {
        
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!)
        let width = gestureRecognizer.view!.bounds.size.width
        let progress = translation.x / width
        
        switch gestureRecognizer.state
        {
        case UIGestureRecognizerState.Began:
            popInteractiveAnimator = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewControllerAnimated(true)
        case UIGestureRecognizerState.Changed:
            popInteractiveAnimator?.updateInteractiveTransition(progress)
        case UIGestureRecognizerState.Cancelled, UIGestureRecognizerState.Ended:
            if progress > 0.5
            {
                popInteractiveAnimator?.finishInteractiveTransition()
            }
            else
            {
                popInteractiveAnimator?.cancelInteractiveTransition()
            }
            popInteractiveAnimator = nil
        default:
            println("Stupid language")
        }
    }

}
