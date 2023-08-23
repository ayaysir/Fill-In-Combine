//
//  ContentView.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let primaryLEDColor: Color = .init(red: 1.0, green: 0, blue: 0)
    let subLEDColor: Color = .init("sub_indicator")
    let normalBlurRadius: CGFloat = 0.5
    
    @State var subscriptions = Set<AnyCancellable>()
    @State var bpm: Float = 90.0
    private let bpmPublisher = PassthroughSubject<Float, Never>()
    @State var beatPerBar: Int = 4
    
    @StateObject var scoresViewModel = ScoresViewModel()
    @StateObject var metronomeConductor = MetronomeConductor()
    @StateObject var knobsPanelViewModel = KnobsPanelViewModel()
    let soundConductor = SoundConductor()

    @State var isStart: Bool = false
    @State var isLeftLedOn: Bool = true
    @State var isRightLedOn: Bool = false
    @State var leftFillColor: Color = .offIndicator
    @State var rightFillColor: Color = .offIndicator
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                LEDIndicator(fillColor: $leftFillColor, isOn: $isLeftLedOn)
                    .frame(width: 80)
                    .blur(radius: normalBlurRadius * 3)
                MusicSheet()
                    .colorInvert()
                    .scaledToFit()
                    .environmentObject(scoresViewModel)
                LEDIndicator(fillColor: $rightFillColor, isOn: $isRightLedOn)
                    .frame(width: 80)
                    .blur(radius: normalBlurRadius * 3)
            }
            HStack {
                KnobsPanel(viewModel: knobsPanelViewModel)
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(subLEDColor)
                            .opacity(0.56)
                            .blur(radius: 2)
                        Text("\(Int(bpm))")
                            .font(.custom(CustomFont.sevenSegement.rawValue, size: 160))
                    }
                   
                    Button {
                        isStart.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(isStart ? .pink : subLEDColor)
                                .opacity(0.5)
                                .blur(radius: 2)
                            Text(isStart ? "STOP" : "START")
                                .font(.custom(CustomFont.neoDunggeunmo.rawValue, size: 32))
                        }
                        
                    }
                    .foregroundColor(.white)
                    .frame(height: 50)
                }
                
                ArcKnob("BPM", value: $bpm, range: 40...210, useMusisyncFontForLabel: false)
            }
            .frame(height: 300)
            // .blur(radius: normalBlurRadius)
        }
        .onAppear {
            metronomeConductor.setTo(bpm: bpm, beatPerBar: beatPerBar)
            scoresViewModel.getScores()
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
                // 악보 변경
                if metronomeConductor.counterEighth % ((beatPerBar * 2) * 2) == 0 {
                    scoresViewModel.getNewRandomScore()
                }
            case .quarter:
                toggleLEDTurn()
            default:
                break
            }
        }
        .onChange(of: bpm) { bpm in
            bpmPublisher.send(bpm)
        }
        .onReceive(bpmPublisher.debounce(for: .milliseconds(100), scheduler: RunLoop.main)) { debouncedBPM in
            self.bpm = debouncedBPM
            
            metronomeConductor.changeTo(bpm: floor(bpm), isNeedStart: isStart)
        }
        .onReceive(knobsPanelViewModel.$values) { values in
            // 앱 실행되었을 때도 값을 받아옴
            soundConductor.setVolume(.whole, to: values.wholeVolume)
            soundConductor.setVolume(.quarter, to: values.quarterVolume)
            soundConductor.setVolume(.eighth, to: values.eighthVolume)
        }
        .onReceive(scoresViewModel.$scores) { scores in
            scoresViewModel.getNewRandomScore()
        }
    }
    
    private func toggleLEDTurn(_ isLeftShouldOn: Bool = false, isWhole: Bool = false) {
        leftFillColor = isWhole ? primaryLEDColor : subLEDColor
        rightFillColor = subLEDColor
        isLeftLedOn = isLeftShouldOn ? true : !isLeftLedOn
        isRightLedOn = !isLeftLedOn
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPad (10th generation)")
    }
}

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
