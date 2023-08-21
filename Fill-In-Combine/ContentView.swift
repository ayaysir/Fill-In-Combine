//
//  ContentView.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/21.
//

import SwiftUI

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
    
    @State var counter_8beat: Int = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                metronome(bpm: 172, bpb: 4)
            }
    }
    
    func metronome(bpm: CGFloat = 72.0, bpb: Int = 4) {
        let sleep: CGFloat = 60.0 / bpm
        print("T", terminator: "")
        Timer.scheduledTimer(withTimeInterval: sleep / 2.0, repeats: true) { timer in
            self.counter_8beat += 1
            print(counter_8beat % (bpb * 2) == 0 ? "T" : counter_8beat % 2 == 0 ? "t" : ".", terminator: "")
        }
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
