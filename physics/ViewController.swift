//
//  ViewController.swift
//  physics
//
//  Created by Valery Girkin on 17.03.15.
//  Copyright (c) 2015 Valery Girkin. All rights reserved.
//

import UIKit

let numberOfBoxes = 10

typealias Box = UIView

class ViewController: UIViewController {
    var boxes = [Box]()
    var animator: UIDynamicAnimator?
    let collider = UICollisionBehavior()
    let gravity = UIGravityBehavior()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        generateBoxes()
        createAnimator()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("deviceOrientationDidChange:"), name: UIDeviceOrientationDidChangeNotification, object: nil)

    }
    
    func generateBoxes() {
        for _ in 0..<numberOfBoxes {
            let x = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))
            let y = CGFloat(arc4random_uniform((100)))
            let length = 20 + CGFloat(arc4random_uniform(10))
                
            addBox(CGRectMake(x, y, length, length))
        }
    }
    
    func generateColor() -> UIColor {
        let red = CGFloat(arc4random()) % 256 / 255
        let green = CGFloat(arc4random()) % 256 / 255
        let blue = CGFloat(arc4random()) % 256 / 255
        let alpha = CGFloat(arc4random()) % 1000 / 1000
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func addBox(location: CGRect) {
        let box = UIView(frame: location)
        box.backgroundColor = generateColor()
        self.view.addSubview(box)
        self.boxes.append(box)
    }
    
    func createAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        collider.translatesReferenceBoundsIntoBoundary = true
        gravity.gravityDirection = CGVectorMake(0.0, 0.5)
        
        boxes.map { (box) -> Void in
            self.gravity.addItem(box)
            self.collider.addItem(box)
        }
        animator?.addBehavior(gravity)
        animator?.addBehavior(collider)
        
    }
    
    func deviceOrientationDidChange(notification: NSNotification) {
        print(notification)
        switch (UIDevice.currentDevice().orientation) {
        case .Portrait:
             gravity.gravityDirection = CGVectorMake(0.0, 1.0)
        case .LandscapeLeft:
            gravity.gravityDirection = CGVectorMake(-1.0, 0.0)
        case .LandscapeRight:
            gravity.gravityDirection = CGVectorMake(1.0, 0.0)
        case .PortraitUpsideDown:
            gravity.gravityDirection = CGVectorMake(0.0, -1.0)
        default:
            break
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
}

