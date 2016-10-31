# UsitCharts
Library to draw different chars. 

##Language
Swift 

##Important!!
Feel free to improve code, add functionalities or use the Lib as it is. :)

##Use
Just download the library and add the "ChartLib" directory to your project. 
You will find some examples on ViewController.swift about how to use the library.

###Configuration
Find it in ``` UsitChartConfiguration.swift ```

The Lib has a configuration file to allow you to configure colors, sizes and margins. You dont's have to modify source code to configure the design of your charts.
If there is any configuration missing, let us know or add it yourself.

###Bar Chart
To create a bar chart view just write this code:

```
chart = UsitBarChart(frame: yourFrame)
chart.addValues([14, 21, 36, 48, 51, 26, 75, 83, 56, 97, 100, 120]) /* Array with values. */
chart.addAxisXValueTitles(["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dic"]) /* Array with X axis titles. */
chart.addAxisTitles("Months", y: "Expenses") /* Axis titles. */
chart.strokeChart()
```

###Stack Bar Chart
To create a stack bar chart view just write this code:

```
let stackValues1 = [5, 6, 4, 5, 1, 5, 4, 5, 2]
let stackValues2 = [3, 1, 3, 1, 2, 2, 2, 2, 5]
let stackValues3 = [2, 5, 2, 3, 4, 3, 1, 1, 1]
        
chart = UsitStackBarChart(frame: yourFrame)
(chart as! UsitStackBarChart).addStackValues([stackValues1, stackValues2, stackValues3])  /* Array of array of values. */
(chart as! UsitStackBarChart).addStackColors([kChart.Colors.Basic, UIColor.lightGray, UIColor.darkGray]) /* Stack colors. */
chart.addAxisTitles("Something", y: "Some Sum") /* Axis titles. */
chart.strokeChart()
```

###Points Chart
To create a points chart view just write this code:

```
chart = UsitLineChart(frame: yourFrame)
(chart as! UsitLineChart).drawLines = true /* Specify if you want to draw only points or also a line. */
chart.addValues([1, 3, 6, 8, 12, 7, 4, 1, 3, 8]) /* Array with the values. */
chart.addAxisXValueTitles(["1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995"]) /* Array with x axis titles. */
chart.addAxisTitles("Days", y: "Hours of work") /* Axis titles. */
chart.strokeChart()
```

###Circle Chart
To create a circle chart view just write this code:

```
let circleChart = UsitCircleChart(frame: yourFrame)
circleChart.percent = 80 /* The percent to fill. */
circleChart.strokeChart()
```

By Usit Development(www.usitdevelopment.com)
