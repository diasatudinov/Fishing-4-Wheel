import Foundation

struct MonthTripStat: Identifiable {
    let id = UUID()
    let title: String
    let count: Int
}

struct CompanyShareStat: Identifiable {
    let id: Int
    let title: String
    let imageName: String
    let count: Int
    let percent: Int
}

extension FWSpinViewModel {
    
    var totalExpeditions: Int {
        spinCombos.count
    }
    
    var favoriteCompanyStat: Company? {
        let grouped = Dictionary(grouping: spinCombos, by: { $0.company.id })
        guard let favoriteID = grouped.max(by: { $0.value.count < $1.value.count })?.key else {
            return nil
        }
        return companies.first(where: { $0.id == favoriteID })
    }
    
    var favoriteDurationStat: Duration? {
        let grouped = Dictionary(grouping: spinCombos, by: { $0.duration.id })
        guard let favoriteID = grouped.max(by: { $0.value.count < $1.value.count })?.key else {
            return nil
        }
        return durations.first(where: { $0.id == favoriteID })
    }
    
    /// Используем talkModels.didItWork как success rate
    var successRatePercent: Int {
        guard !talkModels.isEmpty else { return 0 }
        let successCount = talkModels.filter(\.didItWork).count
        let value = (Double(successCount) / Double(talkModels.count)) * 100
        return Int(value.rounded())
    }
    
    /// Рост относительно прошлого месяца
    var expeditionGrowthPercent: Int? {
        let calendar = Calendar.current
        let now = Date()
        
        guard
            let currentMonthInterval = calendar.dateInterval(of: .month, for: now),
            let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: now),
            let previousMonthInterval = calendar.dateInterval(of: .month, for: previousMonthDate)
        else {
            return nil
        }
        
        let currentCount = spinCombos.filter { currentMonthInterval.contains($0.createdAt) }.count
        let previousCount = spinCombos.filter { previousMonthInterval.contains($0.createdAt) }.count
        
        guard previousCount > 0 else { return nil }
        
        let diff = currentCount - previousCount
        let percent = (Double(diff) / Double(previousCount)) * 100
        return Int(percent.rounded())
    }
    
    /// Последние 6 месяцев
    var tripsByLastSixMonths: [MonthTripStat] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMM"
        
        let now = Date()
        
        let months: [(date: Date, title: String)] = (0..<6).compactMap { offset in
            guard let date = calendar.date(byAdding: .month, value: -(5 - offset), to: now) else {
                return nil
            }
            return (date, formatter.string(from: date).uppercased())
        }
        
        return months.map { month in
            let count = spinCombos.filter {
                calendar.isDate($0.createdAt, equalTo: month.date, toGranularity: .month) &&
                calendar.isDate($0.createdAt, equalTo: month.date, toGranularity: .year)
            }.count
            
            return MonthTripStat(title: month.title, count: count)
        }
    }
    
    var companyShareStats: [CompanyShareStat] {
        let total = max(spinCombos.count, 1)
        
        return companies.map { company in
            let count = spinCombos.filter { $0.company.id == company.id }.count
            let percent = Int((Double(count) / Double(total) * 100).rounded())
            
            return CompanyShareStat(
                id: company.id,
                title: company.title,
                imageName: company.imageName,
                count: count,
                percent: percent
            )
        }
    }
}