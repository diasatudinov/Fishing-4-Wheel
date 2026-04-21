//
//  FWSpinView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct FWSpinView: View {
    @ObservedObject var viewModel: FWSpinViewModel
    
    @State private var step = 0
    
    @State private var rotation: Double = 0
    @State private var selectedItem: Entertainment?
    @State private var selectedCompany: Company?
    @State private var selectedDuration: Duration?
    @State private var isSpinning = false
    @State private var showResult = false
    
    private let spinDuration: Double = 4.0
    
    var body: some View {
        ScrollView {
            VStack {
                switch step {
                case 0:
                    VStack(spacing: 24) {
                        Image(.spinFirstTextFW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 55)
                        
                        
                        Image(.wheel1FW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 314)
                            .rotationEffect(.degrees(rotation))
                            .overlay {
                                Image(.wheelFrameFW)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .overlay {
                                Button {
                                    spinWheel1()
                                } label: {
                                    
                                    Image(.spinBtnFW)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 80)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                        
                        
                        VStack(spacing: 8) {
                            Image(.spinSecondTextFW)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            HStack {
                                
                                ForEach(showStepStick(), id: \.self) { step in
                                    Image(step)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 12)
                                }
                                
                            }
                        }
                        
                        Button {
                            step = 1
                        } label: {
                            Image(.nextBtnFW)
                                .resizable()
                                .scaledToFit()
                        }
                        .disabled(selectedItem == nil)
                        .opacity(selectedItem == nil ? 0.5 : 1)
                        .padding(.horizontal)
                    }
                case 1:
                    VStack(spacing: 24) {
                        Image(.spin2FirstTextFW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 55)
                        
                        
                        Image(.wheel2FW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 314)
                            .rotationEffect(.degrees(rotation))
                            .overlay {
                                Image(.wheelFrameFW)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .overlay {
                                Button {
                                    spinWheel2()
                                } label: {
                                    
                                    Image(.spinBtnFW)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 80)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                        
                        
                        VStack(spacing: 8) {
                            Image(.spin2SecondTextFW)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            HStack {
                                
                                ForEach(showStepStick(), id: \.self) { step in
                                    Image(step)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 12)
                                }
                                
                            }
                        }
                        
                        Button {
                            step = 2
                        } label: {
                            Image(.nextBtnFW)
                                .resizable()
                                .scaledToFit()
                        }
                        .disabled(selectedCompany == nil)
                        .opacity(selectedCompany == nil ? 0.5 : 1)
                        .padding(.horizontal)
                    }
                case 2:
                    VStack(spacing: 24) {
                        Image(.spin3FirstTextFW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 55)
                        
                        
                        Image(.wheel3FW)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 314)
                            .rotationEffect(.degrees(rotation))
                            .overlay {
                                Image(.wheelFrameFW)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .overlay {
                                Button {
                                    spinWheel3()
                                } label: {
                                    
                                    Image(.spinBtnFW)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 80)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                        
                        
                        VStack(spacing: 8) {
                            Image(.spin3SecondTextFW)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            HStack {
                                
                                ForEach(showStepStick(), id: \.self) { step in
                                    Image(step)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 12)
                                }
                                
                            }
                        }
                        
                        Button {
                            showResult = true
                        } label: {
                            Image(.nextBtnFW)
                                .resizable()
                                .scaledToFit()
                        }
                        .disabled(selectedDuration == nil)
                        .opacity(selectedDuration == nil ? 0.5 : 1)
                        .padding(.horizontal)
                    }
                default:
                    Text("Error")
                }
                
            }
        }
        .overlay {
            if showResult {
                Image(.spinComboBgFW)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                    .overlay {
                        VStack {
                            Text("Your fishing\ncombo")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .multilineTextAlignment(.center)
                                .textCase(.uppercase)
                            
                            HStack {
                                if let selectedItem {
                                    VStack {
                                        Image(selectedItem.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 60)
                                        
                                        Text(selectedItem.title)
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .textCase(.uppercase)
                                        
                                    }
                                }
                                
                                Image(.plusFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                
                                if let selectedCompany {
                                    VStack {
                                        Image(selectedCompany.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 60)
                                        
                                        Text(selectedCompany.title)
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .textCase(.uppercase)
                                    }
                                }
                                
                                Image(.plusFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                
                                if let selectedDuration {
                                    VStack {
                                        Image(selectedDuration.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 60)
                                        
                                        Text(selectedDuration.title)
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .textCase(.uppercase)
                                    }
                                }
                            }
                            
                            Button {
                                if let selectedItem, let selectedCompany, let selectedDuration {
                                    let spinCombo = SpinCombo(entertainment: selectedItem, company: selectedCompany, duration: selectedDuration)
                                    viewModel.addSpinCombo(spinCombo: spinCombo)
                                }
                                
                                showResult = false
                                selectedItem = nil
                                selectedCompany = nil
                                selectedDuration = nil
                                step = 0
                            } label: {
                                Image(.savePlanBtnFW)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            }
                        }
                    }
            }
        }
        .background(.clear)
        .padding(.top, 20)
        .padding(.bottom, 140)
        
    }

    private func showStepStick() -> [String] {
        switch step {
        case 0:
            return ["pinkRecFW","purpleRecFW","purpleRecFW"]
        case 1:
            return ["pinkRecFW","pinkRecFW","purpleRecFW"]
        case 2:
            return ["pinkRecFW","pinkRecFW","pinkRecFW"]
        default:
            return []
        }
    }
    
    private func spinWheel1() {
        guard !isSpinning else { return }
        
        isSpinning = true
        selectedItem = nil
        
        let sectorCount = viewModel.entertaiments.count
        let sectorAngle = 360.0 / Double(sectorCount)
        
        let targetIndex = Int.random(in: 0..<sectorCount)
        let extraSpins = Double(Int.random(in: 5...8)) * 360.0
        
        // Колесо останавливается на нужном секторе
        let targetAngle = -Double(targetIndex) * sectorAngle
        
        withAnimation(.easeOut(duration: spinDuration)) {
            rotation += extraSpins + targetAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            selectedItem = viewModel.entertaiments[targetIndex]
            isSpinning = false
        }
    }
    
    private func spinWheel2() {
        guard !isSpinning else { return }
        
        isSpinning = true
        selectedCompany = nil
        
        let sectorCount = viewModel.companies.count
        let sectorAngle = 360.0 / Double(sectorCount)
        
        let targetIndex = Int.random(in: 0..<sectorCount)
        let extraSpins = Double(Int.random(in: 5...8)) * 360.0
        
        // Колесо останавливается на нужном секторе
        let targetAngle = -Double(targetIndex) * sectorAngle
        
        withAnimation(.easeOut(duration: spinDuration)) {
            rotation += extraSpins + targetAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            selectedCompany = viewModel.companies[targetIndex]
            isSpinning = false
        }
    }
    
    private func spinWheel3() {
        guard !isSpinning else { return }
        
        isSpinning = true
        selectedDuration = nil
        
        let sectorCount = viewModel.durations.count
        let sectorAngle = 360.0 / Double(sectorCount)
        
        let targetIndex = Int.random(in: 0..<sectorCount)
        let extraSpins = Double(Int.random(in: 5...8)) * 360.0
        
        // Колесо останавливается на нужном секторе
        let targetAngle = -Double(targetIndex) * sectorAngle
        
        withAnimation(.easeOut(duration: spinDuration)) {
            rotation += extraSpins + targetAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            selectedDuration = viewModel.durations[targetIndex]
            isSpinning = false
        }
    }
}

#Preview {
    FWSpinView(viewModel: FWSpinViewModel())
}
