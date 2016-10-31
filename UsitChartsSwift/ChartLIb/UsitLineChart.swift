//
//  UsitLineChart.swift
//  UsitChartsSwift
//
//  Created by Usue on 13/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

class UsitLineChart: UsitChart
{
    var drawLines: Bool = false
    
    override func strokeChart()
    {
        super.strokeChart()
        drawPoints();
    }
    
    
    //MARK: Bar Functions
    
    fileprivate func drawPoints()
    {
        if chartHasValues() {
            for i in 0...values.count - 1 {
                let currentPoint = getPointForValue(i)
                drawPoint(currentPoint)
                
                if drawLines && i > 0 {
                    let line = getLine(currentPoint, to: getPointForValue(i - 1), color: kChart.Colors.Point)
                    viewChart.layer.addSublayer(line)
                }
            }
        }
    }
    
    fileprivate func drawPoint(_ at: CGPoint)
    {
        let rad = kChart.Sizes.pointRad
        let color = kChart.Colors.Point
        let line = CAShapeLayer(layer: layer)
        
        line.lineCap = kCALineCapButt
        line.fillColor = color.cgColor
        line.lineWidth = 1.0;
        line.strokeEnd = 0.0;
        
        let path = UIBezierPath()
        path.move(to: at)
        path.addArc(withCenter: at, radius:rad, startAngle: 0, endAngle:rad*CGFloat(M_PI), clockwise: true)
        
        path.lineWidth = 1.0
        path.close()
        
        color.setStroke()
        path.stroke()
        
        line.path = path.cgPath
        line.strokeColor = color.cgColor
        line.strokeEnd = 1.0
        
        viewChart.layer.addSublayer(line)
    }
    
    
    //MARK: Helpers
    
    fileprivate func getPointForValue(_ i: NSInteger) -> CGPoint
    {
        let width = kChart.Sizes.barSpace + kChart.Sizes.barWidth;
        let x = innerChartMargin + (width*CGFloat(i)) + width/2 + kChart.Sizes.pointRad
        let percent = CGFloat(values[i] as! NSNumber)/CGFloat(maxValue)
        let totalHeight = viewChart.frame.size.height - innerChartMargin*2
        
        return CGPoint(x: x, y: totalHeight*(1 - percent) + innerChartMargin)
    }
}
