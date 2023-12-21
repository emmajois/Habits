//
//  MultiSelector.swift
//  Habits
//
//  Created by Emma Swalberg on 12/21/23.
//

import Foundation

///This code came from here:  https://www.fline.dev/multi-selector-in-swiftui/

import SwiftUI

struct MultiSelector<LabelView: View, Selectable: Identifiable & Hashable>: View {
    let label: LabelView
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    
    var selected: Binding<Set<Selectable>>
    
    private var formattedSelectedListString: String {
        ListFormatter.localizedString(byJoining: selected.wrappedValue.map { optionToString($0)})
    }
    
    var body: some View {
        NavigationLink(destination: multiSelectionView()) {
            HStack {
                label
                Spacer()
                Text(formattedSelectedListString)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private func multiSelectionView() -> some View {
        MultiSelectionView(
            options: options,
            optionToString: optionToString,
            selected: selected)
    }
}

//preview
struct MultiSelector_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }
    
    @State
    static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })
    
    static var previews: some View {
        NavigationView {
            Form {
                MultiSelector<Text, IdentifiableString>(
                    label: Text("Multiselect"),
                    options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                    optionToString: { $0.string },
                    selected: $selected
                )
            }.navigationTitle("Title")
        }
    }
}
