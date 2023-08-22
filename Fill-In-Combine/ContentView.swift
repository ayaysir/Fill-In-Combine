//
//  ContentView.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/21.
//

import SwiftUI
import Combine

/*
 X:1
 T:
 C:
 %%score ( 1 2 )
 L:1/8
 M:4/4
 Q: 1/4=150
 I:linebreak $
 K:C
 U:n=!style=normal!
 V:1 perc style="x"
 K:none
 V:2 perc
 K:none
 L:1/16
 V:1
 ^a2^g2[c^g]2^g2 ^g2^g2[c^g]2^g2 | ^g2^g2[c^g]2^g2 ^g2^g2[c^g]2^g2 |  ^a2^g2[c^g]2^g2 ^g2^g2[c^g]2^g2 | ncncncnc z nenene nd z ndnd nAnAnAnA |] %2
 V:2
 nF4 nz4 nF4 nz4 |  nF4 nz4 nF4 nz4 |  nF4 nz4 nF4 nz4|] %2
 */

struct ContentView: View {
    
    let primaryLEDColor: Color = .init(red: 1.0, green: 0, blue: 0)
    let subLEDColor: Color = .init(red: 0.3, green: 0.1, blue: 0.6)
    
    @State var counter_8beat: Int = 0
    @State var subscriptions = Set<AnyCancellable>()
    @State var bpm: Float = 90.0
    private let bpmPublisher = PassthroughSubject<Float, Never>()
    
    @State var beatPerBar: Int = 4
    @StateObject var metronomeConductor: MetronomeConductor = MetronomeConductor()
    let soundConductor = SoundConductor()

    @State var isStart: Bool = false
    @State var isLeftLedOn: Bool = true
    @State var isRightLedOn: Bool = false
    @State var leftFillColor: Color = .init(red: 0.3, green: 0.1, blue: 0.6)
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                LEDIndicator(fillColor: $leftFillColor, isOn: $isLeftLedOn)
                    .frame(width: 100)
                    // .animation(.easeInOut(duration: 0.1))
                Rectangle()
                    .foregroundColor(.gray)
                LEDIndicator(fillColor: .constant(subLEDColor), isOn: $isRightLedOn)
                    .frame(width: 100)
            }
            HStack {
                KnobsPanel()
                VStack {
                    Rectangle()
                    Button {
                        isStart.toggle()
                    } label: {
                        Text("Start / Stop")
                    }

                }
                ArcKnob("BPM", value: $bpm, range: 40...210, useMusisyncFontForLabel: false)
            }
            .frame(height: 300)
        }
        .onAppear {
            metronomeConductor.setTo(bpm: bpm, beatPerBar: beatPerBar)
        }
        .onChange(of: isStart) { isStart in
            if isStart {
                metronomeConductor.start()
            } else {
                metronomeConductor.stop()
                // soundConductor.stopAll()
            }
        }
        .onChange(of: metronomeConductor.state) { state in
            guard isStart else {
                return
            }
            
            soundConductor.playTick(state)
            
            switch state {
            case .whole:
                toggleLEDTurn(true, isWhole: true)
            case .quarter:
                toggleLEDTurn()
            case .eighth:
                break
            case .none:
                break
            }
        }
        .onChange(of: bpm) { bpm in
            bpmPublisher.send(bpm)
        }
        .onReceive(bpmPublisher.debounce(for: .milliseconds(500), scheduler: RunLoop.main)) { debouncedBPM in
            self.bpm = debouncedBPM
            
            // soundConductor.stopAll()
            metronomeConductor.changeTo(bpm: floor(bpm))
        }
    }
    
    private func toggleLEDTurn(_ isLeftShouldOn: Bool = false, isWhole: Bool = false) {
        leftFillColor = isWhole ? primaryLEDColor : subLEDColor
        isLeftLedOn = isLeftShouldOn ? true : !isLeftLedOn
        isRightLedOn = !isLeftLedOn
    }
    
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad (10th generation)")
    }
}
