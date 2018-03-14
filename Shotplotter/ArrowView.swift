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
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        drawPath.move(to: startPoint)
        drawPath.addLine(to: endPoint)
        data?.protoLine.endPos = endPoint
        finalizeShapeLayer(path: drawPath, layer: activePlayer.layer)
        //print(activePlayer.number)
        //print(startPoint)
        //print(endPoint)
        drawPath.removeAllPoints()
        activePlayer.addLine(line: (data?.protoLine)!)
        endPoint = CGPoint()
        startPoint = CGPoint()
        data?.protoLine.reset()
        data?.protoLine.rotationID = (data?.rotationID)!
        
        data?.selected = -1
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
    
    func finalizeShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        var newLayer = CAShapeLayer()
        newLayer.fillColor = nil
        newLayer.strokeColor = activePlayer.color.cgColor
        layer.addSublayer(newLayer)
        newLayer.path = path.cgPath //THIS IS THE IMPORTANT ONE
        newLayer.lineWidth = strokeWidth
        //self.layer.addSublayer(layer)
        self.setNeedsDisplay()
    }
    
    func drawShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        var subLayer = layer.sublayers![0] as! CAShapeLayer
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
}


