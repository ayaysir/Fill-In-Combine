//
//  MetronomeConductor.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI
import Combine

enum MetronomeElement {
    case whole
    case quarter
    case eighth
    case none
    
    var textValue: String {
        switch self {
        case .whole:
            return "T"
        case .quarter:
            return "t"
        case .eighth:
            return "."
        case .none:
            return ""
        }
    }
}

class MetronomeConductor: ObservableObject {
    @Published private(set) var state: MetronomeElement = .none
    private var subscriptions = Set<AnyCancellable>()
    
    private(set) var bpm: Float
    private(set) var beatPerBar: Int
    private var timerPublisher: Timer.TimerPublisher!
    
    private var counterEighth: Int = 0
    
    init(bpm: Float = 72.0, beatPerBar: Int = 4) {
        self.bpm = bpm
        self.beatPerBar = beatPerBar
        
        initPublisher()
    }
    
    private func initPublisher() {
        let sleep: Double = Double(60.0 / bpm)
        self.timerPublisher = Timer.publish(every: sleep / 2.0, tolerance: 0.001, on: .main, in: .default)
    }
    
    func start() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .microseconds(100)) { [weak self] in
            guard let self else {
                return
            }
        }
        
        // 1회는 무조건 처음에 실행해야됨
        state = .whole
        
        timerPublisher
            .autoconnect()
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let self else {
                    return
                }
                
                counterEighth += 1
            })
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                
                if counterEighth % (beatPerBar * 2) == 0 {
                    state = .whole
                } else if counterEighth % 2 == 0 {
                    state = .quarter
                } else {
                    state = .eighth
                }
            }
            .store(in: &subscriptions)
    }
    
    func stop() {
        counterEighth = 0
        state = .none
        subscriptions.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    func changeTo(bpm: Float, beatPerBar: Int? = nil) {
        stop()
        self.bpm = bpm
        
        if let beatPerBar {
            self.beatPerBar = beatPerBar
        }
        
        initPublisher()
        start()
    }
    
    func setTo(bpm: Float, beatPerBar: Int) {
        self.bpm = bpm
        self.beatPerBar = beatPerBar
    }
}


/*
 func metronome(bpm: Float = 72.0, bpb: Int = 4) {
     let sleep: Float = 60.0 / bpm
     print("T", terminator: "")
     Timer.scheduledTimer(withTimeInterval: sleep / 2.0, repeats: true) { timer in
         self.counter_8beat += 1
         print(counter_8beat % (bpb * 2) == 0 ? "T" : counter_8beat % 2 == 0 ? "t" : ".", terminator: "")
     }
 }
 
 func metronomeCombine(bpm: Float = 72.0, bpb: Int = 4) {
     
     let sleep: Float = 60.0 / bpm
     let timerPublisher = Timer.publish(every: sleep / 2.0, tolerance: 0.01, on: .main, in: .default)
     
     // 1회는 무조건 실행해야됨
     print("S")
     
     timerPublisher
         .autoconnect()
         .sink { _ in
             counter_8beat += 1
             print(counter_8beat % (bpb * 2) == 0 ? "T" : counter_8beat % 2 == 0 ? "t" : ".", terminator: "")
         }
         .store(in: &subscriptions)
 }
 */
