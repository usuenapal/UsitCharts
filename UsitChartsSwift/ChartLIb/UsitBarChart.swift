//
//  UsitBarChart.swift
//  UsitChartsSwift
//
//  Created by Usue on 13/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

class UsitBarChart: UsitChart
{
    override func strokeChart()
    {
        super.strokeChart()
        drawBars();
    }
    
    
    //MARK: Bar Functions
    
    fileprivate func drawBars()
    {
        if chartHasValues() {
            let width = kChart.Sizes.barSpace + kChart.Sizes.barWidth;
            
            for i in 0...values.count - 1 {
                let x = innerChartMargin + kChart.Margins.Left + width*CGFloat(i) - kChart.Sizes.barSpace
                let percent = CGFloat(values[i] as! NSNumber)/CGFloat(maxValue)
                let totalHeight = viewChart.frame.size.height - innerChartMargin*2
                
                drawBar(CGPoint(x: x, y: totalHeight + innerChartMargin), to: CGPoint(x: x, y: totalHeight*(1 - percent) + innerChartMargin), color: kChart.Colors.BarBg)
            }
        }
    }
    
    func drawBar(_ from: CGPoint, to: CGPoint, color: UIColor)
    {
        let line = CAShapeLayer(layer: layer)
        line.lineCap = kCALineCapButt
        line.fillColor = color.cgColor
        line.lineWidth = kChart.Sizes.barWidth;
        line.strokeEnd = 0.0;
        
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        path.lineWidth = kChart.Sizes.barWidth
        path.close()
        
        color.setStroke()
        path.stroke()
        
        line.path = path.cgPath
        line.strokeColor = color.cgColor
        line.strokeEnd = 1.0
        
        viewChart.layer.addSublayer(line)
        
        animateLayer(line)
    }
}
