//
//  AddContactView.swift
//  DynamoDB SwiftUI Tutorial
//
//  Created by Francesco Dal Savio on 24/10/2020.
//

import Foundation
import SwiftUI


struct AddContactView: View {

    @ObservedObject var contactVM: ContactViewModel
    @Binding var showAddContactView: Bool
    @State var name: String = ""
    @State var secondName: String = ""
    
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Button(action: {
                    self.showAddContactView.toggle()
                })
                {
                Text("Cancel").padding()
                }
                Spacer()
                Text("New contact").padding()
                Spacer()
                
                Button(action: {
                    contactVM.saveContact(name: name, surname: secondName, image: "image")
                    self.showAddContactView.toggle()
                })
                {
                    Text("Add").padding()
                }.disabled(name.isEmpty && secondName.isEmpty)
            }
            
            Form {
                TextField("Name", text: $name)
                TextField("Second Name", text: $secondName)
            }
            
        }.background(Color(.systemGray6))
    }
    

    
}

//struct AddContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddContactView()
//    }
//}
