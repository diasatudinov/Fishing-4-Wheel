//
//  FWTripsView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

enum TripsState {
    case wheels, talk
}
struct FWTripsView: View {
    @ObservedObject var viewModel: FWSpinViewModel
    @State private var page: TripsState = .wheels
    var body: some View {
        VStack {
            HStack {
                Image(page == .wheels ? .wheelsOn : .wheelsOff)
                    .resizable()
                    .scaledToFit()
                    .frame(height: page == .wheels ? 46 : 40)
                    .onTapGesture {
                        withAnimation {
                            page = .wheels
                        }
                    }
                
                Image(page == .talk ? .talkOn : .talkOff)
                    .resizable()
                    .scaledToFit()
                    .frame(height: page == .talk ? 46 : 40)
                    .onTapGesture {
                        withAnimation {
                            page = .talk
                        }
                    }
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if page == .wheels {
                        ForEach(viewModel.spinCombos) { spin in
                            ZStack {
                                Image(.tripsBgFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(dateTitle(for: spin.createdAt)) -")
                                        
                                        Text(spin.createdAt > Date.now ? "Planned" : "Completed")
                                    }
                                    .font(.system(size: 20, weight: .black, design: .rounded))
                                    .foregroundStyle(.blue)
                                    .multilineTextAlignment(.center)
                                    .textCase(.uppercase)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(spin.entertainment.title) + \(spin.company.title) + \(spin.duration.title)")
                                        .font(.system(size: 15, weight: .black, design: .rounded))
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.center)
                                        .textCase(.uppercase)
                                    
                                }
                                .padding(.horizontal, 32)
                            }
                        }
                    } else {
                        ForEach(viewModel.talkModels) { talk in
                            ZStack {
                                Image(.tripsBgFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(dateTitle(for: talk.createdAt)) -")
                                        
                                        Text(talk.createdAt > Date.now ? "Planned" : "Completed")
                                    }
                                    .font(.system(size: 20, weight: .black, design: .rounded))
                                    .foregroundStyle(.blue)
                                    .multilineTextAlignment(.center)
                                    .textCase(.uppercase)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(talk.talk.title). \(talk.talk.description)")
                                        .font(.system(size: 15, weight: .black, design: .rounded))
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                        .textCase(.uppercase)
                                    
                                }
                                .padding(.horizontal, 32)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func dateTitle(for date: Date) -> String {
            let formatter = DateFormatter()
            formatter.calendar = Calendar.current
            formatter.dateFormat = "LLLL dd"  // например, "Январь 2025"
            return formatter.string(from: date).capitalized
        }
}

#Preview {
    FWTripsView(viewModel: FWSpinViewModel())
}
