//
//  ViewController.swift
//  CodingChallengeTest
//
//  Created by apple on 31/08/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let figureView = RecursiveFigureView(frame: view.bounds)
        figureView.backgroundColor = .white
        view.addSubview(figureView)
        
    }


}


import UIKit

class RecursiveFigureView: UIView {
    var totalIterations: Int = 3  // Adjust the number of iterations here
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let sideLength: CGFloat = min(rect.width, rect.height) / CGFloat(totalIterations)
        
        let topPoint = CGPoint(x: rect.width / 2, y: 0)
        let leftPoint = CGPoint(x: 0, y: rect.height)
        let rightPoint = CGPoint(x: rect.width, y: rect.height)
        
        drawRecursiveFigure(context: context, iterations: totalIterations, top: topPoint, left: leftPoint, right: rightPoint, sideLength: sideLength)
    }
    
    func drawRecursiveFigure(context: CGContext, iterations: Int, top: CGPoint, left: CGPoint, right: CGPoint, sideLength: CGFloat) {
        if iterations == 0 {
            return
        }
        
        // Calculate triangle points
        let leftTrianglePoint = CGPoint(x: (top.x + left.x) / 2, y: (top.y + left.y) / 2)
        let rightTrianglePoint = CGPoint(x: (top.x + right.x) / 2, y: (top.y + right.y) / 2)
        let bottomTrianglePoint = CGPoint(x: (left.x + right.x) / 2, y: left.y)
        
        // Draw triangle
        context.beginPath()
        context.move(to: top)
        context.addLine(to: left)
        context.addLine(to: right)
        context.closePath()
        context.strokePath()
        
        // Calculate square points
        let topLeftSquarePoint = left
        let topRightSquarePoint = CGPoint(x: right.x - sideLength, y: right.y)
        let bottomLeftSquarePoint = CGPoint(x: left.x, y: left.y - sideLength)
        let bottomRightSquarePoint = CGPoint(x: bottomLeftSquarePoint.x + sideLength, y: bottomLeftSquarePoint.y)
        
        // Draw square
        context.stroke(CGRect(x: bottomLeftSquarePoint.x, y: bottomLeftSquarePoint.y, width: sideLength, height: sideLength))
        
        // Recursive calls
        drawRecursiveFigure(context: context, iterations: iterations - 1, top: top, left: leftTrianglePoint, right: rightTrianglePoint, sideLength: sideLength / 2)
        drawRecursiveFigure(context: context, iterations: iterations - 1, top: leftTrianglePoint, left: topLeftSquarePoint, right: bottomLeftSquarePoint, sideLength: sideLength / 2)
        drawRecursiveFigure(context: context, iterations: iterations - 1, top: rightTrianglePoint, left: bottomRightSquarePoint, right: topRightSquarePoint, sideLength: sideLength / 2)
    }
}

