import SwiftUI

// Helper to convert optional bindings to non-optional with a default value
extension Binding {
    /// Case 1: Binding to an optional value (Binding<Value?>)
    init(unwrapping source: Binding<Value?>, default defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in
                source.wrappedValue = newValue
            }
        )
    }

    /// Case 2: Optional Binding to a non-optional value (Binding<Value>?)
    init(unwrapping source: Binding<Value>?, default defaultValue: Value) {
        self.init(
            get: { source?.wrappedValue ?? defaultValue },
            set: { newValue in
                source?.wrappedValue = newValue
            }
        )
    }

    /// Case 3: Non-optional Binding provided; ignore default and forward through
    init(unwrapping source: Binding<Value>, default defaultValue: Value) {
        self = source
    }
}
