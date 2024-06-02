//
//  Section4_5_EnviroimentObject.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/31/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isOn: Bool = false
}

struct LightBulbView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb")
            .font(.largeTitle)
            .foregroundStyle(appState.isOn ? .yellow : .black)
        Button("Toggle") {
            appState.isOn.toggle()
        }
    }
}

struct LightRoomView: View {
    var body: some View {
        LightBulbView()
    }
}

struct Section4_5_EnviroimentObject: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        VStack {
            LightRoomView()
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(appState.isOn ? .black : .white)
    }
}

#Preview {
    Section4_5_EnviroimentObject()
        .environmentObject(AppState())
}
