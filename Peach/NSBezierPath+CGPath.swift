//
//  NSBezierPath+CGPath.swift
//  Peach
//
//  Created by Stephen Radford on 17/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    func toCGPath () -> CGPath? {
        if self.elementCount == 0 {
            return nil
        }
        
        let path = CGPathCreateMutable()
        var didClosePath = false
        
        for i in 0...self.elementCount-1 {
            var points = [NSPoint](count: 3, repeatedValue: NSZeroPoint)
            
            switch self.elementAtIndex(i, associatedPoints: &points) {
            case .MoveToBezierPathElement:CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
            case .LineToBezierPathElement:CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
            case .CurveToBezierPathElement:CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
            case .ClosePathBezierPathElement:CGPathCloseSubpath(path)
            didClosePath = true;
            }
        }
        
        if !didClosePath {
            CGPathCloseSubpath(path)
        }
        
        return CGPathCreateCopy(path)
    }
}