//
//  ViewController.swift
//  Firebase_Login_Page
//
//  Created by Mikhail Udotov on 2021-02-07.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?

    @IBOutlet weak var singUpBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hiding navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //Set up video in backgroud
        setUpVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Showing up navigation bar after leaving this view
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setUpElements() {
        
        //Style the elements
        Utilities.styleFilledButton(singUpBtn)
        Utilities.styleHollowButton(loginBtn)
    }
    
    func setUpVideo() {
        //Get the path to the video
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        //Create video player item
        let item = AVPlayerItem(url: url)
        //Create the player
        videoPlayer = AVPlayer(playerItem: item)
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //Add it to rhe view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
    }

}

