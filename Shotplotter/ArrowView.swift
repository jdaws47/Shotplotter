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
    var dispPath: UIBezierPath
    var storePath: UIBezierPath
    var endPoint: CGPoint
    
    
    var dispLayer: CAShapeLayer
    var storeLayer: CAShapeLayer
    
    var activePlayer: Player
    
    
    required init?(coder aDecoder: NSCoder) {
        color = UIColor.black
        strokeWidth = 3
        isDrawing = false
        startPoint = CGPoint()
        //endPoint = CGPoint()
        dispPath = UIBezierPath()
        storePath = UIBezierPath()
        endPoint = CGPoint()
        dispLayer = CAShapeLayer()
        storeLayer = CAShapeLayer()
        
        activePlayer = Player()
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        data?.checkDraw()
        if (data?.nextDraws)! {
            isDrawing = true
            guard let touch = touches.first else { return }
            startPoint = touch.location(in: self)
            data?.protoLine.startPos = startPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        storePath.move(to: startPoint)
        storePath.addLine(to: endPoint)
        data?.protoLine.endPos = endPoint
        drawShapeLayer(path: storePath, layer: storeLayer)
        activePlayer.layer = self.storeLayer
        //print(activePlayer.number)
        //print(startPoint)
        //print(endPoint)
        dispPath.removeAllPoints()
        activePlayer.addLine(line: (data?.protoLine)!)
        endPoint = startPoint
        data?.protoLine.reset()
        data?.protoLine.rotationID = (data?.rotationID)!
        
        data?.selected = -1
        print("touchesEnded")
        updateShotButtonsEvent.raise(data: 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        dispPath.removeAllPoints()
        dispPath.move(to: startPoint)
        dispPath.addLine(to: touchPoint)
        drawShapeLayer(path: dispPath, layer: dispLayer)
        endPoint = touchPoint
        drawShapeLayer(path: storePath, layer: storeLayer)
    }
    
    func drawShapeLayer(path: UIBezierPath, layer: CAShapeLayer) {
        layer.path = path.cgPath
        layer.strokeColor = color.cgColor
        layer.lineWidth = strokeWidth
        self.layer.addSublayer(layer)
        self.setNeedsDisplay()
    }
    
    func changeColor(player: Player) {
        activePlayer = player
        self.color = player.getColor()
        self.storeLayer = player.getLayer()
    }
}

