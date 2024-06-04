//
//  Section2.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct Section2: View {
    var body: some View {
        VStack {
            Image("viper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Rectangle())
            AsyncImage(url: URL(string: "https://plus.unsplash.com/premium_photo-1683865776032-07bf70b0add1?q=80&w=3732&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")) {
                image in image.resizable()
            }placeholder: {
                ProgressView("Downloading")
            }

            Text("First line!")
                .foregroundStyle(.red)
                .font(.title)
            Text("Second line!")
                .foregroundStyle(.yellow)
                .font(.title3)
            Text("Third line!")
                .foregroundStyle(.green)
            HStack {
                Text("Left")
                Text("Right")
                    .foregroundStyle(.cyan)
                    .fontWeight(.heavy)
            }
        }
        .padding()
    }
}

#Preview {
    Section2()
}
