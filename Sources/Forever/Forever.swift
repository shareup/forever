import Combine

extension Subscribers {
    final public class Forever<Upstream: Publisher>: Subscriber, Cancellable, CustomStringConvertible {
        public typealias Input = Upstream.Output
        public typealias Failure = Upstream.Failure
        
        private var subscription: Subscription? = nil
        private let receiveCompletion: (Subscribers.Completion<Failure>) -> Void
        private let receiveValue: (Input) -> Void
        
        public var hasSubscription: Bool { subscription != nil }
        public var description: String {
            "Subscribers.Forever(\(combineIdentifier), \(hasSubscription ? "has subscription" : "not yet subscribed"))"
        }
        
        public init(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
                    receiveValue: @escaping (Input) -> Void) {
            self.receiveCompletion = receiveCompletion
            self.receiveValue = receiveValue
        }
        
        public func receive(_ input: Input) -> Subscribers.Demand {
            receiveValue(input)
            return .unlimited
        }
        
        public func receive(completion: Subscribers.Completion<Upstream.Failure>) {
            receiveCompletion(completion)
        }
        
        public func receive(subscription: Subscription) {
            guard self.subscription == nil else { return subscription.cancel() }
            
            self.subscription = subscription
            subscription.request(.unlimited)
        }
        
        public func cancel() {
            subscription?.cancel()
            self.subscription = nil
        }
    }
}

extension Publisher {
    public func forever(receiveValue: @escaping (Output) -> Void) -> Subscribers.Forever<Self> {
        let subscriber = Subscribers.Forever<Self>(receiveCompletion: { _ in }, receiveValue: receiveValue)
        self.subscribe(subscriber)
        return subscriber
    }
    
    public func forever(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void, receiveValue: @escaping (Output) -> Void) -> Subscribers.Forever<Self> {
        let subscriber = Subscribers.Forever<Self>(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
        self.subscribe(subscriber)
        return subscriber
    }
}
