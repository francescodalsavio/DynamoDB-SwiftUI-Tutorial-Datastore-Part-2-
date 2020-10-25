//
//  ContactViewModel.swift
//  DynamoDB SwiftUI Tutorial
//
//  Created by Francesco Dal Savio on 24/10/2020.
//

import Foundation
import SwiftUI
import Amplify
import Combine

class ContactViewModel: NSObject, ObservableObject {
    
    @Published var contacts: [Contact] = []
    //        = [
    //        .init(name: "Elon", surname: "Musk", image: "elon_musk"),
    //        .init(name: "Mark", surname: "Zuckeberg", image: "elon_musk"),
    //        .init(name: "Tim", surname: "Cook", image: "elon_musk"),
    //    ]
    
    @Published var observationToken: AnyCancellable?
    
    
    override init() {
        super.init()
        self.getContacts()
        self.observeContacts()
    }
    
    
    func getContacts() {
        Amplify.DataStore.query(Contact.self) { result in
            switch result {
            case .success(let contacts):
                print(contacts)
                DispatchQueue.main.async {
                    self.contacts = contacts
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func observeContacts() {
        observationToken = Amplify.DataStore.publisher(for: Contact.self).sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            },
            receiveValue: { changes in
                
                switch changes.mutationType {
                case "create":
                        self.getContacts()
                case "delete":
                    self.getContacts()
                default:
                    break
                }
                
            }
        )
    }
    
    func deleteContact(at indexSet: IndexSet) {
        print("Deleted item at \(indexSet)")
        
        DispatchQueue.main.async {
            var updatedContacts = self.contacts
            updatedContacts.remove(atOffsets: indexSet)
            
            guard let contact = Set(updatedContacts).symmetricDifference(self.contacts).first else { return }
            
            Amplify.DataStore.delete(contact) { result in
                switch result {
                case .success:
                    print("Deleted contact")
                    
                case .failure(let error):
                    print("Could not delete contact - \(error)")
                }
            }
        }
    }
    
    
    func saveContact(name: String, surname: String, image: String) {
        let contact = Contact(name: name, surname: surname, image: image)
        
        Amplify.DataStore.save(contact) { result in
            switch result {
            case .success:
                print("saved contact")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
