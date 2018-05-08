//
//  DismissMenuAnimator.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class DismissMenuAnimator : NSObject {
}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        // 1
        guard let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber) else { return }
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                // 2
//                snapshot.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
                fromVC.view.frame.origin.x -= UIScreen.main.bounds.width * MenuHelper.menuWidth
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    // 3
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        }
        )
    }
}

