//
//  FWMenuView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct DSMenuContainer: View {
    
    @AppStorage("firstOpenBB") var firstOpen: Bool = true
    var body: some View {
        NavigationStack {
            ZStack {
                FWMenuView()
            }
        }
    }
}

struct FWMenuView: View {
    @StateObject private var viewModel = FWSpinViewModel()
    @State var selectedTab = 0
    private let tabs = ["Spin", "Talk", "Stats", "Trips"] //"Edit"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Image(.appBgFW)
                .resizable()
                .ignoresSafeArea()
                
            
            TabView(selection: $selectedTab) {
                FWSpinView(viewModel: viewModel)
                    .tag(0)
                
                FWTalkView(viewModel: viewModel)
                    .tag(1)
                
                FWStatsView(viewModel: viewModel)
                    .tag(2)
                
                FWTripsView(viewModel: viewModel)
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            customTabBar
        }
        .background(.blue)
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    private var customTabBar: some View {
        HStack(spacing: 0) {
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 4) {
                            Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                .resizable()
                                .scaledToFit()
                                .frame(height: selectedTab == index ? 100 : 52)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                    }
                    .offset(y: selectedTab == index ? -10 : 0)
                }
            }
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .background(
                Image(.tabBarBgFW)
                    .resizable()
                    .scaledToFill()
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 35)
        }
        .frame(height: 100)
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconFW"
        case 1: return "tab2IconFW"
        case 2: return "tab3IconFW"
        case 3: return "tab4IconFW"
        case 4: return "tab5IconFW"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelectedFW"
        case 1: return "tab2IconSelectedFW"
        case 2: return "tab3IconSelectedFW"
        case 3: return "tab4IconSelectedFW"
        case 4: return "tab5IconSelectedFW"
        default: return ""
        }
    }
}

#Preview {
    DSMenuContainer()
}
