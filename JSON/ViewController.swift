//
//  ViewController.swift
//  JSON
//
//  Created by Stefan Djordjevic on 3/16/17.
//  Copyright © 2017 Stefan Djordjevic. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var Res=[Odgovor]()
    var index = Int ()
    @IBOutlet weak var labela: UILabel!
    @IBOutlet weak var dugme: UIButton!
    @IBOutlet weak var texttt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saljiii(_ sender: Any) {
        
        
        let newString = texttt.text
        
        var ur = newString?.replacingOccurrences(of: " ", with: "+")
        
        var names = [String]()
        
        let url = URL(string: "http://quadrixsoft.com/findmusic/public/search?text="+ur!)
        let task = URLSession.shared.dataTask(with: url!) { (data ,response , error) in
            if error != nil{
                print ("ERROR")
            }
            else{
                if let content = data{
                    do {
                        
                        let myJson = try JSONSerialization.jsonObject(with: content) as? [[String:Any]]
                        
                        var Name=String();
                        var Url=String()
                        var type=String()
                        
                        for blog in myJson! {
                            if let name = blog["name"] as? String {
                                Name=name
                            }
                            if let url = blog["url"] as? String {
                                Url=url
                            }
                            
                            if let tip = blog["type"] as? String {
                                type=tip
                            }
                            
                            var mee = Odgovor()
                            
                            mee.name=Name
                            mee.type=type
                            mee.url=Url
                            self.Res.append(mee)
                            
                            
                        }
                        if self.ispitaj(){
                            let url = NSURL(string: self.Res[self.index].url)!
                            UIApplication.shared.openURL(url as URL)
                            
                            
                            
                            /*
                             let videoURL = NSURL(string: "https://youtu.be/d88APYIGkjk")
                             let player = AVPlayer(URL: videoURL!)
                             let playerViewController = AVPlayerViewController()
                             playerViewController.player = player
                             self.presentViewController(playerViewController, animated: true) {
                             
                             playerViewController.player!.play()
                             
                             }*/
                            
                        }
                        
                    }
                        
                        
                    catch{
                        print ("error")
                    }
                }
            }
            
        }
        task.resume()
        
        
    }
    func ispitaj() -> Bool {
        
        for i in 0..<Res.count{
            
            if(Res[i].url.contains("youtube"))
            {
                print("ima")
                index = i
                return true
            }
        }
        return false
    }

  
}

