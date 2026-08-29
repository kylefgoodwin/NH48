//
//  NH48UITests.swift
//
//  Created by Kyle Goodwin on 8/2/25.
//

import XCTest

final class NH48UITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        // Pass a launch argument to potentially let the app know it's running tests
        app.launchArguments = ["--uitesting"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testAppLaunchesWithHeaderAndList() {
        // Verify the custom header title "NH48" is visible
        let headerTitle = app.staticTexts["NH48"].firstMatch
        XCTAssertTrue(headerTitle.exists, "The main title 'NH48' should be visible on the home screen.")
        
        // Verify that the Settings gear button exists
        let settingsButton = app.buttons["Settings"].firstMatch
        XCTAssertTrue(settingsButton.exists, "The Settings button should be visible in the header.")
    }

    @MainActor
    func testAddNewMountainFlow() throws {
        let addMountainButton = app.buttons["Add Mountain"].firstMatch
        XCTAssertTrue(addMountainButton.exists, "The Add Mountain (+) button should be visible in the header.")
        addMountainButton.tap()

        // Verify the Add Mountain Sheet has appeared
        let sheetTitle = app.staticTexts["Add a Mountain"].firstMatch
        XCTAssertTrue(sheetTitle.waitForExistence(timeout: 2), "The Add Mountain sheet did not appear.")

        // Query fields
        let nameField = app.textFields["Name"].firstMatch
        let locationField = app.textFields["Location (e.g. Range)"].firstMatch
        let elevationField = app.textFields["Elevation (ft)"].firstMatch
        
        XCTAssertTrue(nameField.exists)
        XCTAssertTrue(locationField.exists)
        XCTAssertTrue(elevationField.exists)

        // Type in mock data (Using unique test names to prevent database matches conflicts)
        nameField.tap()
        nameField.typeText("Mount UniqueTestHike")

        locationField.tap()
        locationField.typeText("Waterville Valley")

        elevationField.tap()
        elevationField.typeText("4003")

        // Tap Save
        let saveButton = app.buttons["Save"].firstMatch
        XCTAssertTrue(saveButton.isEnabled, "Save button should be enabled when all text fields are filled.")
        saveButton.tap()

        // Verify sheet dismisses and the new mountain card is listed on the home screen
        let newlyAddedMountainCardText = app.staticTexts["Mount UniqueTestHike"].firstMatch
        XCTAssertTrue(newlyAddedMountainCardText.waitForExistence(timeout: 2), "The newly created mountain should appear on the main list.")
    }

    @MainActor
    func testNavigateToDetailViewAndToggleSegments() throws {
        let searchBar = app.textFields["Search 4,000-footers..."].firstMatch
        XCTAssertTrue(searchBar.exists)
        
        // Search to isolate our unique test item
        searchBar.tap()
        searchBar.typeText("UniqueTestHike")
        
        let card = app.staticTexts["Mount UniqueTestHike"].firstMatch
        if card.waitForExistence(timeout: 2) {
            // Tap the card to open detail view
            card.tap()
            
            // Verify that we successfully navigated and the modern typography header is present
            let detailTitle = app.staticTexts["Mount UniqueTestHike"].firstMatch
            XCTAssertTrue(detailTitle.exists, "The detail screen should show the mountain name as a large title.")
            
            // Verify the segment picker controls (Info vs Tracker) are interactable
            let infoSegment = app.buttons["Info"].firstMatch
            let trackerSegment = app.buttons["Tracker"].firstMatch
            
            XCTAssertTrue(infoSegment.exists)
            XCTAssertTrue(trackerSegment.exists)
            
            // Tap Tracker Segment and make sure personal notes or photos grid is present
            trackerSegment.tap()
            
            let personalNotesLabel = app.staticTexts["Personal Notes"].firstMatch
            XCTAssertTrue(personalNotesLabel.waitForExistence(timeout: 1), "The Tracker section should render when selected.")
            
            // Tap Save to return home safely
            let detailSaveButton = app.buttons["Save"].firstMatch
            XCTAssertTrue(detailSaveButton.exists)
            detailSaveButton.tap()
            
            // We should be back on the home screen
            XCTAssertTrue(app.staticTexts["NH48"].firstMatch.waitForExistence(timeout: 2), "Tapping 'Save' should navigate back to the home screen.")
        }
    }

    @MainActor
    func testToggleMountainCompletionOnHomeCard() {
        let searchBar = app.textFields["Search 4,000-footers..."].firstMatch
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("UniqueTestHike")
        
        let card = app.staticTexts["Mount UniqueTestHike"].firstMatch
        XCTAssertTrue(card.waitForExistence(timeout: 2))
        
        // Target the completion toggle button specifically using .firstMatch to prevent multiple-match crashes
        let toggleButton = app.buttons["CompletionToggle"].firstMatch
        XCTAssertTrue(toggleButton.exists, "The completion toggle button should be accessible.")
        
        // Tap the button to toggle completed state
        toggleButton.tap()
    }

    @MainActor
    func testAddAndRemoveTagInDetailView() {
        let searchBar = app.textFields["Search 4,000-footers..."].firstMatch
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("UniqueTestHike")
        
        let card = app.staticTexts["Mount UniqueTestHike"].firstMatch
        if card.waitForExistence(timeout: 2) {
            card.tap()
            
            // Go to Tracker tab
            let trackerSegment = app.buttons["Tracker"].firstMatch
            XCTAssertTrue(trackerSegment.exists)
            trackerSegment.tap()
            
            // Locate the Tags input using our precise accessibility identifier
            let tagInputField = app.textFields["TagInput-Tags"].firstMatch
            XCTAssertTrue(tagInputField.exists, "The Tag input field should exist on the tracker screen.")
            tagInputField.tap()
            tagInputField.typeText("Solo Hike")
            
            // Press the '+' button using the new identifier
            let addTagButton = app.buttons["AddTagButton-Tags"].firstMatch
            XCTAssertTrue(addTagButton.exists)
            addTagButton.tap()
            
            // Verify tag is added
            let newlyAddedTag = app.staticTexts["Solo Hike"].firstMatch
            XCTAssertTrue(newlyAddedTag.waitForExistence(timeout: 2), "The new tag chip should be visible.")
            
            // Delete the tag by tapping the 'xmark' button using the identifier
            let deleteTagButton = app.images["DeleteTag-Solo Hike"].firstMatch
            XCTAssertTrue(deleteTagButton.exists)
            deleteTagButton.tap()
            
            // Verify tag is removed from layout
            XCTAssertFalse(newlyAddedTag.exists, "The tag should be successfully removed after tapping delete.")
            
            // Save & exit
            app.buttons["Save"].firstMatch.tap()
        }
    }

    @MainActor
    func testMountainContextMenuActions() {
        let searchBar = app.textFields["Search 4,000-footers..."].firstMatch
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("UniqueTestHike")
        
        let card = app.staticTexts["Mount UniqueTestHike"].firstMatch
        if card.waitForExistence(timeout: 2) {
            // Press and hold to invoke the context menu
            card.press(forDuration: 1.5)
            
            // Verify context menu actions are present
            let markCompletedTodayOption = app.buttons["Mark Completed Today"].firstMatch
            let deleteOption = app.buttons["Delete"].firstMatch
            
            XCTAssertTrue(markCompletedTodayOption.exists)
            XCTAssertTrue(deleteOption.exists)
            
            // Tap outside or dismiss
            markCompletedTodayOption.tap()
        }
    }
}
