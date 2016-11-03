//
//  UsitChart.swift
//  UsitChartsSwift
//
//  Created by Usue on 13/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class UsitChart: UIView
{
    var values: NSArray!
    var maxValue: NSInteger = 0
    let innerChartMargin: CGFloat = 25.0
    var viewChart = UIScrollView()
    
    fileprivate var axisXValuesTitles = NSArray()
    fileprivate var axisXTitle = "Axis X"
    fileprivate var axisYTitle = "Axis Y"
    
    fileprivate var yLabels = NSMutableArray()
    fileprivate var xValueWidth = 0
    fileprivate var yValueWidth = 0
    
    func addValues(_ values: NSArray)
    {
        self.values = values
    }
    
    func addAxisXValueTitles(_ titles: NSArray)
    {
        axisXValuesTitles = titles
    }
    
    func addAxisTitles(_ x: String, y: String)
    {
        axisXTitle = x
        axisYTitle = y
    }
    
    func strokeChart()
    {
        cleanViewChart()
        
        if chartHasValues() {
            drawAxisXTitle()
            drawAxisXValues()
            
            drawAxisYTitle()
            drawAxisYValues()
        }
    }
    
    
    //MARK: Life Cycle
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        drawFrame()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawFrame()
    {
        drawContent()
        drawAxis()
    }
    
    
    //MARK: Axis Functions
    
    fileprivate func drawAxis()
    {
        drawAxisXLine()
        drawAxisYLine()
    }
    
    fileprivate func drawAxisXValues()
    {
        let barSpace = kChart.Sizes.barWidth + kChart.Sizes.barSpace
        let hasXtitles = axisXValuesTitles.count > 0
        var x = innerChartMargin
        let y = viewChart.frame.size.height - innerChartMargin
        
        for i in 0...values.count - 1 {
            let title = hasXtitles ? axisXValuesTitles[i] as! String : String(format: "%i", i)
            let label = getLabel(title as NSString, rect: CGRect(x: x, y: y, width: barSpace, height: 21), color: kChart.Colors.AxisXValues, align: .right)
            viewChart.addSubview(label)
            
            x += barSpace
        }
        
        viewChart.contentSize = CGSize(width: CGFloat(values.count)*barSpace + innerChartMargin, height: viewChart.contentSize.height)
    }
    
    fileprivate func drawAxisYValues()
    {
        let sortedArray = values.sorted{return ($0 as AnyObject).int32Value > ($1 as AnyObject).int32Value}
        maxValue = (sortedArray[0] as AnyObject).intValue
        let labelHeight = kChart.Sizes.yLabelHeight
        let numOfYvalues = NSInteger((frame.size.height - (kChart.Margins.Top + kChart.Margins.Bottom))/labelHeight)
        
        let x:CGFloat = 0.0
        var y = frame.size.height - kChart.Margins.Bottom - innerChartMargin
        
        for i in 0...numOfYvalues - 1 {
            let frame = CGRect(x: x, y: y, width: kChart.Margins.Left - 4, height: labelHeight)
            let title = i == 0 ? "0" : String(format: "%i", (maxValue*i/numOfYvalues))
            let label = getLabel(title as NSString, rect: frame, color: kChart.Colors.AxisYValues, align: .right)
            
            addSubview(label)
            yLabels.add(label)
            
            y -= labelHeight
        }
    }
    
    fileprivate func drawAxisYLine()
    {
        let initX = kChart.Margins.Left, initY = kChart.Margins.Top
        let endY = frame.size.height - kChart.Margins.Bottom
        drawLine(CGPoint(x: initX, y: initY), to: CGPoint(x: initX, y: endY), color: kChart.Colors.AxisY)
    }
    
    fileprivate func drawAxisYTitle()
    {
        let width = frame.size.width - (kChart.Margins.Right + kChart.Margins.Left)
        let rect = CGRect(x: kChart.Margins.Left, y: 5, width: width, height: 21)
        drawAxisTitle(axisYTitle as NSString, rect: rect, color: kChart.Colors.AxisY, align: .left)
    }
    
    fileprivate func drawAxisXLine()
    {
        let initX = kChart.Margins.Left, initY = frame.size.height - kChart.Margins.Bottom
        let endX = frame.size.width - kChart.Margins.Right
        drawLine(CGPoint(x: initX, y: initY), to: CGPoint(x: endX, y: initY), color: kChart.Colors.AxisX)
    }
    
    fileprivate func drawAxisXTitle()
    {
        let initX = kChart.Margins.Left, initY = frame.size.height - kChart.Margins.Bottom
        let width = frame.size.width - (kChart.Margins.Right + kChart.Margins.Left)
        let rect = CGRect(x: initX, y: initY - 21, width: width, height: 21)
        drawAxisTitle(axisXTitle as NSString, rect: rect, color: kChart.Colors.AxisX, align: .right)
    }
    
    fileprivate func drawAxisTitle(_ title: NSString, rect: CGRect, color: UIColor, align: NSTextAlignment)
    {
        let label = getLabel(title, rect: rect, color: color, align: align)
        addSubview(label)
    }
    
    
    //MARK: Helpers
    func getLine(_ from: CGPoint, to: CGPoint, color: UIColor) -> CAShapeLayer
    {
        let line = CAShapeLayer(layer: layer)
        line.lineCap = kCALineCapButt
        line.fillColor = color.cgColor
        line.lineWidth = 1.0;
        line.strokeEnd = 0.0;
        
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        path.lineWidth = 1.0
        path.close()
        
        color.setStroke()
        path.stroke()
        
        line.path = path.cgPath
        line.strokeColor = color.cgColor
        line.strokeEnd = 1.0
        
        return line
    }
    
    func drawLine(_ from: CGPoint, to: CGPoint, color: UIColor)
    {
        layer.addSublayer(getLine(from, to: to, color: color))
    }
    
    fileprivate func drawContent()
    {
        viewChart.backgroundColor = kChart.Colors.ChartBg
        viewChart.frame = CGRect(x: kChart.Margins.Left - innerChartMargin, y: kChart.Margins.Top - innerChartMargin, width: frame.size.width - (kChart.Margins.Left + kChart.Margins.Right) + innerChartMargin*2, height: frame.size.height - (kChart.Margins.Top + kChart.Margins.Bottom) + innerChartMargin*2)
        
        addSubview(viewChart)
    }
    
    fileprivate func cleanViewChart()
    {
        for subview: UIView in viewChart.subviews {
            subview.removeFromSuperview()
        }
        
        for subview in yLabels {
            (subview as AnyObject).removeFromSuperview()
        }
        
        yLabels.removeAllObjects()
    }
    
    fileprivate func getLabel(_ title: NSString, rect: CGRect, color: UIColor, align: NSTextAlignment) -> UILabel
    {
        let label = UILabel(frame: rect)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = color
        label.text = title as String
        label.textAlignment = align
        
        return label
    }
    
    func chartHasValues() -> Bool
    {
        return values.count > 0
    }
    
    
    //MARK: Animations
    
    func animateLayer(_ layer: CAShapeLayer)
    {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 0.8
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        layer.add(animation, forKey: "animateLayer")
    }
}
