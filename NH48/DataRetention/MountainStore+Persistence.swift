import Foundation

extension MountainStore {
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
