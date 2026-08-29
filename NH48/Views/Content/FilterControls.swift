import SwiftUI

struct FilterControls: View {
    @Binding var selectedFilter: MountainFilter
    @Binding var selectedRange: String?
    @Binding var sortOption: SortOption
    let label: (MountainFilter) -> String
    let uniqueRanges: [String]
    
    var body: some View {
        VStack(spacing: 8) {
            Picker("Filter", selection: $selectedFilter) {
                ForEach(MountainFilter.allCases) { filter in
                    Text(label(filter))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .tag(filter)
                }
            }
            .pickerStyle(.segmented)
            
            if selectedFilter == .range {
                Menu {
                    Button("All Ranges") { selectedRange = nil }
                    ForEach(uniqueRanges, id: \.self) { range in
                        Button(range) { selectedRange = range }
                    }
                } label: {
                    HStack {
                        Image(systemName: "map")
                        Text(selectedRange ?? "Select Range")
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .minimumScaleFactor(0.8)
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background(.thinMaterial)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
                    )
                }
                .accessibilityLabel("Choose mountain range")
            }
            
            Picker("Sort", selection: $sortOption) {
                Text("Elev ↓").tag(SortOption.elevationDescending)
                Text("Elev ↑").tag(SortOption.elevationAscending)
                Text("Name").tag(SortOption.name)
            }
            .pickerStyle(.segmented)
        }
        .padding(.horizontal)
    }
}
