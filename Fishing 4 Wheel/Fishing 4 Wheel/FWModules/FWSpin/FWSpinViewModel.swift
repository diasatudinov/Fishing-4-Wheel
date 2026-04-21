//
//  FWSpinViewModel.swift
//  Fishing 4 Wheel
//
//

import Foundation

class FWSpinViewModel: ObservableObject {
    
    let entertaiments: [Entertainment] = [
        .init(id: 1, title: "Guitar", imageName: "entertainment_guitar"),
        .init(id: 2, title: "Podcast", imageName: "entertainment_podcast"),
        .init(id: 3, title: "Silence", imageName: "entertainment_silence"),
        .init(id: 6, title: "Board games", imageName: "entertainment_board"),
        .init(id: 5, title: "Photography", imageName: "entertainment_photography"),
        .init(id: 4, title: "Books", imageName: "entertainment_books")
    ]
    
    let companies: [Company] = [
        .init(id: 1, title: "Friend", imageName: "company_friend"),
        .init(id: 2, title: "Wife", imageName: "company_wife"),
        .init(id: 3, title: "Solitude", imageName: "company_solitude"),
        .init(id: 4, title: "Son", imageName: "company_son"),
        .init(id: 5, title: "Daughter", imageName: "company_daughter"),
        .init(id: 6, title: "Friends", imageName: "company_friends")
    ]
    
    let durations: [Duration] = [
        .init(id: 1, title: "2 hours", imageName: "duration_2hours"),
        .init(id: 2, title: "Until sunset", imageName: "duration_untilSunset"),
        .init(id: 3, title: "All day", imageName: "duration_allDay"),
        .init(id: 4, title: "All night", imageName: "duration_allNight"),
        .init(id: 5, title: "4 hours", imageName: "duration_4hours"),
        .init(id: 6, title: "Until lunch", imageName: "duration_untilLunch")
    ]
    
    let talks: [Talk] = [
        .init(id: 1, title: "Talk only about nature", description: "Discuss the weather, water, and fish", imageName: "talk_1"),
        .init(id: 2, title: "Be silent together", description: "Enjoy the silence alone/in a group", imageName: "talk_2"),
        .init(id: 3, title: "Childhood stories", description: "Remember funny stories", imageName: "talk_3"),
        .init(id: 4, title: "Play city games", description: "Classic word game", imageName: "talk_4"),
        .init(id: 5, title: "Discuss plans", description: "Dream about the future together", imageName: "talk_5"),
        .init(id: 6, title: "Share dreams", description: "Honest conversation", imageName: "talk_6"),
        .init(id: 7, title: "Tell jokes", description: "Lift the mood with humor", imageName: "talk_7"),
        .init(id: 8, title: "Birdwatching", description: "Observe nature together", imageName: "talk_8"),
        .init(id: 9, title: "Teach each other", description: "Sharing experiences (fishing/life)", imageName: "talk_9"),
        .init(id: 10, title: "Reminisce about trips", description: "Nostalgia for past trips", imageName: "talk_10"),
        .init(id: 11, title: "Listen to music together", description: "Shared playlist by the campfire", imageName: "talk_11"),
        .init(id: 12, title: "Complete silence", description: "Listen to the water, the wind, the forest", imageName: "talk_12")
        
    ]
    
    @Published var spinCombos: [SpinCombo] = [] {
        didSet {
            saveSpinCombo()
        }
    }
    
    @Published var talkModels: [TalkModel] = [] {
        didSet {
            saveTalkModel()
        }
    }
    
    private let userDefaultsProjectsKey = "userDefaultsProjectsKey"
    private let userDefaultsSpinCombosKey = "userDefaultsSpinCombosKey"
    
    init() {
        loadTalkModel()
        loadSpinCombo()
    }
    
    func saveTalkModel() {
        if let encodedData = try? JSONEncoder().encode(talkModels) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsProjectsKey)
        }
        
    }
    
    func loadTalkModel() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsProjectsKey),
           let loadedItem = try? JSONDecoder().decode([TalkModel].self, from: savedData) {
            talkModels = loadedItem
        } else {
            print("No saved data found: projects")
        }
    }
    
    func saveSpinCombo() {
        if let encodedData = try? JSONEncoder().encode(spinCombos) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsSpinCombosKey)
        }
        
    }
    
    func loadSpinCombo() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsSpinCombosKey),
           let loadedItem = try? JSONDecoder().decode([SpinCombo].self, from: savedData) {
            spinCombos = loadedItem
        } else {
            print("No saved data found: projects")
        }
    }
    
    func addSpinCombo(spinCombo: SpinCombo) {
        spinCombos.append(spinCombo)
    }
    
    func addTalkModels(talkModel: TalkModel) {
        talkModels.append(talkModel)
    }
}
