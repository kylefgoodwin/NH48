import Foundation

extension MountainStore {
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "mountains") {
            do {
                mountains = try JSONDecoder().decode([Mountain].self, from: data)
            } catch {
                print("Failed to load mountains: \(error)")
                mountains = MountainData.mountains
            }
        } else {
            mountains = MountainData.mountains
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(mountains)
            UserDefaults.standard.set(data, forKey: "mountains")
        } catch {
            print("Failed to save mountains: \(error)")
        }
    }
}
