//
//  CompanyPieCard.swift
//  Fishing 4 Wheel
//
//

import SwiftUI
import Charts

struct CompanyPieCard: View {
    let stats: [CompanyShareStat]
    
    private let sliceColors: [Color] = [
        .yellow,
        .purple,
        .orange,
        .pink,
        .cyan,
        .blue
    ]
    
    var body: some View {
        VStack(spacing: 18) {
            Text("WHO YOU FISH WITH")
                .font(.system(size: 17, weight: .black, design: .rounded))
                .foregroundColor(Color(red: 0.48, green: 0.40, blue: 0.67))
            
            PieChartView(
                values: stats.map { max($0.count, 0) },
                colors: Array(sliceColors.prefix(stats.count))
            )
            .frame(width: 180, height: 180)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 12
            ) {
                ForEach(Array(stats.enumerated()), id: \.element.id) { index, item in
                    VStack(spacing: 4) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34, height: 34)
                        
                        Text("\(item.percent)%")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .foregroundColor(Color(red: 0.12, green: 0.08, blue: 0.45))
                    }
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
}
