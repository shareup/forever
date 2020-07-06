# Forever

⚠️⚠️⚠️ **ARCHIVED** ⚠️⚠️⚠️

This repository was originally intended to fill what we thought was a hole in Apple's Combine framework. Because of a misunderstanding about how to use Combine's [`Subscribers.Demand`](https://developer.apple.com/documentation/combine/subscribers/demand) concept, we thought Combine was missing a `Subscriber` who always demanded an unlimited number of values from its `Publisher`. In fact, [`Subscribers.Sink`](https://developer.apple.com/documentation/combine/subscribers/sink) fulfills that exact purpose. We were confused because `Sink.receive(_ value: Input) -> Subscribers.Demand` returns `.unlimited` the first time its called, but `.none` every time thereafter. We took this to mean `Sink` wanted all of the `Publisher`'s available values immediately, but none after the first delivery. Instead, according to the documentation, `Subscribers.Demand` is additive, and adding any amount to or subtracting any amount from `.unlimited` demand results in `.unlimited` demand.

> When subtracting any value (including unlimited) from unlimited, the result is still unlimited. Subtracting unlimited from any value (except unlimited) results in .max(0).
> 
> A negative demand is possible, but be aware that it is not usable when requesting values in a subscription.
>
> [Combine documentation](https://developer.apple.com/documentation/combine/subscribers/demand/3213672)

You can read more about this topic in [this Apple Developer Forum post](https://developer.apple.com/forums/thread/650566).
