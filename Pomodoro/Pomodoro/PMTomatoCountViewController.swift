//
//  PMTomatoCountViewController.swift
//  Pomodoro
//
//  Created by Tomasz Bilski on 13.06.2015.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit


class PMTomatoCountViewController: UIViewController {

    @IBOutlet weak var tomatoImage: UIImageView!
    @IBOutlet weak var tomatoCounter: UILabel!

    @IBOutlet weak var toRemove: UILabel!
    @IBOutlet weak var startAnimation: UIButton!
    
    
    
    @IBAction func startAnim(sender: AnyObject) {
        
        runAnimation()
        
        
    }
    
    
    
    var counter: Int = 0;
    
    var pulseAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
    
    func runAnimation() {
        
        var tr: CATransform3D = CATransform3DIdentity;

        tr = CATransform3DScale(tr, 1, 1, 3);
        
        pulseAnimation.duration = 1.0
        pulseAnimation.toValue = NSValue(CATransform3D: tr)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 0
        self.toRemove.layer.addAnimation(pulseAnimation, forKey: "opacity")
        
      
    
    }
    
    func updateCounter() {
    
        tomatoCounter.text = String(counter++)
        

        self.runAnimation()
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tomatoCounter.text = "\(counter)"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
