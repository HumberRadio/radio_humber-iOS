//
//  AnimEvents.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/2/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//


import Foundation

struct AnimEvent {
    static let menuToggle = NSNotification.Name(rawValue: "menu_toggle")
    static let menuStateChange = NSNotification.Name(rawValue: "menu_state_change")
    static let menuHide = NSNotification.Name(rawValue: "menu_hide")
    static let menuShow = NSNotification.Name(rawValue: "menu_show")
    static let conversationScroll = NSNotification.Name(rawValue: "conversation_scroll")
    static let addMessage = NSNotification.Name(rawValue: "add_message")
    static let updateConversationTable = NSNotification.Name(rawValue: "update_conversation_table")
    static let navigateToConversation = NSNotification.Name(rawValue: "navigate_to_conversation")
    static let navigateToProfile = NSNotification.Name(rawValue: "navigate_to_profile")
    static let navigateToMessages = NSNotification.Name(rawValue: "navigate_to_messages")
}

