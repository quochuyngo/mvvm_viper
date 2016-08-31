//
//  ContactsViewModel.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

protocol ContactsViewModelProtocol: class {
    func didInsertContact(at index: Int)
}

class ContactsViewModel {

    weak var contactsViewModelProtocol: ContactsViewModelProtocol?
    private var contacts: [Contact] = []
    private var dataManager = ContactListLocalDataManager()

    func retrieveContacts(response: () -> Void) {
        do {
            contacts = try dataManager.retrieveContactList()
        } catch {}
        response()
    }

    var contactsCount: Int {
        return contacts.count
    }

    func contactFullName(at index: Int) -> String {
        let contact = contacts[index]
        return contact.fullName
    }
}

extension ContactsViewModel: AddContactViewModelDelegate {
    func didAddContact(contact: Contact) {
        let insertionIndex = contacts.insertionIndex(of: contact) { $0 < $1 }
        contacts.insert(contact, atIndex: insertionIndex)
        contactsViewModelProtocol?.didInsertContact(at: insertionIndex)
    }
}
