//
//  SoundConductor.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import AVFoundation
import Starling

class SoundConductor {
    // private var tickWholePlayer: AVAudioPlayer?
    // private var tickQuarterPlayer: AVAudioPlayer?
    // private var tickEighthPlayer: AVAudioPlayer?
    
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
        
        do {
            // tickWholePlayer = try AVAudioPlayer(contentsOf: bigUrl, fileTypeHint: AVFileType.aiff.rawValue)
            // tickQuarterPlayer = try AVAudioPlayer(contentsOf: smallUrl, fileTypeHint: AVFileType.aiff.rawValue)
            // tickEighthPlayer = try AVAudioPlayer(contentsOf: smallUrl, fileTypeHint: AVFileType.aiff.rawValue)
            

            
            // prepareAll()
        } catch {
            print("player init error:")
        }
    }
    
    func playTick(_ tick: MetronomeElement) {
        // DispatchQueue.global().async { [weak self] in
        //     guard let self else {
        //         return
        //     }
        //
        //     switch tick {
        //     case .whole:
        //         tickWholePlayer?.play()
        //     case .quarter:
        //         tickQuarterPlayer?.play()
        //     case .eighth:
        //         tickEighthPlayer?.play()
        //     case .none:
        //         stopAll()
        //     }
        // }
        
        
        switch tick {
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
    
    // func stopAll() {
    //     DispatchQueue.global().async { [weak self] in
    //         guard let self else {
    //             return
    //         }
    //
    //         tickWholePlayer?.stop()
    //         tickQuarterPlayer?.stop()
    //         tickEighthPlayer?.stop()
    //
    //         prepareAll()
    //     }
    // }
    //
    // private func prepareAll() {
    //     tickWholePlayer?.prepareToPlay()
    //     tickQuarterPlayer?.prepareToPlay()
    //     tickEighthPlayer?.prepareToPlay()
    // }
}
