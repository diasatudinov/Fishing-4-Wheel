//
//  StatCardView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct StatCardView: View {
    let title: String
    let value: String
    var trailingAssetName: String? = nil
    var trailingImageName: String? = nil
    var secondaryText: String? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(Color(red: 0.48, green: 0.40, blue: 0.67))
                
                Text(value)
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundColor(Color(red: 0.12, green: 0.08, blue: 0.45))
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                
                if let secondaryText {
                    Text(secondaryText)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            
            ZStack {
                
                if let trailingAssetName {
                    Image(trailingAssetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                } else if let trailingImageName {
                    Image(systemName: trailingImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 130)
        .background {
            Image(.statsBgFW)
                .resizable()
                .scaledToFit()
                
        }
        
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Color(red: 0.92, green: 0.82, blue: 0.94).opacity(0.95))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color(red: 0.25, green: 0.23, blue: 0.55), lineWidth: 2)
            )
    }
}

#Preview {
    FWStatsView(viewModel: FWSpinViewModel())
}
