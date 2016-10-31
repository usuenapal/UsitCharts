//
//  ViewController.swift
//  UsitChartsSwift
//
//  Created by Usue on 13/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var chartView: UIView!
    
    var chart: UsitChart!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        drawBarChart()
    }
    
    
    //MARK: Actions
    @IBAction func pressSegmented()
    {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            drawBarChart()
            break;
        case 1:
            drawLineChart()
            break;
        case 2:
            drawStackBarChart()
            break;
        case 3:
            drawCircleChart()
            break;
        default:
            break;
        }
    }
    
    
    //MARK: Chart Helpers
    
    func cleanChartView()
    {
        for view: UIView in chartView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func drawBarChart()
    {
        cleanChartView()
        
        chart = UsitBarChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.size.width, height: chartView.frame.size.height))
        chart.addValues([14, 21, 36, 48, 51, 26, 75, 83, 56, 97, 100, 120])
        chart.addAxisXValueTitles(["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dic"])
        chart.addAxisTitles("Months", y: "Expenses")
        chart.strokeChart()
        
        chartView.addSubview(chart)
    }
    
    func drawLineChart()
    {
        cleanChartView()
        
        chart = UsitLineChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.size.width, height: chartView.frame.size.height))
        (chart as! UsitLineChart).drawLines = true
        chart.addValues([1, 3, 6, 8, 12, 7, 4, 1, 3, 8])
        chart.addAxisXValueTitles(["1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995"])
        chart.addAxisTitles("Days", y: "Hours of work")
        chart.strokeChart()
        
        chartView.addSubview(chart)
    }
    
    func drawStackBarChart()
    {
        cleanChartView()
        
        let stackValues1 = [5, 6, 4, 5, 1, 5, 4, 5, 2]
        let stackValues2 = [3, 1, 3, 1, 2, 2, 2, 2, 5]
        let stackValues3 = [2, 5, 2, 3, 4, 3, 1, 1, 1]
        
        chart = UsitStackBarChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.size.width, height: chartView.frame.size.height))
        (chart as! UsitStackBarChart).addStackValues([stackValues1, stackValues2, stackValues3])
        (chart as! UsitStackBarChart).addStackColors([kChart.Colors.Basic, UIColor.lightGray, UIColor.darkGray])
        chart.addAxisTitles("Something", y: "Some Sum")
        chart.strokeChart()
        
        chartView.addSubview(chart)
    }
    
    func drawCircleChart()
    {
        cleanChartView()
        
        let circleChart = UsitCircleChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.size.width, height: chartView.frame.size.height))
        circleChart.percent = 80
        circleChart.strokeChart()
        
        chartView.addSubview(circleChart)
    }
}

