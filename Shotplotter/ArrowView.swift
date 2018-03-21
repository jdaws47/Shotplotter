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
    //var storePath: UIBezierPath
    var endPoint: CGPoint
    
    var drawLayer: CAShapeLayer
    
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        drawPath.removeAllPoints()
        drawPath.move(to: startPoint)
        drawPath.addLine(to: touchPoint)
        //drawShapeLayer(path: drawPath, layer: drawLayer)
        endPoint = touchPoint
        drawShapeLayer(path: drawPath, layer: activePlayer.layer)
    }
    
    //only called in touchesEnded
    func finalizeShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        let newLayer = CAShapeLayer()
        newLayer.fillColor = nil
        let path2 = path.cgPath.mutableCopy()
        path2?.addLines(between: [startPoint, endPoint])
        newLayer.lineDashPattern = [7, 3]
        newLayer.lineWidth = strokeWidth
        newLayer.strokeColor = activePlayer.color.cgColor
        newLayer.path = path2 //This is the important one
        //self.layer.addSublayer(layer)
        self.setNeedsDisplay()
    }
    
    //called multiple times for the preview line in touches moved
    func drawShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        let subLayer = layer.sublayers![0] as! CAShapeLayer
        let path2 = path.cgPath.mutableCopy()
        path2?.addLines(between: [startPoint, endPoint])
        subLayer.lineDashPattern = [7, 3]
        subLayer.lineWidth = strokeWidth
        subLayer.strokeColor = activePlayer.color.cgColor
        subLayer.path = path2
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


