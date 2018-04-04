//
//  ArrowView.swift
//  Shotplotter
//
//  Created by KUNDU, SOURISH on 1/31/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

class ArrowView: UIView {
    
    var data: RotationView?
    
    var color: UIColor
    var strokeWidth: CGFloat
    var isDrawing: Bool
    var startPoint: CGPoint
    var drawPath: UIBezierPath
    var endPoint: CGPoint
    var drawLayer: CAShapeLayer
    //var typeOfShot: Int
    var activePlayer: Player
    
    required init?(coder aDecoder: NSCoder) {
        activePlayer = Player()
        color = UIColor.red
        strokeWidth = 3
        isDrawing = false
        drawPath = UIBezierPath()
        //storePath = UIBezierPath()
        drawLayer = CAShapeLayer()
        startPoint = CGPoint()
        endPoint = CGPoint()
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        
        layer.addSublayer(drawLayer)
        
        drawLayer.fillColor = nil
        drawLayer.strokeColor = color.cgColor
        drawLayer.lineWidth = strokeWidth
        drawLayer.lineCap = kCALineCapRound
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (data?.checkDraw())! {
            isDrawing = true
            guard let touch = touches.first else { return }
            startPoint = touch.location(in: self)
            data?.protoLine.startPos = startPoint
            data?.protoLine.color = color
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        drawPath.removeAllPoints()
        drawPath.move(to: startPoint)
        drawPath.addLine(to: touchPoint)
        endPoint = touchPoint
        drawShapeLayer(path: drawPath, passedLayer: activePlayer.layer)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        drawPath.move(to: startPoint)
        drawPath.addLine(to: endPoint)
        data?.protoLine.endPos = endPoint
        data?.protoLine.rotationID = (data?.rotationID)!
        finalizeShapeLayer(path: drawPath, layer: activePlayer.layer)
        //print(activePlayer.number)
        //print(startPoint)
        //print(endPoint)
        drawPath.removeAllPoints()
        activePlayer.addLine(line: (data?.protoLine)!)
        endPoint = CGPoint()
        startPoint = CGPoint()
        data?.protoLine.reset()
        data?.selected = -1
        print("touchesEnded")
        updateShotButtonsEvent.raise(data: 0)
    }
    
    //only called in touchesEnded
    func finalizeShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        let newLayer = CAShapeLayer()
        newLayer.fillColor = nil
        newLayer.strokeColor = activePlayer.color.cgColor
        newLayer.lineWidth = strokeWidth
        layer.addSublayer(newLayer)
        
        if (data?.protoLine.tip)! {
            newLayer.path = path.cgPath //THIS IS THE IMPORTANT ONE
        } else if (data?.protoLine.slide)! {
            let slidePath = UIBezierPath().cgPath.mutableCopy()
            let startX = CGFloat(startPoint.x)
            let startY = CGFloat(startPoint.y)
            let endX = CGFloat(endPoint.x)
            let endY = CGFloat(endPoint.y)
            
            let amplitude = CGFloat(5)
            var period = CGFloat(5)
            // Increase this number to increase performance
            let segmentLength = 5
            
            let xDiff = startX - endX
            let yDiff = startY - endY
            
            var angle = atan2(yDiff, xDiff)
            if angle < 0 {
                angle += 2.0 * CGFloat.pi
            }
            
            let length = sqrt(xDiff * xDiff + yDiff * yDiff)
            
            var occilations = CGFloat((Int)(length / (2 * CGFloat.pi)))
            occilations = CGFloat(Int(occilations / period))
            period = (CGFloat(occilations) * ((2 * CGFloat.pi) / length))
            
            var x3 = CGFloat(startX)
            var y3 = CGFloat(startY)
            for i in stride(from: 0, to: Int(length), by: segmentLength) {
                var counter = CGFloat(i)
                var x1 = startX - counter * (xDiff / length)
                var y1 = startY - counter * (yDiff / length)
                var x2 = x1 + sin(counter * period) * amplitude * cos(angle + CGFloat.pi / CGFloat(2))
                var y2 = y1 + sin(counter * period) * amplitude * sin(angle + CGFloat.pi / CGFloat(2))
                
                var firstPoint = CGPoint(x: x3,y: y3)
                var lastPoint = CGPoint(x: x2, y: y2)
                slidePath?.addLines(between: [firstPoint, lastPoint])
                
                newLayer.path = slidePath
                
                x3 = x2
                y3 = y2
            }            
        } else if (data?.protoLine.roll)! {
            let rollPath = path.cgPath.mutableCopy()
            rollPath?.addLines(between: [startPoint, endPoint])
            newLayer.lineDashPattern = [30, 15, 15, 15]
            newLayer.path = rollPath
        } else if (data?.protoLine.A)! {
            let aPath = path.cgPath.mutableCopy()
            aPath?.addLines(between: [startPoint, endPoint])
            newLayer.lineDashPattern = [7, 3, 7]
            newLayer.path = aPath
        }

        let previewLayer = layer.sublayers![0] as! CAShapeLayer
        previewLayer.path = nil
        self.setNeedsDisplay()
    }
    
    //called multiple times for the preview line in touches moved
    func drawShapeLayer(path: UIBezierPath, passedLayer: CAShapeLayer) {
        let subLayer = passedLayer.sublayers![0] as! CAShapeLayer
        subLayer.lineWidth = strokeWidth
        subLayer.strokeColor = activePlayer.color.cgColor
        subLayer.path = path.cgPath
        //self.layer.addSublayer(layer)
        self.setNeedsDisplay()
    }
    
    func changeColor(player: Player) {
        activePlayer = player
        self.color = player.getColor()
        if (!player.layerExists) {
            layer.addSublayer(player.layer)
            player.layerExists = true
        }
    }
    
    func clear() {
        //layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        data?.players.forEach { _ = $0.initializeLayer((data?.rotationID)!) }
    }
}


