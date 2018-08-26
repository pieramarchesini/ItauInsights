//
//  MessageBubbleView.swift
//  MessageBubbleDemo
//
//  Created by Kyle Haptonstall on 9/6/17.
//  Copyright © 2017 Kyle Haptonstall. All rights reserved.
//

import UIKit

class MessageBubbleView: UIView {
    
    // MARK: Lifecycle
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        
        //Draw main body
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        
        //Draw the tail
        if currentUserIsSender {
            bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))
            UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).setFill()
            
        } else {
            bezierPath.move(to: CGPoint(x: rect.minX + 25.0, y: rect.maxY - 10.0))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY))
            bezierPath.addLine(to: CGPoint(x: rect.minX + 10.0, y: rect.maxY - 10.0))
            UIColor(red: 239/255, green: 249/255, blue: 247/255, alpha: 1).setFill()
        }
        bezierPath.fill()
        bezierPath.close()
    }
    
    // MARK: Custom Accessors
    
    var currentUserIsSender = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
}
