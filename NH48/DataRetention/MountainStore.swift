import Foundation

class MountainStore: ObservableObject {
    @Published var mountains: [Mountain] = []
    
    init() {
        loadData()
    }

    func updateMountain(_ updated: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == updated.id }) {
            mountains[index] = updated
            saveData()
        }
    }

    func toggleCompletion(for mountain: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == mountain.id }) {
            mountains[index].isCompleted.toggle()
            if mountains[index].isCompleted {
                if mountains[index].completionDate == nil {
                    mountains[index].completionDate = Date()
                }
            } else {
                mountains[index].completionDate = nil
            }
            saveData()
        }
    }

    func setCompletion(_ completed: Bool, for mountain: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == mountain.id }) {
            mountains[index].isCompleted = completed
            mountains[index].completionDate = completed ? (mountains[index].completionDate ?? Date()) : nil
            saveData()
        }
    }

    func delete(_ mountain: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == mountain.id }) {
            mountains.remove(at: index)
            saveData()
        }
    }

    func saveData() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let encoded = try? encoder.encode(mountains) {
            UserDefaults.standard.set(encoded, forKey: "mountains")
        }
    }

    func loadData() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let saved = UserDefaults.standard.data(forKey: "mountains"),
           let decoded = try? decoder.decode([Mountain].self, from: saved) {
            mountains = decoded
        } else {
            mountains = sampleMountains
        }
    }
}
