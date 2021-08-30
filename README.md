# Engineering Vazhikaatti

A small app to priortize Engineering colleges in TNEA  2021 based on your cutoff and community against last three years data across TNEA affiliated engineering colleges.

And our Dev stuff

A Flutter project attempted to develop based on clean architecture concepts.
I have developed a small app named Engineering Vazhikaatti to priortize Engineering colleges in TNEA 2021\. It was based on the cutoff and community against last three years data across TNEA affiliated engineering colleges.

Its small thing ,I did it to start exploring clean architecture concepts with dart & flutter.

### Why Clean Architecture

Working on Software projects is of two types

- Temple

- Bazaar

The Temple type takes long time to complete,. Once done, rarely get new features to develop. There might be small adjustments here and there , But will never be a 5 point story.

The Bazaar type takes short time to build the initial concept. Once done, we keep on getting new features. The features get developed with promised delivery date for a certain time. As the time process we could see our estimation capability starts dropping.

It would be because of code getting rigid and unsure about what does what? .

This is the case with both frontend or backend.

If its a backend, the logic might be buried in service classes based on db table or an external service response. ( Thinking of Spring boot , Play framework Actors)

If its frontend the logic might be buried on UI Screens ,or View Models ( Android Dev), Components or Services (Angular), Stores.

I personally feel clean architecture helps to address these kind of issues in long run . It does have an initial learning curve , But once its done , it was well suited for all these Bazar kidn of projects.

As every new requirement will be drafted as an independent usecase , They might not tightly coupled with any screen or a db table

For more details about Clean Architecture refer this [Clean Architecture By Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

I tried to adapt that for my flutter app and architecture ends up something like this.

![Clean Architecture adapted for this project](https://github.com/muthuishere/engineeringvazhikaatti/blob/main/docs/images/ca.png?raw=true)

The inner most layer is Entity, where all the domain classes resides along with domain rules (methods).

The next layer is usecases, where every requirement will be converted to a new file(Think of usecase diagram). 

The Usecases will connect with entity layer to work on business specific rules. Additional operations like connecting to external services or any IO operations will be taken care by interfaces.

In Dart dummy or abstract classes represent interface.

The next level contains stores(Data Stores), Api Entry points, which connect with usecases to deal any presentation related functionalities. If it requires any other additional functionality it will again use interfaces.

The next level contains our flutter widgets, which connect with Api Entry points , Data Stores to deal any ui related functionalities.

Those interfaces will be injected at runtime through dependency injection. In this project i have used injector framework.

For any issues , you have to change the existing code , But for new features you can create new usecase class and keep on scaling up functionalities

Yes there might be some changes in widget layer. But the aspect of all business functionalities stays within usecase. This paves the way for scaling up any bazaar model software.

Feel Free to reference this project or do let me know , what works well or what not..

Also Links

- [Download Android app](https://play.google.com/store/apps/details?id=edu.tools.engineeringvazhikaatti)

- [Web version ](https://muthuishere.github.io/engineeringvazhikaatti/)

- [App Explanation Video ](https://youtu.be/KfZsTBuMJnY)

