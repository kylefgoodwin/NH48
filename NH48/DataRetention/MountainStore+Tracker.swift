import Foundation

extension MountainStore {
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
}
