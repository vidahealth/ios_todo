# ios_todo
This is an example TODO app showcasing Vida's shared mobile architecture that heavily utilizes the RX framework.

Things to implement:
 * Using a global router to launch view controllers
 * An rxFriendly networking layer
 * Strategies for mapping rx network streams into the view model
 * Componentizing the view using dumb views and view data
 * The interactive element so changes in UI update view model
 * UI Test suite

Things to think about:
 * What goes in VidaFoundation and VidaUIKit
 	** do we turn these into frameworks?
 * How do we write our tests
 * Do we want to use rxCocoa?
 * How do we want to abstract our endpoints?

testing