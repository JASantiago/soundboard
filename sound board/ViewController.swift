//
//  ViewController.swift
//  sound board
//
//  Created by Jose  Santiago on 11/26/18.
//  Copyright © 2018 Jose  Santiago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var audioPlayer = AVAudioPlayer()
    var playbackFlag = false

    let sounds = ["test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        audioPlayer = AVAudioPlayer()
        
    }
    
    
    //LOGIC
    
    func prepareForPlay(nameOfSound: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: nameOfSound, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            } catch {
                
            }
            
            
        } catch {
            print(error)
        }
    }
    
    func buttonPressed(nameOfSound: String) {
        if playbackFlag {
            playbackFlag = !playbackFlag
            audioPlayer.stop()
            audioPlayer.currentTime = 0
        } else {
            playbackFlag = !playbackFlag
            prepareForPlay(nameOfSound: nameOfSound)
            audioPlayer.play()
        }
    }
    
    // SETUP COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let boardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath)
        
        return boardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buttonPressed(nameOfSound: sounds[indexPath.item])
    }
    
}

