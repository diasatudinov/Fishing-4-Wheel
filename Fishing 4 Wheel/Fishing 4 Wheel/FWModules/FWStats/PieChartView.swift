//
//  PieChartView.swift
//  Fishing 4 Wheel
//
//

import SwiftUI
import Charts

struct PieChartView: View {
    let values: [Int]
    let colors: [Color]
    
    private var total: Int {
        values.reduce(0, +)
    }
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let rect = CGRect(origin: .zero, size: CGSize(width: size, height: size))
            
            ZStack {
                if total > 0 {
                    ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                        PieSlice(
                            startAngle: startAngle(for: index),
                            endAngle: endAngle(for: index)
                        )
                        .fill(colors[index % colors.count])
                    }
                    
                    Circle()
                        .stroke(Color.green, lineWidth: 3)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                    
                    Circle()
                        .stroke(Color.green, lineWidth: 3)
                }
            }
            .frame(width: rect.width, height: rect.height)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func startAngle(for index: Int) -> Angle {
        let previousSum = values.prefix(index).reduce(0, +)
        let degrees = (Double(previousSum) / Double(total)) * 360 - 90
        return .degrees(degrees)
    }
    
    private func endAngle(for index: Int) -> Angle {
        let currentSum = values.prefix(index + 1).reduce(0, +)
        let degrees = (Double(currentSum) / Double(total)) * 360 - 90
        return .degrees(degrees)
    }
}

struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        var path = Path()
        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        path.closeSubpath()
        return path
    }
}
