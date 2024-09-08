//
//  StoreManager.swift
//  ElevenTen
//
//  Created by César Venzor on 02/09/24.
//

import StoreKit

typealias Transaction = StoreKit.Transaction

@MainActor final class Store: ObservableObject {
    @Published private(set) var subscriptions: [Product] = []
    @Published private(set) var activeTransactions: Set<Transaction> = []
    
    private var updates: Task<Void, Never>?
    
    init() {
        updates = Task {
            for await update in Transaction.updates {
                if let transaction = try? update.payloadValue {
                    await fetchActiveTransactions()
                    await transaction.finish()
                }
            }
        }
    }
    
    deinit {
        updates?.cancel()
    }
    
    func fetchSubscriptions() async {
        do {
            subscriptions = try await Product.products(for: ["subscription.basic", "subscription.premium"])
        } catch {
            subscriptions = []
        }
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verificationResult):
            if let transaction = try? verificationResult.payloadValue {
                activeTransactions.insert(transaction)
                await transaction.finish()
            }
            
        case .userCancelled:
            break
            
        case .pending:
            break
            
        @unknown default:
            break
        }
    }
    
    func fetchActiveTransactions() async {
        var activeTransactions: Set<Transaction> = []
        
        for await entitlement in Transaction.currentEntitlements {
            if let transaction = try? entitlement.payloadValue {
                activeTransactions.insert(transaction)
            }
        }
        
        self.activeTransactions = activeTransactions
    }
    
    func hasActiveSubscription() -> Bool {
        let currentDate = Date()
        
        for transaction in activeTransactions {
            if let expirationDate = transaction.expirationDate {
                if expirationDate > currentDate {
                    return true
                }
            }
        }
        
        return false
    }
}
