//
//  ArrowView.swift
//  Shotplotter
//
//  Created by KUNDU, SOURISH on 1/31/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class ArrowView: UIView {
    
    var data: RotationView?
    
    var color: UIColor
    var strokeWidth: CGFloat
    var isDrawing: Bool
    var startPoint: CGPoint
    var drawPath: UIBezierPath
    var storePath: UIBezierPath
    var endPoint: CGPoint
    
    var drawLayer: CAShapeLayer
    var storeLayer: [CAShapeLayer]
    
    var activePlayer: Player
    
    private var index: Int
    
    required init?(coder aDecoder: NSCoder) {
        activePlayer = Player()
        index = 0
        color = UIColor.red
        strokeWidth = 3
        isDrawing = false
        drawPath = UIBezierPath()
        storePath = UIBezierPath()
        drawLayer = CAShapeLayer()
        startPoint = CGPoint()
        endPoint = CGPoint()
        
        storeLayer = [CAShapeLayer]()
        
        
        //interpolationPoints = [CGPoint]()
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        storeLayer.append(CAShapeLayer())
        
        layer.addSublayer(storeLayer[index])
        layer.addSublayer(drawLayer)
        
        drawLayer.fillColor = nil
        drawLayer.strokeColor = color.cgColor
        drawLayer.lineWidth = strokeWidth
        drawLayer.lineCap = kCALineCapRound
        
        storeLayer[index].fillColor = nil
        storeLayer[index].strokeColor = color.cgColor
        storeLayer[index].lineWidth = strokeWidth
        storeLayer[index].lineCap = kCALineCapRound
        
        storeLayer[index].path = CGMutablePath()
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
        //drawShapeLayer(path: storePath, layer: storeLayer)
        //activePlayer.layer = self.storeLayer
        //print(activePlayer.number)
        //print(startPoint)
        //print(endPoint)
        drawPath.removeAllPoints()
        activePlayer.addLine(line: (data?.protoLine)!)
        endPoint = startPoint
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
        drawShapeLayer(path: drawPath, layer: drawLayer)
        endPoint = touchPoint
        drawShapeLayer(path: storePath, layer: storeLayer[index])
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
        index = player.number
    }
    
    
}

