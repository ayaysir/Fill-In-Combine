//
//  KnobsPanel.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI
import AVFoundation

struct KnobsPanelValues {
    var wholeVolume: Float = 1.0
    var quarterVolume: Float = 0.7
    var eighthVolume: Float = 0.0
    var masterVolume: Float = 0.3
}

struct KnobsPanel: View {
    @State var values = KnobsPanelValues()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ArcKnob("|w", value: $values.wholeVolume)
                ArcKnob("q", value: $values.quarterVolume)
            }
            HStack(spacing: 0) {
                ArcKnob("Ee", value: $values.eighthVolume)
                ArcKnob("MAS", value: $values.masterVolume, useMusisyncFontForLabel: false)
            }
        }.onAppear {
            
        }
    }
}

struct KnobsPanel_Previews: PreviewProvider {
    static var previews: some View {
        KnobsPanel()
    }
}
