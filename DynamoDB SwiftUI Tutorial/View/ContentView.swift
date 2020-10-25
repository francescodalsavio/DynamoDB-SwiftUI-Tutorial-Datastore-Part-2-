//
//  ContentView.swift
//  DynamoDB SwiftUI Tutorial
//
//  Created by Francesco Dal Savio on 24/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contactVM = ContactViewModel()
    @State var showAddContactView = false

    var body: some View {
        
        NavigationView {
            ZStack {
                List {
                    ForEach(contactVM.contacts) { contact in
                        Text(contact.name!)
                    }
                    .onDelete(perform: contactVM.deleteContact(at:))
                }
            } 
            .navigationTitle("Contacts")
            .sheet(isPresented: $showAddContactView) {
                AddContactView(contactVM: self.contactVM, showAddContactView: $showAddContactView)
            }
            .navigationBarItems(trailing:
                Button("Add") {
                    print(contactVM.contacts)
                    self.showAddContactView.toggle()
                    print("Add tapped!")
                }
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
