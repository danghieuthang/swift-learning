//
//  Section4.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct Section4: View {
    @State private var counter: Int = 0
    var body: some View {
        VStack {
            Text("Hello World")
            Text("\(counter)")
                .font(.largeTitle)
            Button("Increment") {
                counter = counter + 1
            }
        }
    }
}

#Preview {
    Section4()
}
