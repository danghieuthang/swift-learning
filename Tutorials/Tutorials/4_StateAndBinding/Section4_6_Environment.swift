//
//  Section4_6_Environment.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/31/24.
//

import Observation
import SwiftUI

@Observable
class AppState2 {
    var isOn: Bool = false
}

struct LightBulbView2: View {
    @Environment(AppState2.self) private var appState: AppState2
    var body: some View {
        @Bindable var appState = appState
        Image(systemName: appState.isOn ? "lightbulb.fill" : "lightbulb")
            .font(.largeTitle)
            .foregroundStyle(appState.isOn ? .yellow : .black)
        Button("Toggle") {
            appState.isOn.toggle()
        }
        Toggle("IsOn", isOn: $appState.isOn)
    }
}

struct LightRoomView2: View {
    var body: some View {
        LightBulbView2()
    }
}

struct Section4_6_Environment: View {
    @Environment(AppState2.self) private var appState: AppState2
    var body: some View {
        VStack {
            LightRoomView2()
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(appState.isOn ? .black : .white)
    }
}

#Preview {
    Section4_6_Environment()
        .environment(AppState2())
}
