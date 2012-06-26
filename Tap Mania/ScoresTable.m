//
//  ScoresTable.m
//  Tap Mania
//
//  Created by Aurelien Cobb on 20/06/2012.
//  Copyright 2012 Westminster University. All rights reserved.
//

#import "ScoresTable.h"
#import "CCTransition.h"

@interface ScoresTable()

@property (retain, nonatomic) CCMenuItemSprite * homeButton;

@end

@implementation ScoresTable

@synthesize appDelegate = _appDelegate;
@synthesize scoresView = _scoresView;
@synthesize homeButton = _homeButton;

#pragma mark - Init

- (id) init
{
    if (self = [super init])
    {
        _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        CCLabelTTF* label  = [CCLabelTTF labelWithString:@"Global high scores" fontName:@"Marker Felt" fontSize:64];
		CGSize size		= [[CCDirector sharedDirector] winSize];
		label.position  = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
        
		CCSprite* highScoreBackground = [CCSprite spriteWithFile:@"HighScoreBG.png"];
		highScoreBackground.position = CGPointMake(size.width/2, size.height/2);
		[self addChild:highScoreBackground z:0];
        
		_scoresView					= [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
		self.scoresView.opaque		= YES;
		UITableView* scoresTable	= [[UITableView alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 280.0f)];
		scoresTable.dataSource		= self;
		scoresTable.delegate		= self;
		scoresTable.opaque			= YES;
		[self.scoresView addSubview:scoresTable];
        
		CCSprite* spriteHomeNormal   = [CCSprite spriteWithFile:@"logbuttonUP.png"];
		CCSprite* spriteHomeSelected = [CCSprite spriteWithFile:@"logbuttonDOWN.png"];
		spriteHomeNormal.color		 = ccGREEN;
		spriteHomeSelected.color	 = ccRED;
		_homeButton					 = [CCMenuItemSprite itemFromNormalSprite:spriteHomeNormal
                                                  selectedSprite:spriteHomeSelected
                                                          target:self
                                                        selector:@selector(menuItemTouchedHome:)];
        
		CCMenu* menu = [CCMenu menuWithItems:self.homeButton, nil];
		menu.position = CGPointMake(size.width / 2, 75);
		[self addChild:menu];
		[menu alignItemsVerticallyWithPadding:40];

    }
    
    
    return self;
}

-(void) onEnterTransitionDidFinish
{
	[[[CCDirector sharedDirector] openGLView] addSubview:self.scoresView];
	[super onEnterTransitionDidFinish];
}

-(void)menuItemTouchedHome:(id)sender
{
	self.scoresView.hidden = TRUE;
//	CCSplitColsTransition* transition = [CCSplitColsTransition transitionWithDuration:3 scene:[GameAdScene scene]];
//	[[CCDirector sharedDirector] replaceScene:transition];
}

#pragma mark - TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.appDelegate highScores] count];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return 0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//	static NSString	*MyIdentifier =	@"MyIdentifier";
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//    
//	if(cell == nil)
//		cell = [self getCellContentView:MyIdentifier];
//    
//	UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
//	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
//	UILabel *lblTemp3 = (UILabel *)[cell viewWithTag:3];
//    
//	NSDictionary* rowData		= [[appDelegate highScores] objectAtIndex:indexPath.row];
//    
//	lblTemp1.text = [rowData objectForKey:@"rank"];
//	lblTemp2.text = [rowData objectForKey:@"nickname"];
//	lblTemp3.text = [rowData objectForKey:@"score"];
//    
//    return cell;
    return nil;
}




@end
