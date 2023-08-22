//
//  SoundConductor.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import AVFoundation
import Starling

class SoundConductor {
    let starlingWhole = Starling()
    let starlingQuarter = Starling()
    let starlingEighth = Starling()
    
    let bigUrl = Bundle.main.url(forResource: "Woodblock_Big", withExtension: "aif")
    let smallUrl = Bundle.main.url(forResource: "Woodblock_Small", withExtension: "aif")
    
    init() {
        guard let bigUrl, let smallUrl else {
            print("SoundConductor init error: sound url is nil.")
            return
        }
        
        starlingWhole.load(sound: bigUrl, for: "")
        starlingQuarter.load(sound: smallUrl, for: "")
        starlingEighth.load(sound: smallUrl, for: "")
    }
    
    func playTick(_ state: MetronomeElement) {
        switch state {
        case .whole:
            starlingWhole.play("")
        case .quarter:
            starlingQuarter.play("")
        case .eighth:
            starlingEighth.play("")
        case .none:
            break
        }
    }
    
    func setVolume(_ state: MetronomeElement, to value: Float) {
        switch state {
        case .whole:
            starlingWhole.setVolume(to: value)
        case .quarter:
            starlingQuarter.setVolume(to: value)
        case .eighth:
            starlingEighth.setVolume(to: value)
        case .none:
            break
        }
    }
}
