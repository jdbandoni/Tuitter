//
//  TimelineView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import SwiftUI

struct TimelineView: View {
    @ObservedObject var viewModel = TimelineViewModel()
    
    @State var isThreadButtonTapped: Bool = false
    @State var replyTo: Tuit? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.timeline.tuits, id: \.ts) { tuit in
                    TuitCellView(viewModel: TuitCellViewModel(tuitData: tuit), isThreadButtonTapped: $isThreadButtonTapped, replyTo: $replyTo)
                }.refreshable {
                    await viewModel.getTuits()
                }
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink (destination: PostingTuitView()) {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .font(.caption)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding()
                        }
                    }
                    Spacer()
                }
                
            }
            .navigationTitle("Timeline")
            .navigationDestination(isPresented: $isThreadButtonTapped) {
                PostingTuitView(viewModel: PostingTuitViewModel(replyTo: replyTo))
            }

        }.task {
            await viewModel.getTuits()
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
