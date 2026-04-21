//
//  TripsByMonthCard.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct TripsByMonthCard: View {
    let stats: [MonthTripStat]
    
    var maxValue: Int {
        max(stats.map(\.count).max() ?? 1, 1)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("TRIPS BY MONTH")
                .font(.system(size: 17, weight: .black, design: .rounded))
                .foregroundColor(Color(red: 0.48, green: 0.40, blue: 0.67))
            
            HStack(alignment: .bottom, spacing: 14) {
                ForEach(stats) { item in
                    VStack(spacing: 8) {
                        GeometryReader { geo in
                            VStack {
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [.yellow, .orange],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .stroke(Color.orange.opacity(0.9), lineWidth: 2)
                                    )
                                    .frame(height: barHeight(totalHeight: geo.size.height, value: item.count))
                            }
                        }
                        .frame(height: 120)
                        
                        Text(item.title)
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundColor(Color(red: 0.12, green: 0.08, blue: 0.45))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(red: 0.92, green: 0.82, blue: 0.94).opacity(0.95))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color(red: 0.25, green: 0.23, blue: 0.55), lineWidth: 2)
                )
        )
    }
    
    private func barHeight(totalHeight: CGFloat, value: Int) -> CGFloat {
        guard maxValue > 0 else { return 8 }
        let progress = CGFloat(value) / CGFloat(maxValue)
        return max(16, totalHeight * progress)
    }
}
