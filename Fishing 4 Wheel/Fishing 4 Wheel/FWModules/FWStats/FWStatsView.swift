//
//  FWStatsView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct FWStatsView: View {
    @ObservedObject var viewModel: FWSpinViewModel
    
    var body: some View {
        ZStack {
            Color.clear
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    Image(.statsText1FW)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 59)
                    
                    StatCardView(
                        title: "TOTAL EXPEDITION",
                        value: "\(viewModel.totalExpeditions)",
                        trailingAssetName: "fishFW",
                        secondaryText: growthText
                    )
                    
                    StatCardView(
                        title: "FAVORITE COMPANY",
                        value: favoriteCompanyTitle,
                        trailingAssetName: viewModel.favoriteCompanyStat?.imageName
                    )
                    
                    StatCardView(
                        title: "FAVORITE DURATION",
                        value: favoriteDurationTitle,
                        trailingAssetName: viewModel.favoriteDurationStat?.imageName
                    )
                    
                    StatCardView(
                        title: "4TH WHEEL SUCCESS RATE",
                        value: "\(viewModel.successRatePercent)%",
                        trailingAssetName: "yesFW"
                    )
                    
                    TripsByMonthCard(stats: viewModel.tripsByLastSixMonths)
                    
                    CompanyPieCard(stats: viewModel.companyShareStats)
                }
                .padding(.horizontal, 14)
                .padding(.top, 12)
                .padding(.bottom, 140)
            }
        }
    }
    
    private var growthText: String? {
        guard let percent = viewModel.expeditionGrowthPercent else { return nil }
        return percent >= 0 ? "+\(percent)%" : "\(percent)%"
    }
    
    private var favoriteCompanyTitle: String {
        if let company = viewModel.favoriteCompanyStat {
            return company.title.uppercased()
        }
        return "-"
    }
    
    private var favoriteDurationTitle: String {
        if let duration = viewModel.favoriteDurationStat {
            return duration.title.uppercased()
        }
        return "-"
    }
    
    private var header: some View {
        VStack(spacing: 4) {
            Text("YOUR FISHING STATS")
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundColor(.pink)
                .shadow(color: .blue.opacity(0.35), radius: 0, x: 2, y: 2)
            
            Text("A LOOK AT YOUR RECENT TRIPS")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.36, green: 0.24, blue: 0.65))
        }
        .padding(.top, 4)
    }
}

#Preview {
    FWStatsView(viewModel: FWSpinViewModel())
}
