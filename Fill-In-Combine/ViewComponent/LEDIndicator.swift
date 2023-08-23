//
//  LEDIndicator.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI

struct LEDIndicator: View {
    @Binding var fillColor: Color
    @Binding var isOn: Bool
    @State private var isFlicked: Bool = false
    var isOnAndNotFlicked: Bool {
        return !isFlicked && isOn
    }
    @State var isStarted: Bool = false
    
    private let flickerMillisecond = 100
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                RoundedRectangle(cornerSize: .init(width: 20, height: 15))
                    .frame(width: 50, height: 50)
                    .foregroundColor(isOnAndNotFlicked ? fillColor : .offIndicator)
                    .animation(.linear, value: isFlicked)
                Spacer()
            }
            .onChange(of: isOn) { isOn in
                if !isStarted {
                    isStarted = true
                }
                
                if isOn {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(flickerMillisecond)) {
                        isFlicked = true
                    }
                } else {
                    isFlicked = false
                }
            }
            Spacer()
        }
        .glow(color: (isOnAndNotFlicked ? fillColor : .gray).opacity(isOnAndNotFlicked ? 0.65 : 0.2), radius: 20)
    }
}

@available(iOS 15.0, *)
struct LEDIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LEDIndicator(fillColor: .constant(.cyan), isOn: .constant(true))
    }
}
