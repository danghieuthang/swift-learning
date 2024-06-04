//
//  Section3.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct Section3: View {
    let hikes = [
        Hike(Name: "Salmonbaerry trail", Photo: "image1", Miles: 6),
        Hike(Name: "Ngay xua em den", Photo: "image2", Miles: 5.8),
        Hike(Name: "Toi bo me em roi", Photo: "image3", Miles: 5)
    ]
    var body: some View {
        NavigationStack {
            List(hikes) { hike in
                NavigationLink(value: hike) {
                    HikeCellView(hike: hike)
                }
            }
            .navigationTitle("List")
            .navigationDestination(for: Hike.self) { hike in
                HikeDetailScreen(hike: hike)
            }
        }
    }
}

#Preview {
    Section3()
}

struct HikeCellView: View {
    let hike: Hike
    var body: some View {
        HStack {
            Image(hike.Photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            VStack {
                Text(hike.Name)
                Text("\(hike.Miles.formatted()) miless")
            }
        }
    }
}
