import Foundation

extension MountainStore {
    func trackHike(_ mountain: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == mountain.id }) {
            mountains[index] = mountain
            saveData()
        }
    }
}
