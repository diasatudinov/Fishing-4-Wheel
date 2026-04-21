//
//  FWTalkView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct FWTalkView: View {
    @ObservedObject var viewModel: FWSpinViewModel
    
    @State private var rotation: Double = 0
    @State private var selectedTalk: Talk?
    @State private var isSpinning = false
    @State private var showResult = false
    private let spinDuration: Double = 4.0
    @State private var description = ""

    var body: some View {
        ZStack {
            if showResult {
                Color.black.opacity(0.5).ignoresSafeArea()
            }
            
            VStack(spacing: 50) {
                Image(.wheel4FW)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rotation))
                    .padding()
                    .overlay {
                        Image(.wheelFrameFW)
                            .resizable()
                            .scaledToFill()
                    }
                
                Button {
                    spinWheel()
                } label: {
                    
                    Image(.spinChatBtnFW)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                }
                .disabled(showResult || isSpinning)
                .opacity(showResult ? 0.5 : 1)
            }
            .overlay {
                if showResult {
                    Image(.talkModelBgFW)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .overlay {
                            VStack {
                                if let selectedTalk {
                                    VStack {
                                        Text(selectedTalk.title)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                            .multilineTextAlignment(.center)
                                            .textCase(.uppercase)
                                        
                                        Image(selectedTalk.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 60)
                                        
                                        Text(selectedTalk.description)
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .multilineTextAlignment(.center)
                                            .textCase(.uppercase)
                                        
                                    }
                                }
                                
                                Image(.commetsBgFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 38)
                                    .overlay {
                                        TextField("Add a comment...", text: $description)
                                            .padding(.horizontal)
                                    }
                                
                                VStack {
                                    Image(.didItWorkTextFW)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 24)
                                    HStack(spacing: 60) {
                                        Button {
                                            if let selectedTalk {
                                                let talkModel = TalkModel(talk: selectedTalk, description: description, didItWork: false)
                                                viewModel.addTalkModels(talkModel: talkModel)
                                            }
                                            
                                            showResult = false
                                            selectedTalk = nil
                                            description = ""
                                        } label: {
                                            Image(.noFW)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 65)
                                        }
                                        
                                        Button {
                                            if let selectedTalk {
                                                let talkModel = TalkModel(talk: selectedTalk, description: description, didItWork: true)
                                                viewModel.addTalkModels(talkModel: talkModel)
                                            }
                                            
                                            showResult = false
                                            selectedTalk = nil
                                            description = ""
                                        } label: {
                                            Image(.yesFW)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 65)
                                        }
                                    }
                                }
                            }
                        }
                }
            }
            .background(.clear)
            .padding(.top, 20)
            .padding(.bottom, 140)
            
        }
    }
    
    private func spinWheel() {
        guard !isSpinning else { return }
        
        isSpinning = true
        selectedTalk = nil
        
        let sectorCount = viewModel.talks.count
        let sectorAngle = 360.0 / Double(sectorCount)
        
        let targetIndex = Int.random(in: 0..<sectorCount)
        let extraSpins = Double(Int.random(in: 5...8)) * 360.0
        
        // Колесо останавливается на нужном секторе
        let targetAngle = -Double(targetIndex) * sectorAngle
        
        withAnimation(.easeOut(duration: spinDuration)) {
            rotation += extraSpins + targetAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            selectedTalk = viewModel.talks[targetIndex]
            showResult = true
            isSpinning = false
        }
    }
}

#Preview {
    FWTalkView(viewModel: FWSpinViewModel())
}
