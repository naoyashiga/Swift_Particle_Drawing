//
//  ViewController.swift
//  Swift_Particle_test
//
//  Created by naoyashiga on 2014/06/04.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var particles:Particle[] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setShape()
        
        self.setTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //パーティクルを設定
    func setShape(){
        for i in 0..30{
            //位置
            var px = CGFloat(arc4random() % 320)
            var py = CGFloat(arc4random() % 480)
            var location = CGVector(px,py)
            
            //速度
            var vx = CGFloat(arc4random() % 8)
            var vy = CGFloat(arc4random() % 8)
            
            var velocity = CGVector(vx - 4,vy - 4)
            
            var p = Particle(location:location,velocity:velocity,r:30)
            
            p.createView()
            
            self.view.addSubview(p.view)
            
            particles.append(p)
        }
        
    }
    
    //タイマー設置
    func setTimer(){
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    //繰り返し実行して描画
    func update(){
        for p in particles{
            //壁の当たり判定
            p.bounceWall()
            p.location.dx += p.velocity.dx
            p.location.dy += p.velocity.dy
            
            p.view.frame = CGRect(x:p.location.dx,y:p.location.dy,width:10,height:10)
            
        }
    }
}

class Particle{
    var location:CGVector
    var velocity:CGVector
    var radius:Int
    var view:UIView
    
    init(location:CGVector,velocity:CGVector,r:Int){
        self.location = location
        self.velocity = velocity
        self.radius = r
        self.view = UIView()
    }
    
    func createView(){
        view.frame = CGRect(x:location.dx,y:location.dy,width:10,height:10)
        view.backgroundColor = UIColor.blueColor()
        view.layer.cornerRadius = 5
    }
    
    func bounceWall(){
        //        var screen:UIScreen = UIScreen.mainScreen()
        //        var screenWidth:CGFloat = CGRectGetWidth(screen)
        //        var screenHeight:CGFloat = CGRectGetHeight(screen)
        if location.dx < CGFloat(radius) || location.dx > 320{
            velocity.dx *= -1
        }
        
        if location.dy < CGFloat(radius) || location.dy > 480{
            velocity.dy *= -1
        }
    }
}
