//
//  Section4_2.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct Section4_2: View {
    @State private var isOn: Bool = false
    @State private var name: String = ""
    @State private var friends: [String] = []
    var body: some View {
        VStack {
            TextField("Enter Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    friends.append(name)
                    name = ""
                }
            List(friends, id: \.self) {
                friend in
                Text(friend)
            }
            Spacer()
            Toggle(isOn: $isOn, label: {
                Text(isOn ? "ON" : "OFF")
                    .foregroundStyle(isOn ? .yellow : .black)
            }).fixedSize()
            Spacer()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
//        .background(isOn ? .white : .black)
    }
}

#Preview {
    Section4_2()
}
