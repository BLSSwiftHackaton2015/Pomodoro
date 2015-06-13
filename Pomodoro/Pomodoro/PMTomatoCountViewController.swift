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
    @IBAction func runAni(sender: AnyObject) {
        
        self.updateCounter()
        
    }
    var counter: Int = 0;
    
    private func runAnimation() {
        

        tomatoImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001)
        
        
        UIView.animateWithDuration(0.3/1.5, animations: {
            self.tomatoImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1)
            
        }) { _ in
            UIView.animateWithDuration(0.3/2, animations: {
                            self.tomatoImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
                
                }) { _ in
                    
                    UIView.animateWithDuration(0.3/2, animations: { () -> Void in
                        self.tomatoImage.transform = CGAffineTransformIdentity
                    })
                    
            }
        }
        
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
