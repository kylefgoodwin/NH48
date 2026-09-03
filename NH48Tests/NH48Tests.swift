import Testing
import Foundation

@Suite("Mountain Store Tests")
struct NH48Tests {

    @Test("Verifies that mountain completion toggling works correctly and updates completion dates")
    func testMountainCompletionToggle() async throws {
        let store = MountainStore()
        
        // Use a test mountain
        let mountain = Mountain(
            name: "Test Dome",
            elevation: 4000,
            location: "Test Range",
            isCompleted: false
        )
        
        store.mountains = [mountain]
        
        // Toggle completion On
        store.toggleCompletion(for: mountain)
        let completedMountain = try #require(store.mountains.first)
        #expect(completedMountain.isCompleted)
        #expect(completedMountain.completionDate != nil)
        
        // Toggle completion Off
        store.toggleCompletion(for: completedMountain)
        let uncompletedMountain = try #require(store.mountains.first)
        #expect(!uncompletedMountain.isCompleted)
        #expect(uncompletedMountain.completionDate == nil)
    }
}
