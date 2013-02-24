#import "VFingersHelp.h"

@interface VFingersHelp()
@property(nonatomic,retain) UIImageView* fingersView;
@property(nonatomic,retain) UILabel* textLabel;
@end

@implementation VFingersHelp

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
		[self initWorkaroundBecauseApplesInterfaceBuilderBrokeDesignatedInitializers];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWorkaroundBecauseApplesInterfaceBuilderBrokeDesignatedInitializers];
    }
    return self;
}

/**
 This is the init method, but Interface Builder breaks the ObjectiveC spec, so we have to do a workaround.
 
 NB: I believe this is fixed with iOS 6, but I still make apps for iOS 3+, so ...
 */
-(void)initWorkaroundBecauseApplesInterfaceBuilderBrokeDesignatedInitializers
{
	NSAssert([UIImage imageNamed:@"2-fingers.png"] != nil, @"You MUST provide your own images for this to work!");
	
	self.fingersView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2-fingers.png"]];
	[self addSubview:self.fingersView];
	
	self.textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0,0, self.fingersView.bounds.size.width, 50 )] autorelease];
	self.textLabel.text = @"Pan using two fingers";
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	self.textLabel.textColor = [UIColor colorWithRed:0 green:0.2 blue:0 alpha:1];
	self.textLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
	[self addSubview:self.textLabel];
	
	
	/** resize self because Apple's code can't be trusted to do it correctly */
	if( CGSizeEqualToSize( self.bounds.size, CGSizeZero) )
		self.bounds = CGRectMake( 0, 0,
								 self.fingersView.bounds.size.width,
								 self.fingersView.bounds.size.height + self.textLabel.bounds.size.height );
	
	/** re-position subview that Apple's code fails to position correctly */
	self.fingersView.center = CGPointMake( self.fingersView.bounds.size.width/2.0, self.textLabel.bounds.size.height + self.fingersView.bounds.size.height/2.0); // Because Apple engineers are stupid and their default code doesn't work
	self.fingersView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
	
	
	//DEBUG: self.backgroundColor = [UIColor redColor];
}

/**
 BEFORE we appear ... make ourselves invisible (so we can "fade in")
 */
-(void)willMoveToSuperview:(UIView *)newSuperview
{
	if( newSuperview != nil ) // appearing
	{
		self.alpha = 0.0;
	}
}

/**
 Blocks (which were called "lambdas" and were around for 20+ years before ObjectiveC) make animation code beautiful.
 
 Shame on Apple for being slow to add blocks to ObjectiveC
 But ... praise Apple for adding them to Animations
 
 They were late to the party, but OMGWTF they did a good job with their animations + blocks API. Just watch me do this (and the code is readable!)...
 */
-(void)didMoveToSuperview
{
	if( self.superview != nil ) // appearing
	{
		[UIView animateWithDuration:1.7 // fade in first image
		animations:^
		{
			 self.alpha = 1.0;
		}
		completion:^(BOOL finished)
		{
			[UIView animateWithDuration:1.2 delay:2.0 options:0  // fade OUT first image
			animations:^
 			{
				  self.alpha = 0.0;
			}
			completion:^(BOOL finished) // switch images and text
			{
				self.fingersView.image = [UIImage imageNamed:@"1-finger.png"];
				self.textLabel.text = @"Use one finger to select";
				  
				[UIView animateWithDuration:1.0 // fade in SECOND image
				animations:^
				{
					self.alpha = 1.0;
				}
				completion:^(BOOL finished)
				{
					[UIView animateWithDuration:1.0 delay:2.0 options:0 // fade OUT second image
									 animations:^
					 {
						 self.alpha = 0.0;
					 }
									 completion:^(BOOL finished)
					 {
						 [self removeFromSuperview];
					 }
					 ];
				}
				];
			}
			];
		 }
		 ];
	}
	
	/** if you are not impressed by what just happened - and the clarity of the code required - you haven't been programming long enough */
}
@end
