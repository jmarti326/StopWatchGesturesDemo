//
//  SWViewController.swift
//  SimpleStopDemo
//
//  Created by Ravi Shankar on 22/07/14.
//  Copyright (c) 2014 Ravi Shankar. All rights reserved.
//

import UIKit

class SWViewController: UIViewController {
    
    @IBOutlet var displayTimeLabel: UILabel!
    
    var startTime = NSTimeInterval()
    
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aSelector : Selector = "start:"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        let tap1 = UIGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let bSelector : Selector = "stop:"
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: bSelector)
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        
        let cSelector : Selector = "reset:"
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)

    }
    
    @IBAction func start(sender: AnyObject) {
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func reset(sender: AnyObject) {
        displayTimeLabel.text = "00:00:00"
    }
    
    func updateTime() {
        let calculatedTime = getTimeAttributes()
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = calculatedTime.minutes + ":" + calculatedTime.seconds + ":" + calculatedTime.fraction
    }
    
    func getTimeAttributes() -> (minutes: String, seconds: String, fraction: String) {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        return (strMinutes, strSeconds, strFraction)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
