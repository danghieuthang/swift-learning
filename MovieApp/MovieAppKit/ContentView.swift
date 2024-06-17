//
//  ContentView.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var storeModel: StoreModel
    @State private var search: String = ""
    @State private var isFetching: Bool = false
    var body: some View {
        VStack {
            List(storeModel.movies) { movie in
                HStack {
                    AsyncImage(url: movie.poster) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(movie.title)
                }
            }
            .searchable(text: $search)
            .onChange(of: search) {
                storeModel.setSearchText(search)
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(StoreModel(webService: WebService()))
    }
}
