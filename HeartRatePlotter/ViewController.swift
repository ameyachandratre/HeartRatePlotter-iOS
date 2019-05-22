//
//  ViewController.swift
//  HeartRatePlotter
//
//  Created by Ameya on 22/05/19.
//  Copyright © 2019 JTVC. All rights reserved.
//

import UIKit
import UHNTimeSeriesPlotView

class ViewController: UIViewController {

    @IBOutlet weak var plotView: UHNScrollingTimeSeriesPlotView!
    var counter = 0
    var data : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plotView.setupPlot(withXAxisMin: 0, xAxisMax: plotView.frame.size.width, xMinorStep: 50, xMajorStep: 100, xAxisLabel: nil, xAxisFormatString: nil, yAxisMin: 0, yAxisMax: plotView.frame.size.height - 50 , yMinorStep: 50, yMajorStep: 100, yAxisLabel: nil, yAxisFormatString: nil, gridColor: UIColor.gray, gridFrameWidth: 1, drawGridFrame: true, fadeGridLineEdges: true, lineColor: UIColor.black, lineHead: UIColor.clear, andLineWidth: 1.0)
        
        
        self.plotView.plotRefreshRateInHz = 10;
        self.plotView.samplingRateInHz = 1;
        self.plotView.windowMaxSize = Int(plotView.frame.size.width);
        self.plotView.backgroundColor = UIColor.clear;
        
        getFileDataAndGenerategraph()
    }

    func getFileDataAndGenerategraph() {
        let path = Bundle.main.path(forResource: "beat", ofType: "txt")!
        do {
            let contents = try NSString.init(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            self.data = contents.components(separatedBy: "\n")
            getNextPoint()
            _ = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(self.getNextPoint), userInfo: nil, repeats: true)

        } catch _ as NSError {
            print("error")
        }
        
    }
    
    @objc func getNextPoint() {
        if counter < self.data!.count {
            counter = counter + 1
            let point = data![counter]
            self.plotView.addDataPoint(Int(point) as NSNumber?)
        }
        
    }
}

