//
//  UsitStackBarChart.swift
//  UsitChartsSwift
//
//  Created by Usue on 20/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

class UsitStackBarChart: UsitBarChart
{
    fileprivate var stackValues: NSMutableArray!
    fileprivate var stackcolors: NSArray!
    
    override func strokeChart()
    {
        super.strokeChart()
        drawStackBars();
    }
    
    func addStackColors(_ colors: NSArray)
    {
        stackcolors = colors
    }
    
    /**
     Values for stack Bar Chart. All arrays must have same length!!!
     
     @param values: Array of array of values.
    */
    
    func addStackValues(_ values: NSArray)
    {
        stackValues = NSMutableArray()
        
        for i in 0...values.count - 1 {
            stackValues.add(NSMutableArray(array: values[i] as! NSArray))
        }
        
        let sumValues = NSMutableArray()
        var maxElementsInArray = 0
        var indexOfBiggerArray = 0
        
        for i in 0...stackValues.count - 1 {
            let numValues = (stackValues[i] as AnyObject).count
            let thisArrayIsBigger = numValues! > maxElementsInArray
            
            maxElementsInArray = thisArrayIsBigger ? numValues! : maxElementsInArray
            indexOfBiggerArray = thisArrayIsBigger ? i : indexOfBiggerArray
        }
        
        for i in 0...(stackValues[indexOfBiggerArray] as AnyObject).count - 1 {
            var sum: Int32 = 0
            
            for j in 0...stackValues.count - 1 {
                let arrayVals = (stackValues[j] as? [NSNumber])
                
                if i < (arrayVals)!.count {
                    sum += Int32((arrayVals!)[i].intValue)
                } else {
                    (arrayVals as AnyObject).insert(NSNumber(value: 0 as Int32), at: i)
                    stackValues[j] = arrayVals ?? []
                }
            }
            
            sumValues.insert(NSNumber(value: sum as Int32), at: i)
        }
        
        self.values = sumValues
    }
    
    
    //MARK: Bar Functions
    
    fileprivate func drawStackBars()
    {
        if chartHasValues() {
            let width = kChart.Sizes.barSpace + kChart.Sizes.barWidth;
            let firstVals = stackValues[0]
            
            if stackcolors == nil {
                generateStackColors()
            }
            
            for i in 0...(firstVals as AnyObject).count - 1 {
                let x = innerChartMargin + kChart.Margins.Left + width*CGFloat(i) - kChart.Sizes.barSpace
                let totalHeight = viewChart.frame.size.height - innerChartMargin*2
                var y = totalHeight
                
                for j in 0...stackValues.count - 1 {
                    let arrayVals = stackValues[j] as? [NSNumber]
                    let percent = CGFloat(truncating: (arrayVals!)[i])/CGFloat(maxValue)
                    
                    drawBar(CGPoint(x: x, y: y + innerChartMargin), to: CGPoint(x: x, y: y - totalHeight*percent + innerChartMargin), color: stackcolors[j] as! UIColor)
                    y = CGFloat(y - totalHeight*percent)
                }
            }
        }
    }
    
    fileprivate func generateStackColors()
    {
        let colors = NSMutableArray()
        
        for i in 0...stackValues.count - 1 {
            colors.insert(getRandomColor(), at: i)
        }
        
        stackcolors = colors
    }
    
    fileprivate func getRandomColor() -> UIColor
    {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
