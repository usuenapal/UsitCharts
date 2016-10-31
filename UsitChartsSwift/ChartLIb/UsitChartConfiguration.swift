//
//  UsitChartConfiguration.swift
//  UsitChartsSwift
//
//  Created by Usue on 13/8/16.
//  Copyright © 2016 Usit Development. All rights reserved.
//

import UIKit

struct kChart {
    struct Sizes {
        static let yLabelHeight: CGFloat = 35.0
        static let barWidth: CGFloat = 25.0
        static let barSpace: CGFloat = 8.0
        static let pointRad: CGFloat = 4.0
        static let circleLineWidth: CGFloat = 12.0
    }
    
    struct Colors {
        static let Basic = UIColor.init(colorLiteralRed: 161/255, green: 192/255, blue: 87/255, alpha: 1)
        static let AxisX = UIColor.black
        static let AxisY = UIColor.lightGray
        static let AxisXValues = UIColor.black
        static let AxisYValues = UIColor.black
        static let BarBg = Basic
        static let Point = Basic
        static let ChartBg = UIColor.white
        static let Circle = Basic
        static let CircleBg = UIColor.white
        static let CircleText = UIColor.darkGray
    }
    
    struct Margins {
        static let Top: CGFloat = 30.0
        static let Bottom: CGFloat = 100.0
        static let Left: CGFloat = 30.0
        static let Right: CGFloat = 30.0
    }
}

class UsitChartConfiguration: NSObject
{
}
