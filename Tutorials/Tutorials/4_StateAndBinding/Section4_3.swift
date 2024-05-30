//
//  Section4_3.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import SwiftUI

struct Section4_3: View {
    @State private var search: String = ""
    @State private var friends: [String] = ["Thang", "Son", "Hoang", "Dai"]
    @State private var filterFriends: [String] = []

    var body: some View {
        VStack {
            List(filterFriends, id: \.self) { friend in
                Text(friend)
            }
            .listStyle(.plain)
            .searchable(text: $search)
            .onChange(of: search) {
                if search.isEmpty {
                    filterFriends = friends
                } else {
                    filterFriends = friends.filter {
                        $0.contains(search)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            filterFriends = friends
        }
        .navigationTitle("Friends")
    }
}

#Preview {
    NavigationStack {
        Section4_3()
    }
}
