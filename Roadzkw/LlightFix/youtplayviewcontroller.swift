//
//  youtplayviewcontroller.swift
//  Roadzkw
//
//  Created by Apple on 25/01/20.
//  Copyright © 2020 LightFix iCode. All rights reserved.
//

import UIKit
import  YoutubeKit
class youtplayviewcontroller: UIViewController {

    @IBOutlet weak var playvideo:UIView!
     private var player: YTSwiftyPlayer!
    var video_ID  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    configurePlayer()
        
    }
    
       func configurePlayer(){
  print(video_ID)
           // Create a new player
//           player = YTSwiftyPlayer(
//            frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.width
//                * 9 / 16),
//               playerVars: [.playsInline(true), .videoID(video_ID), .loopVideo(false), .showRelatedVideo(false)])
                //
        player = YTSwiftyPlayer(
                   frame: CGRect(x: 0, y:60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 9 / 16),
                   playerVars: [.playsInline(true), .videoID(video_ID), .loopVideo(false), .showRelatedVideo(false)])
               

           // Enable auto playback when video is loaded
           player.autoplay = true

           // Set player view

           //        playerView = player
           playvideo.addSubview(player)
           // Set delegate for detect callback information from the player
           player.delegate = self

           // Load video player
           player.loadPlayer()
       }
//
   


    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
}

//MARK:- Youtube delegate
extension youtplayviewcontroller: YTSwiftyPlayerDelegate {
    
    func playerReady(_ player: YTSwiftyPlayer) {
       // printDebug(#function)
    }
    
    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
       
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
    //    printDebug("\(#function):\(state)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        //printDebug("\(#function):\(playbackRate)")
    }
    
    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        //printDebug("\(#function):\(error)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
       // printDebug("\(#function):\(quality)")
    }
    
    func apiDidChange(_ player: YTSwiftyPlayer) {
        //printDebug(#function)
    }
    
    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
      //  printDebug(#function)
    }
    
    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
      //  printDebug(#function)
    }
    
   
}
