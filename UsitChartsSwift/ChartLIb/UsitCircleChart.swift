//
//  UsitCircleChart.swift
//  UsitChartsSwift
//
//  Created by Usue on 20/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

class UsitCircleChart: UsitChart
{
    var percent:CGFloat = 100
    
    override func drawFrame() {}
    
    
    //MARK: Circle
    
    override func strokeChart()
    {
        drawCircle(percent: 100.0, color: kChart.Colors.CircleBg, animate: false)   //Draw BG
        drawCircle(percent: percent, color: kChart.Colors.Circle, animate: true)    //Draw percent
        drawLabel()
    }
    
    func drawLabel()
    {
        let labelFrame = CGRect(x: innerChartMargin, y: innerChartMargin, width: frame.size.width - (innerChartMargin*2), height: frame.size.height - (innerChartMargin*2))
        
        let label = UILabel(frame: labelFrame)
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 50)
        label.minimumScaleFactor = 0.25
        label.textColor = kChart.Colors.CircleText
        label.textAlignment = NSTextAlignment.center
        label.text = String.init(format: "%0.2f%@", percent, "%")
        
        addSubview(label)
    }
    
    private func drawCircle(percent: CGFloat, color: UIColor, animate: ObjCBool)
    {
        let width = frame.size.width - (innerChartMargin*2)
        let center = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
        let start: CGFloat = -CGFloat(M_PI)/2.0
        let end: CGFloat = CGFloat(M_PI*2.0)*CGFloat(percent/100.0) + start
        let circlePath = UIBezierPath(arcCenter: center, radius: width/2, startAngle:start, endAngle:end , clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = kChart.Sizes.circleLineWidth
        circleLayer.strokeEnd = animate.boolValue ? 0.0 : 1.0
        
        layer.addSublayer(circleLayer)
        
        if animate.boolValue {
            circleLayer.strokeEnd = 1.0
            animateLayer(circleLayer)
        }
    }
}
