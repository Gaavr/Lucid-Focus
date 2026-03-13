//
//  SoundService.swift
//  Lucid Focus
//
//  Created by Andrei Gavrilenko on 12.03.2026.
//

import AVFoundation
import Foundation

final class SoundService {
    
    static let instance = SoundService()
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func play(_ sound: TimerSound) {
        guard let url = Bundle.main.url(
            forResource: sound.rawValue,
            withExtension: sound.fileExtension
        ) else {
            print("Error: Sound file not found in bundle")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}
