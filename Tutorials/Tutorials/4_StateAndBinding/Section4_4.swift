//
//  Section4_4.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct LightBlueView: View {
    @Binding var isOn: Bool
    var body: some View {
        Image(systemName: isOn ? "lightbulb.fill" : "lightbulb")
            .font(.largeTitle)
            .foregroundStyle(isOn ? .yellow : .black)
        Button("Toggle") {
            isOn.toggle()
        }
    }
}

struct Section4_4: View {
    @State private var isTurnOn: Bool = false
    var body: some View {
        VStack {
            LightBlueView(isOn: $isTurnOn)
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(isTurnOn ? .black : .white)
    }
}

#Preview {
    Section4_4()
}
