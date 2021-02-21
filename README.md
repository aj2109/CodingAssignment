Good morning/Afternoon! 


In this project I have split the files into Helpers, Comments and Photos.  Helpers contains all of the business logic, be it in the form of extensions, protocols or structs.  Comments contains all the files that deals with the ViewController which loads when a photo is clicked.  Photos the initial View Controller / app startup.


Notes:

- I had a lot of issues with the project compiling when I first opened it (it crashed my Xcode repeatedly) - I seem to have fixed this, but please make sure you are testing this with Xcode 12+ so you are on the same IDE as me, as it seems on/off on 11.X. 

- There are comments in the project where it was beneficial to add them

- There are some unit tests (I made these in Swift as I have not done these in Objective C before, but was unsure if I could delete the Objective C file or not, so that is why that is still there).


What I would improve:

- The nav bar generally.  I stuck to the request to add a logo into the nav bar itself, but I really struggled to do this with the iOS Nav Bar.  Traditionally I would just use a UIView, and this project has made evident that there is some homework I need to do on this.  The best I could get with the iOS Nav Bar was a very small image, the height of the nav bar really did not want to budge!

-  Using generics for AlertShowing.  This is a protocol that seems like a perfect place to use generics, however there seems to be some kind of incompatibility between generics and using the generic’s allCases.  So I left a commented out generics version of the function there, and used my more niche use case version instead.

- I overlooked the fact that this was to go through Github otherwise I would have done my commits on there, rather than just one big commit for all my work.



Thanks for your time looking through my coding assignment.


Adam
