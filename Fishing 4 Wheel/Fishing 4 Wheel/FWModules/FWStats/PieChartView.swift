struct PieChartView: View {
    let values: [Int]
    let colors: [Color]
    
    private var total: Double {
        Double(max(values.reduce(0, +), 1))
    }
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let lineWidth = size * 0.48
            
            ZStack {
                ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                    let start = startAngle(for: index)
                    let end = endAngle(for: index)
                    
                    Circle()
                        .trim(from: start, to: end)
                        .stroke(
                            colors[index % colors.count],
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt, lineJoin: .round)
                        )
                        .rotationEffect(.degrees(-90))
                }
                
                Circle()
                    .stroke(Color.green, lineWidth: 3)
            }
            .frame(width: size, height: size)
        }
    }
    
    private func startAngle(for index: Int) -> CGFloat {
        let previous = values.prefix(index).reduce(0, +)
        return CGFloat(Double(previous) / total)
    }
    
    private func endAngle(for index: Int) -> CGFloat {
        let current = values.prefix(index + 1).reduce(0, +)
        return CGFloat(Double(current) / total)
    }
}