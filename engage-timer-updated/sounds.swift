//
//  sounds.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/28/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?


func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find or play the sound file")
        }
    }
    
}
