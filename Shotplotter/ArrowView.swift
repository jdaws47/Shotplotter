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
    var dispPath: UIBezierPath
    var storePath: UIBezierPath
    var finPoint: CGPoint
    
    var dispLayer: CAShapeLayer
    var storeLayer: CAShapeLayer
    
    var typeOfShot: Int
    var activePlayer: Player
    
    
    required init?(coder aDecoder: NSCoder) {
        color = UIColor.black
        strokeWidth = 3
        isDrawing = false
        startPoint = CGPoint()
        //endPoint = CGPoint()
        dispPath = UIBezierPath()
        storePath = UIBezierPath()
        finPoint = CGPoint()
        dispLayer = CAShapeLayer()
        storeLayer = CAShapeLayer()
        
        typeOfShot = -1
        
        activePlayer = Player()
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        guard let touch = touches.first else { return }
        startPoint = touch.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        storePath.move(to: startPoint)
        storePath.addLine(to: finPoint)
        drawShapeLayer(path: storePath, layer: storeLayer)
        dispPath.removeAllPoints()
        activePlayer.addLine(start: startPoint, end: finPoint, tip: false, rotation: 0, slide: false, A: false, roll: false, hit: false, didScore: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        dispPath.removeAllPoints()
        dispPath.move(to: startPoint)
        dispPath.addLine(to: touchPoint)
        drawShapeLayer(path: dispPath, layer: dispLayer)
        finPoint = touchPoint
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

