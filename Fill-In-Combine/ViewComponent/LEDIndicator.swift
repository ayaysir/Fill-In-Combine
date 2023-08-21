//
//  LEDIndicator.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI

struct LEDIndicator: View {
    @State var fillColor: Color
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(fillColor)
                Spacer()
            }
            Spacer()
        }
    }
}

@available(iOS 15.0, *)
struct LEDIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LEDIndicator(fillColor: .cyan)
    }
}
