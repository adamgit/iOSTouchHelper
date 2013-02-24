#import <UIKit/UIKit.h>

/**
 "fingers help overlay for iOS"
 
 This is MANY TIMES BETTER a user-interface than the ones you see in most apps. Non-intrusive, explicit, and visual.
 
 Make life easy for your users!
 
 ***** NB: the supplied images look TERRIBLE! Use your iPhone camera to take photos of your own fingers ****
 
 For updates, c.f. original source: https://github.com/adamgit/iOSTouchHelper
 
 License: 
 
 --------
 Usage notes:
 
 1. The class is designed to be added to ANY VIEW CONTROLLER AND AUTOMATICALLY ANIMATE ITSELF
 2. It EXPECTS YOU TO PROVIDE PHOTOS / IMAGES TO DISPLAY (by default: "1-finger.png" and "2-fingers.png")
 3. You should add it to your view inside the viewController's "viewDidAppear" method. e.g.:
 
 -(void)viewDidAppear:(BOOL)animated
 {
     VFingersHelp* helpView = [[[VFingersHelp alloc] init] autorelease];
     /** This will position the helpview in bottom-left corner. Bottom left/right corners are where users prefer to "touch" (c.f. Disney's style guide for toddlers).
     While they're watching the help, we don't want them touching, so we deliberately place in bottom corner.
     (feel free to move to top corner if you prefer).
     NB: it's easy to take a photo of your fingers and display at bottom of screen...
     * / // to build, delete the space between the asterisk and the slash
     helpView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
     helpView.center = CGPointMake( 0 + helpView.bounds.size.width/2.0, 2.0 + self.view.bounds.size.height - helpView.bounds.size.height + helpView.bounds.size.height/2.0);
     [self.view addSubview:helpView];
 }
 
 --------
 Implementation notes:
 
 1. Naming: it's called "VFingersHelp" because:
     - "V": Xcode is 15 years out of date, and doesn't auto-complete based on AST/type. Unlike Microsoft Visual Studio, IntelliJ, Eclipse, etc, to make autocomplete work you have to prefix each class with its type.
     - "Fingers": the best way to use this is with a photo of your own fingers, positioned in bottom left of screen
     - "Help": the point is to TELL THE USER what to do / expect.
 
 2. Blocks + Animation = Teh Awesum.
 
 3. The view animates itself, completely. And then removes itself when done (causing it to be automatically destroyed)
 */
@interface VFingersHelp : UIView

@end
