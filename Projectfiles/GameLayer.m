// GameLayer.m
//
// Created by Carlo Carraro on 03/02/13.
//
// Copyright (c) 2013 Carlo Carraro
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GameLayer.h"
#import "MenuLayer.h"
#import "EndLevelLayer.h"
#import "SimpleAudioEngine.h"
#import "RouteParser.h"
#import "Route.h"
#import "Difficulty.h"
#import "Position.h"

#define BG_TAG 1
#define BG2_TAG 2
#define CORNICE_TAG 3
#define BGH_TAG 4
#define PLAYERP_TAG 5
#define ENEMYP_TAG 6
#define END_TAG 7


#define B_TAG 10
#define D_TAG 11
#define P_TAG 12
#define Q_TAG 13

#define FISH_TAG 20
#define ENEMYG_TAG 21
#define CUER1_TAG 22
#define CUER2_TAG 23
#define CUER3_TAG 24

#define COMICS_TAG 200

#define COMICSGROUP_TAG 300

#define PLAY_TAG 30

#define COMICS_PATH @"letterLowercase/comics/"

@interface GameLayer (PrivateMethods)
@end

@implementation GameLayer

//@synthesize helloWorldString, helloWorldFontName;
//@synthesize helloWorldFontSize;

/*
- (void)onExit {
    [super onExit];
    for (CCNode *sprite in self.children) {
            sprite.visible = NO;
    }
}
*/

- (void)onEnter {
    [super onEnter];
    
    if (schedule == NO) {
        CCDirector *director = [CCDirector sharedDirector];
        CGSize screenSize = [director winSize];
        
        CCSprite *bgSprite = (CCSprite*)[self getChildByTag:BG_TAG];
        bgSprite.anchorPoint = CGPointMake(0.0f, 0.0f);
        bgSprite.position = CGPointMake(0, 0);
        
        CCSprite *bg2Sprite = (CCSprite*)[self getChildByTag:BG2_TAG];
        bg2Sprite.anchorPoint = CGPointMake(0.0f, 0.0f);
        bg2Sprite.position = CGPointMake(screenSize.width - 2.0f, 0);
        
        CCSprite *bghSprite = (CCSprite*)[self getChildByTag:BGH_TAG];
        bghSprite.anchorPoint = CGPointMake(0.0f, 0.0f);
        bghSprite.position = CGPointMake(0, 600);
        
        CCSprite *corniceSprite = (CCSprite*)[self getChildByTag:CORNICE_TAG];
        corniceSprite.anchorPoint = CGPointMake(0.0f, 0.0f);
        corniceSprite.position= CGPointMake(0.0f, 0.0f);
        
#if KK_PLATFORM_IOS
        NSValue *bValue = [NSValue valueWithCGPoint:CGPointMake(150, 480)];
        NSValue *dValue = [NSValue valueWithCGPoint:CGPointMake(150, 360)];
        NSValue *pValue = [NSValue valueWithCGPoint:CGPointMake(150, 240)];
        NSValue *qValue = [NSValue valueWithCGPoint:CGPointMake(150, 120)];
        NSArray *letterPos  = [NSArray arrayWithObjects:bValue, dValue, pValue, qValue, nil];
        NSInteger lettersCount = letterPos.count;
        for (NSInteger i = 0; i<lettersCount; ++i) {
            CCSprite *posLetterSprite = (CCSprite*)[self getChildByTag:(10 + i)];
            posLetterSprite.position = [[letterPos objectAtIndex:i] CGPointValue];
        }
#else
        NSValue *bValue = [NSValue valueWithPoint:CGPointMake(150, 480)];
        NSValue *dValue = [NSValue valueWithPoint:CGPointMake(150, 360)];
        NSValue *pValue = [NSValue valueWithPoint:CGPointMake(150, 240)];
        NSValue *qValue = [NSValue valueWithPoint:CGPointMake(150, 120)];
        NSArray *letterPos  = [NSArray arrayWithObjects:bValue, dValue, pValue, qValue, nil];
        NSInteger lettersCount = letterPos.count;
        for (NSInteger i = 0; i<lettersCount; ++i) {
            CCSprite *posLetterSprite = (CCSprite*)[self getChildByTag:(10 + i)];
            posLetterSprite.position = [[letterPos objectAtIndex:i] pointValue];
        }
#endif
        
        NSInteger comicsCount = 20;
        for (NSInteger i = 0; i<comicsCount; ++i) {
            CCSprite *comicsSprite = (CCSprite*)[self getChildByTag:(COMICS_TAG + i)];
            comicsSprite.position = CGPointMake(screenSize.width + comicsSprite.contentSize.width, 400);
        }
        
        NSInteger comicsGroupCount = 19;
        for (NSInteger i = 0; i<comicsGroupCount; ++i) {
            CCSprite *comicsSprite = (CCSprite*)[self getChildByTag:(COMICSGROUP_TAG + i)];
            comicsSprite.position = CGPointMake(screenSize.width + comicsSprite.contentSize.width, 400);
        }
        
        for (NSInteger i = 0; i<41; ++i) {
            CCSprite *difficultySprite = (CCSprite*)[self getChildByTag:(100 + i)];
            difficultySprite.position = CGPointMake(screenSize.width + difficultySprite.contentSize.width, 0.0f);
        }
        
        CCSprite *fishSprite = (CCSprite*)[self getChildByTag:FISH_TAG];
#if KK_PLATFORM_IOS
        CGPoint position = [bValue CGPointValue];
#else
        CGPoint position = [bValue pointValue];
#endif
        position.x -= 80.0f;
        fishSprite.position = position;
        
        
        CCSprite *enemyGSprite = (CCSprite*)[self getChildByTag:ENEMYG_TAG];
#if KK_PLATFORM_IOS
        position = [dValue CGPointValue];
#else
        position = [dValue pointValue];
#endif
        position.x -= 80.0f;
        enemyGSprite.position = position;
        enemyGSprite.visible = NO;
        
        CCSprite *cuer1Sprite = (CCSprite*)[self getChildByTag:CUER1_TAG];
        position.y = 300;
        position.x = screenSize.width + cuer1Sprite.contentSize.width/2;
        cuer1Sprite.position= position;
        
        CCSprite *cuer2Sprite = (CCSprite*)[self getChildByTag:CUER2_TAG];
        position.y = 300;
        position.x = screenSize.width + cuer2Sprite.contentSize.width/2;
        cuer2Sprite.position= position;
        
        CCSprite *cuer3Sprite = (CCSprite*)[self getChildByTag:CUER3_TAG];
        position.y = 300;
        position.x = screenSize.width + cuer3Sprite.contentSize.width/2;
        cuer3Sprite.position= position;
        
        CCSprite *endSprite = (CCSprite*)[self getChildByTag:END_TAG];
        position.x = 800;
        position.y = 660;
        endSprite.position = position;
        
        CCSprite *enemySprite = (CCSprite*)[self getChildByTag:ENEMYP_TAG];
        position.x = 50;
        position.y = 660;
        enemySprite.position = position;
        
        CCSprite *playerPSprite = (CCSprite*)[self getChildByTag:PLAYERP_TAG];
        position.x = 50;
        position.y = 650;
        playerPSprite.position = position;
        
        /*
        CCSprite *wonSprite = (CCSprite*)[self getChildByTag:WONGAME_TAG];
        CCSprite *lostSprite = (CCSprite*)[self getChildByTag:LOSTGAME_TAG];
        position.x = screenSize.width/2.0f;
        position.y = screenSize.height/2.0f;
        wonSprite.position = position;
        lostSprite.position = position;
        */
        
#if KK_PLATFORM_IOS
        //self.peerPickerController = [[GKPeerPickerController alloc] init];
        //[self.peerPickerController show];
#endif
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *menuItemSpriteFrame = [frameCache spriteFrameByName:@"start.png"];
        CCSprite* menuItemSprite = [CCSprite spriteWithSpriteFrame:menuItemSpriteFrame];
        CCMenuItemSprite* menuItem = [CCMenuItemSprite itemWithNormalSprite:menuItemSprite selectedSprite:nil block:^(id sender) {
            CCNode *node = (CCNode*)(sender);
            
            NSLog(@"class %@ parent: %@", [node class], [node.parent class]);
            
            
            schedule = YES;
            if (self.bgAudio == YES) {
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusic0.caf" loop:YES];
            }
            
            [fishSprite runAction:self.fishAnimation];
            [self scheduleUpdate];
            [self removeChild:node.parent cleanup:YES];
        }];
        
        CCMenu* menu = [CCMenu menuWithItems:menuItem, nil];
        menu.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        [self addChild:menu];
        [menu alignItemsVerticallyWithPadding:40];
        
        CCSpriteFrame *pauseSpriteFrame = [frameCache spriteFrameByName:@"MenuX.png"];
        CCSprite* pauseItemSprite = [CCSprite spriteWithSpriteFrame:pauseSpriteFrame];
        CCMenuItemSprite* pauseItem = [CCMenuItemSprite itemWithNormalSprite:pauseItemSprite selectedSprite:nil block:^(id sender) {
            [self pause];
        }];
        pauseItem.anchorPoint = CGPointMake(0.0f, 0.0f);
        CCMenu* pauseMenu = [CCMenu menuWithItems:pauseItem, nil];
        pauseMenu.anchorPoint = CGPointMake(0.0f, 0.0f);
        pauseMenu.position = CGPointMake(880.0f, 620.0f);
        [self addChild:pauseMenu];
        [pauseMenu alignItemsVerticallyWithPadding:40];
        
        NSLog(@"bgAudio is %i", self.bgAudio);
        
        if (self.bgAudio == YES) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusicLG.caf" loop:YES];
        }
        
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSURL *route0URL = [mainBundle URLForResource:[NSString stringWithFormat:@"route%i", self.currentLevel] withExtension:@"xml"];
        Route *route = [[[RouteParser alloc] init] routeFromURL:route0URL];
        
        /*
         for (Difficulty *difficulty in route.difficulties) {
         NSLog(@"diffculty: type %i, distance %i, cue %i, cuePos: %i, cueGroup: %@, cuePlace: %i",
         difficulty.type, difficulty.distance, difficulty.cuePresent, difficulty.cuePos, difficulty.group, difficulty.place);
         for (Position *pos in difficulty.positions) {
         NSLog(@"position: number %i, speedEffect: %i, progressEffect: %i, spriteName: %@, pick: %@, type: %@",
         pos.number, pos.speedEffect, pos.progressEffect, pos.spriteName, pos.onPickSpriteName, pos.type);
         }
         }
         */
        self.currentRoute = route;
        
        self.maxTime = self.currentRoute.raceLength * 1.0f;
    }
}

- (void)pause {
    [self pauseSchedulerAndActions];
    pause = YES;
    ccColor4B c = {10, 10, 10, 200};
    MenuLayer *p = [[MenuLayer alloc] initWithColor:c];
    [self.parent addChild:p z:10];
    [self onExit];
    if (self.bgAudio == YES) {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
}

- (void)resume {
    if (self.bgAudio == YES) {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == NO) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusic0.caf" loop:YES];
        }
    }
    pause = NO;
    [self onEnter];
    [self resumeSchedulerAndActions];
}

- (void)nextLevel {
    //cambia route
    totTime = 0.0f;
    totDistance = 0.0f;
    totEnemyDistance = 0.0f;
    currentDistance = 0.0f;
    CGFloat currentSpeed = 10.0f + self.currentLevel;
    speed = currentSpeed;
    enemySpeed = currentSpeed;
    if (speed > self.maxSpeed) {
        speed = self.maxSpeed;
        enemySpeed = self.maxSpeed;
    }
    self.currentLevel = self.currentLevel + 1;
    if (self.currentLevel == 14) {
        NSLog(@"VITTORIA, FINE GIOCO");
        self.currentLevel = 0;
    }
    [self onEnter];
}

- (void)replayLevel {
    totTime = 0.0f;
    totDistance = 0.0f;
    totEnemyDistance = 0.0f;
    currentDistance = 0.0f;
    CGFloat currentSpeed = 10.0f + self.currentLevel;
    speed = currentSpeed;
    enemySpeed = currentSpeed;
    if (speed > self.maxSpeed) {
        speed = self.maxSpeed;
        enemySpeed = self.maxSpeed;
    }
    [self onEnter];
}

- (id)init {
	if ((self = [super init])) {
		CCLOG(@"%@ init", NSStringFromClass([self class]));
        
        self.tag = 1;
        pause = YES;
        schedule = NO;
        
        totTime = 0.0f;
        totDistance = 0.0f;
        totEnemyDistance = 0.0f;
        currentDistance = 0.0f;
        speed = 10.0f;
        enemySpeed = 10.0f;
        self.minSpeed = 5.0f;
        self.maxSpeed = 30.0f;
        self.currentDifficulty = nil;
        
        self.currentLevel = 0;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *bgAudioOnNumber = [defaults valueForKey:@"bgAudio"];
        NSNumber *effectOnNumber = [defaults valueForKey:@"effectAudio"];
        NSInteger bgAudioOn = 1;
        if (bgAudioOnNumber != nil) {
            bgAudioOn = [bgAudioOnNumber integerValue];
        } else {
            [defaults setValue:[NSNumber numberWithInteger:1] forKey:@"bgAudio"];
        }
        NSInteger effectOn = 1;
        if (effectOnNumber != nil) {
            effectOn = [effectOnNumber integerValue];
        } else {
            [defaults setValue:[NSNumber numberWithInteger:1] forKey:@"effectAudio"];
        }
        if (bgAudioOn == 1)
            self.bgAudio = YES;
            else self.bgAudio = NO;
        if (effectOn == 1) 
            self.effectAudio = YES;
            else self.effectAudio = NO;
        
        NSLog(@"bg %i - eff %i", self.bgAudio, self.effectAudio);
        
		CCDirector* director = [CCDirector sharedDirector];
        //[director enableRetinaDisplay:YES];
        
        
        //CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //    screenSize = CGSizeMake(1024, 768);
        //}
        
        
#if KK_PLATFORM_IOS
        CCFileUtils * fileUtils = [CCFileUtils sharedFileUtils];
        //[fileUtils setiPadSuffix:@""];
        //[fileUtils setiPadRetinaDisplaySuffix:[fileUtils iPhoneRetinaDisplaySuffix]];
        [fileUtils setiPhoneRetinaDisplaySuffix:@"-ipad"];
        //[fileUtils setiPadRetinaDisplaySuffix:[fileUtils iPhoneRetinaDisplaySuffix]];
#endif
        
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"fishgamesprites.plist"];
        
        
        NSString *spriteNameBg = @"ambiente.png";
        CCSpriteFrame *bgFrame = [frameCache spriteFrameByName:spriteNameBg];
        CCSprite *bgSprite = [[CCSprite alloc] initWithSpriteFrame:bgFrame];
        bgSprite.tag = BG_TAG;
        [self addChild:bgSprite];
        
        CCSpriteFrame *bg2Frame = [frameCache spriteFrameByName:spriteNameBg];
        CCSprite *bg2Sprite = [[CCSprite alloc] initWithSpriteFrame:bg2Frame];
        bg2Sprite.tag = BG2_TAG;
        [self addChild:bg2Sprite];
        
        NSString *spriteNameBgh = @"headerbg.png";
        CCSpriteFrame *bghFrame = [frameCache spriteFrameByName:spriteNameBgh];
        CCSprite *bghSprite = [[CCSprite alloc] initWithSpriteFrame:bghFrame];
        bghSprite.tag = BGH_TAG;
        [self addChild:bghSprite];
        
        CCSprite *cuer1Sprite = [[CCSprite alloc] initWithSpriteFrameName:@"cuer1L.png"];
        cuer1Sprite.scale = 1;
        cuer1Sprite.tag = CUER1_TAG;
        [self addChild:cuer1Sprite];
        
        CCSprite *cuer2Sprite = [[CCSprite alloc] initWithSpriteFrameName:@"cuer2L.png"];
        cuer2Sprite.scale = 1;
        cuer2Sprite.tag = CUER2_TAG;
        [self addChild:cuer2Sprite];
        
        CCSprite *cuer3Sprite = [[CCSprite alloc] initWithSpriteFrameName:@"cuer3L.png"];
        cuer3Sprite.scale = 1;
        cuer3Sprite.tag = CUER3_TAG;
        [self addChild:cuer3Sprite];
        
        
        NSString *bLetter = @"bPosLetter.png";
        NSString *dLetter = @"dPosLetter.png";
        NSString *pLetter = @"pPosLetter.png";
        NSString *qLetter = @"qPosLetter.png";
        
        NSArray *letterNames = [NSArray arrayWithObjects:bLetter, dLetter, pLetter, qLetter, nil];
        
        NSInteger lettersCount = letterNames.count;
        for (NSInteger i = 0; i<lettersCount; ++i) {
            CCSpriteFrame *posLetterFrame = [frameCache spriteFrameByName:[letterNames objectAtIndex:i]];
            CCSprite *posLetterSprite = [[CCSprite alloc] initWithSpriteFrame:posLetterFrame];
            posLetterSprite.tag = 10 + i;
            [self addChild:posLetterSprite];
        }
        
        for (NSInteger i=0; i<41; ++i) {
            CCSpriteFrame *difficultyFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"difficulty%i.png", i]];
            CCSprite *difficultySprite = [[CCSprite alloc] initWithSpriteFrame:difficultyFrame];
            difficultySprite.tag = 100 + i;
            [self addChild:difficultySprite];
        }
        
        
        NSArray *comicsNames = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e",
                                @"f", @"g", @"i", @"l", @"m", @"n", @"o", @"p", @"q",
                                @"r", @"s", @"t", @"u", @"v", @"z", nil];
        NSMutableArray *comicsTags = [NSMutableArray arrayWithCapacity:comicsNames.count];
        
        NSInteger comicsCount = comicsNames.count;
        for (NSInteger i = 0; i<comicsCount; ++i) {
            CCSpriteFrame *comicsFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@%@.png", COMICS_PATH, comicsNames[i]]];
            CCSprite *comicsSprite = [[CCSprite alloc] initWithSpriteFrame:comicsFrame];
            comicsSprite.tag = COMICS_TAG + i;
            [comicsTags addObject:[[NSNumber numberWithInteger:comicsSprite.tag] stringValue]];
            [self addChild:comicsSprite];
        }
        
        self.comicsNameTag = [NSDictionary dictionaryWithObjects:comicsTags
                                                         forKeys:comicsNames];
        
        NSArray *comicsGroupNames = [NSArray arrayWithObjects:@"aefg", @"aegv", @"afnv", @"agoz", @"aotz",
                                     @"cins", @"cisv", @"cue0", @"cue1", @"cue2", @"cue3", @"eilt", @"fgor", @"glst",
                                     @"gnrv", @"gruz", @"ilru", @"inor", @"sharps", nil];
        NSMutableArray *comicsGroupTags = [NSMutableArray arrayWithCapacity:comicsNames.count];
        
        NSInteger comicsGroupCount = comicsGroupNames.count;
        for (NSInteger i = 0; i<comicsGroupCount; ++i) {
            CCSpriteFrame *comicsFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", comicsGroupNames[i]]];
            CCSprite *comicsSprite = [[CCSprite alloc] initWithSpriteFrame:comicsFrame];
            comicsSprite.tag = COMICSGROUP_TAG + i;
            [comicsGroupTags addObject:[[NSNumber numberWithInteger:comicsSprite.tag] stringValue]];
            [self addChild:comicsSprite];
        }
        
        self.comicsGroupNameTag = [NSDictionary dictionaryWithObjects:comicsGroupTags
                                                              forKeys:comicsGroupNames];
        
        NSString *spriteNameCornice = @"cornice.png";
        CCSpriteFrame *corniceFrame = [frameCache spriteFrameByName:spriteNameCornice];
        CCSprite *corniceSprite = [[CCSprite alloc] initWithSpriteFrame:corniceFrame];
        corniceSprite.tag = CORNICE_TAG;
        [self addChild:corniceSprite];
        
        NSString *spriteNameEnd = @"bandiereScacchi.png";
        CCSpriteFrame *endFrame = [frameCache spriteFrameByName:spriteNameEnd];
        CCSprite *endSprite = [[CCSprite alloc] initWithSpriteFrame:endFrame];
        endSprite.tag = END_TAG;
        [self addChild:endSprite];
        
        NSString *spriteNameEnemy = @"enemy0.png";
        CCSpriteFrame *enemyFrame = [frameCache spriteFrameByName:spriteNameEnemy];
        CCSprite *enemySprite = [[CCSprite alloc] initWithSpriteFrame:enemyFrame];
        enemySprite.tag = ENEMYP_TAG;
        [self addChild:enemySprite];
        
        CCSprite *enemyGameSprite = [[CCSprite alloc] initWithSpriteFrame:enemyFrame];
        enemyGameSprite.tag = ENEMYG_TAG;
        [self addChild:enemyGameSprite];
        
        NSString *spriteNamePlayerP = @"fish0.png";
        CCSpriteFrame *playerPFrame = [frameCache spriteFrameByName:spriteNamePlayerP];
        CCSprite *playerPSprite = [[CCSprite alloc] initWithSpriteFrame:playerPFrame];
        playerPSprite.tag = PLAYERP_TAG;
        [self addChild:playerPSprite];
        
        CCSprite *animSprite = [[CCSprite alloc] initWithSpriteFrameName:@"fish0.png"];
        animSprite.scale = 1;
        animSprite.tag = FISH_TAG;
        [self addChild:animSprite];
        
        
        NSMutableArray *animFrames = [NSMutableArray array];
        for (int i=0; i<2; ++i) {
            NSString *spriteName = [NSString stringWithFormat:@"fish%i.png", i];
            CCSpriteFrame *frame = [frameCache spriteFrameByName:spriteName];
            [animFrames addObject:frame];
        }
        CCAnimation *anim = [CCAnimation animationWithSpriteFrames:animFrames];
        [anim setDelayPerUnit:0.2];
        CCAnimate * animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever * rp = [CCRepeatForever actionWithAction:animate];
        
        animate.tag = 2;
        rp.tag = 3;
        [rp stop];
        
        self.fishAnimation = rp;
        
		// get the hello world string from the config.lua file
		//[KKConfig injectPropertiesFromKeyPath:@"HelloWorldSettings" target:self];
        
		// print out which platform we're on
		NSString* platform = @"(unknown platform)";
		
		if (director.currentPlatformIsIOS)
		{
			// add code
			platform = @"iPhone/iPod Touch";
			
			if (director.currentDeviceIsIPad)
				platform = @"iPad";
            
			if (director.currentDeviceIsSimulator)
				platform = [NSString stringWithFormat:@"%@ Simulator", platform];
            
            //self.isTouchEnabled = YES;
		}
		else if (director.currentPlatformIsMac)
		{
			platform = @"Mac OS X";
		}
		
        /*
         CCLabelTTF* platformLabel = nil;
         if (director.currentPlatformIsIOS)
         {
         // how to add custom ttf fonts to your app is described here:
         // http://tetontech.wordpress.com/2010/09/03/using-custom-fonts-in-your-ios-application/
         float fontSize = (director.currentDeviceIsIPad) ? 48 : 28;
         platformLabel = [CCLabelTTF labelWithString:platform
         fontName:@"Ubuntu Condensed"
         fontSize:fontSize];
         }
         else if (director.currentPlatformIsMac)
         {
         // Mac builds have to rely on fonts installed on the system.
         platformLabel = [CCLabelTTF labelWithString:platform
         fontName:@"Zapfino"
         fontSize:32];
         }
         
         platformLabel.position = director.screenCenter;
         platformLabel.color = ccYELLOW;
         [self addChild:platformLabel];
         
         id movePlatform = [CCMoveBy actionWithDuration:0.2f
         position:CGPointMake(0, 50)];
         [platformLabel runAction:movePlatform];
         */
        
		glClearColor(0.2f, 0.2f, 0.4f, 1.0f);
        
		// play sound with CocosDenshion's SimpleAudioEngine
		//[[SimpleAudioEngine sharedEngine] playEffect:@"Pow.caf"];
        
        KKInput* input = [KKInput sharedInput];
        input.userInteractionEnabled = YES;
        
        NSArray *sounds = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F",
                           @"G", @"I", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S",
                           @"T", @"U", @"V", @"Z", @"lost", @"record", @"won", @"wrong",
                           @"OneBubble", @"bgMusic0", @"bgMusic2", @"bgMusicLG", nil];
        for (NSString *sound in sounds) {
            [[SimpleAudioEngine sharedEngine] preloadEffect:[NSString stringWithFormat:@"%@.caf", sound]];
        }
	}
    
	return self;
}

- (void)update:(ccTime)delta {
    CCDirector *director = [CCDirector sharedDirector];
    CGSize screenSize = [director winSize];
    KKInput* input = [KKInput sharedInput];
    
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSprite *fishSprite = (CCSprite*)[self getChildByTag:FISH_TAG];
    
    totTime += delta;
    CGFloat frameDistance = (speed * delta * 20.0f);
    CGFloat frameDistanceEnemy = (enemySpeed * delta * 20.0f);
    CGFloat distanceFactor = 20.0f;
    CGFloat difficultyDelta = 0.0f;
    CGFloat endDelta = 150.0f;
    totDistance += frameDistance/distanceFactor;
    totEnemyDistance += frameDistanceEnemy/distanceFactor;
    currentDistance += frameDistance/distanceFactor;
    
    //CONDIZIONE TERMINAZIONE: PERCORSO CONCLUSO, VITTORIA
    if (totDistance >= (self.currentRoute.raceLength + endDelta)) {
        if (self.bgAudio == YES) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        if (self.effectAudio == YES) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"won.caf"];
        }
        CCAction *fishAnim = [fishSprite getActionByTag:3];
        [fishSprite stopAction:fishAnim];
        
        for (CCNode *node in self.children) {
            [node stopAllActions];
        }
        
        [self unscheduleUpdate];
        schedule = NO;
        pause = YES;
        ccColor4B c = { 10, 10, 10, 200 };
        EndLevelLayer *p = [[EndLevelLayer alloc] initWithColor:c];
        [p levelEndWithVictory:YES];
        [self.parent addChild:p z:10];
        [self onExit];
    }
    
    if (totEnemyDistance >= (self.currentRoute.raceLength + endDelta)) {
        if (self.bgAudio == YES) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        if (self.effectAudio == YES){
            [[SimpleAudioEngine sharedEngine] playEffect:@"lost.caf"];
        }
        
        CCAction *fishAnim = [fishSprite getActionByTag:3];
        [fishSprite stopAction:fishAnim];
        for (CCNode *node in self.children) {
            [node stopAllActions];
        }
        
        [self unscheduleUpdate];
        schedule = NO;
        pause = YES;
        ccColor4B c = { 10, 10, 10, 200 };
        EndLevelLayer *p = [[EndLevelLayer alloc] initWithColor:c];
        [p levelEndWithVictory:NO];
        [self.parent addChild:p z:10];
        [self onExit];
    }
    
    
    //NSLog(@"totDistance %f", totDistance);
    //NSLog(@"delta: %f", totTime);
    
    if (self.currentRoute.difficulties.count > 0) {
        Difficulty *difficulty = (Difficulty*)self.currentRoute.difficulties[0];
        if (currentDistance >= (difficulty.distance + difficultyDelta)) {
            currentDistance = 0.0f;
            
            if (difficulty.cuePresent == YES) {
                CCSprite *cuer1Sprite = (CCSprite*)[self getChildByTag:CUER1_TAG];
                CCSprite *cuer2Sprite = (CCSprite*)[self getChildByTag:CUER2_TAG];
                CCSprite *cuer3Sprite = (CCSprite*)[self getChildByTag:CUER3_TAG];
                
                CGFloat ran1 = CCRANDOM_0_1();
                CCSprite *cuerSprite = cuer1Sprite;
                if (ran1 > 0.66) {
                    cuerSprite = cuer3Sprite;
                } else if (ran1 > 0.33) {
                    cuerSprite = cuer2Sprite;
                }
                
                CGFloat distance = 150;
                CGFloat duration = distance/(speed * 20.0f);
                
                CCAction *enterAction = [CCMoveTo actionWithDuration:duration position:CGPointMake(cuerSprite.position.x - distance, cuerSprite.position.y)];
                CCAction *intervalPause = [CCDelayTime actionWithDuration:1.0];
                CCAction *flip1Action = [CCFlipX actionWithFlipX:YES];
                CCAction *exitAction = [CCMoveTo actionWithDuration:duration position:CGPointMake(screenSize.width + cuerSprite.contentSize.width/2, cuerSprite.position.y)];
                CCAction *flip2Action = [CCFlipX actionWithFlipX:NO];
                
                CCSequence *moveSeq = [CCSequence actionWithArray:@[enterAction, intervalPause, flip1Action, exitAction, flip2Action]];
                
                [cuerSprite runAction:moveSeq];
                
                
                if (difficulty.type == 3) {
                    NSString *cueGroup = difficulty.group;
                    NSNumber *comicsGroupTag = [self.comicsGroupNameTag valueForKey:cueGroup];
                    NSLog(@"diff type 3, letter %@, tag: %@", cueGroup, comicsGroupTag);
                    CCSprite *comicsSprite = (CCSprite*)[self getChildByTag:[comicsGroupTag integerValue]];
                    
                    NSInteger cueSharpPos = difficulty.place;
                    //NSString *letter = [cueGroup substringWithRange:NSMakeRange(cueSharpPos, 1)];
                    //NSNumber *comicsGroupTag = [self.comicsGroupNameTag valueForKey:cueGroup];
                    
                    CCSprite *comicsSharpsSprite = (CCSprite*)[self getChildByTag:COMICSGROUP_TAG + 7 + cueSharpPos];
                    
                    
                    
                    CCAction *comicsInterval1Pause = [CCDelayTime actionWithDuration:duration];
                    CCAction *comicsEnterAction = [CCMoveTo actionWithDuration:0.0f position:CGPointMake(comicsSprite.position.x - distance - 50.0f, comicsSprite.position.y)];
                    CCAction *comicsInterval2Pause = [CCDelayTime actionWithDuration:0.5];
                    CCAction *changeTexture = [CCCallBlock actionWithBlock:^{
                        [comicsSprite setDisplayFrame:comicsSharpsSprite.displayFrame];
                    }];
                    CCAction *comicsInterval3Pause = [CCDelayTime actionWithDuration:0.5];
                    CCAction *comicsExitAction = [CCMoveTo actionWithDuration:0.0f position:CGPointMake(screenSize.width + comicsSprite.contentSize.width/2, comicsSprite.position.y)];
                    CCAction *restoreTexture = [CCCallBlock actionWithBlock:^{
                        CCSpriteFrame *restoreFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", cueGroup]];
                        [comicsSprite setDisplayFrame:restoreFrame];
                    }];
                    
                    CCSequence *comicsMoveSeq = [CCSequence actionWithArray:@[comicsInterval1Pause, comicsEnterAction, comicsInterval2Pause, changeTexture, comicsInterval3Pause, restoreTexture, comicsExitAction]];
                    
                    [comicsSprite runAction:comicsMoveSeq];
                    
                } else {
                    CCSprite *comicsSprite = nil;
                    NSString *cueLetter = nil;
                    if (difficulty.type == 0 || difficulty.type == 1) {
                        switch (difficulty.cuePos) {
                            case 0:
                            {
                                cueLetter = @"b";
                                comicsSprite = (CCSprite*)[self getChildByTag:200 + 1];
                                break;
                            }
                            case 1:
                            {
                                cueLetter = @"d";
                                comicsSprite = (CCSprite*)[self getChildByTag:200 + 3];
                                break;
                            }
                            case 2:
                            {
                                cueLetter = @"p";
                                comicsSprite = (CCSprite*)[self getChildByTag:200 + 12];
                                break;
                            }
                            case 3:
                            {
                                cueLetter = @"q";
                                comicsSprite = (CCSprite*)[self getChildByTag:200 + 13];
                                break;
                            }
                            default:
                                comicsSprite = (CCSprite*)[self getChildByTag:200 + 1];
                                break;
                        }
                    } else if (difficulty.type == 2) {
                        cueLetter = difficulty.letter;
                        NSNumber *comicsTag = [self.comicsNameTag valueForKey:cueLetter];
                        comicsSprite = (CCSprite*)[self getChildByTag:[comicsTag integerValue]];
                    }
                    CCAction *comicsInterval1Pause = [CCDelayTime actionWithDuration:duration];
                    CCAction *comicsEnterAction = [CCMoveTo actionWithDuration:0.0f position:CGPointMake(comicsSprite.position.x - distance - 50.0f, comicsSprite.position.y)];
                    CCAction *comicsSoundAction = [CCCallBlock actionWithBlock:^{
                        if (self.effectAudio == YES) {
                            [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%@.caf", [cueLetter uppercaseString]]];
                        }
                    }];
                    CCAction *comicsInterval2Pause = [CCDelayTime actionWithDuration:1.0];
                    CCAction *comicsExitAction = [CCMoveTo actionWithDuration:0.0f position:CGPointMake(screenSize.width + comicsSprite.contentSize.width/2, comicsSprite.position.y)];
                    
                    CCSequence *comicsMoveSeq = [CCSequence actionWithArray:@[comicsInterval1Pause, comicsEnterAction, comicsSoundAction, comicsInterval2Pause, comicsExitAction]];
                    
                    [comicsSprite runAction:comicsMoveSeq];
                }
            }
            
            
            for (Position *pos in difficulty.positions) {
                if ([pos.type isEqualToString:@"obstacle"] || [pos.type isEqualToString:@"letter"]) {
                    NSInteger difficultyNumber = [[pos.spriteName stringByReplacingOccurrencesOfString:@"difficulty" withString:@""] integerValue];
                    CCSprite *difficultySprite = (CCSprite*)[self getChildByTag:(100 + difficultyNumber)];
                    switch (pos.number) {
                        case 0:
                        {
                            difficultySprite.position = CGPointMake(screenSize.width + 500, 480);
                            break;
                        }
                        case 1:
                        {
                            difficultySprite.position = CGPointMake(screenSize.width + 500, 360);
                            break;
                        }
                        case 2:
                        {
                            difficultySprite.position = CGPointMake(screenSize.width + 500, 240);
                            break;
                        }
                        case 3:
                        {
                            difficultySprite.position = CGPointMake(screenSize.width + 500, 120);
                            break;
                        }
                        default:
                            break;
                    }
                    
                    CGFloat distance = 1024 + 500 + 50;
                    CGFloat duration = distance/(speed * 20.0f);
                    CCAction *enterAction = [CCMoveTo actionWithDuration:duration position:CGPointMake(difficultySprite.position.x - distance, difficultySprite.position.y)];
                    CCAction *exitAction = [CCMoveTo actionWithDuration:0.0f position:CGPointMake(screenSize.width + difficultySprite.contentSize.width, difficultySprite.position.y)];
                    CCSequence *moveSeq = [CCSequence actionWithArray:@[enterAction, exitAction]];
                    [difficultySprite runAction:moveSeq];
                }
            }
            
            self.currentDifficulty = difficulty;
            [self.currentRoute.difficulties removeObjectAtIndex:0];
            NSLog(@"removed diffculty at pos %i", difficulty.distance);
        }
    }
    
    
    
    CCSprite *bgSprite = (CCSprite*)[self getChildByTag:BG_TAG];
    CCSprite *bg2Sprite = (CCSprite*)[self getChildByTag:BG2_TAG];
    
    NSArray *bgArray = [NSArray arrayWithObjects:bgSprite, bg2Sprite, nil];
    
    for (CCSprite *bg in bgArray) {
        CGPoint bgPos = bg.position;
        bgPos.x -= frameDistance;
        if (bgPos.x < -screenSize.width) {
            bgPos.x += (screenSize.width * 2.0f) - 4.0f;
        }
        bg.position = bgPos;
    }
    
    CCSprite *endSprite = (CCSprite*)[self getChildByTag:END_TAG];
    CCSprite *enemySprite = (CCSprite*)[self getChildByTag:ENEMYP_TAG];
    CGPoint enemyPos = enemySprite.position;
    enemyPos.x = (totEnemyDistance * (endSprite.position.x - endSprite.contentSize.width/2.0f - 50.0f) / ((self.currentRoute.raceLength + endDelta)) ) + 50.0f;
    enemySprite.position = enemyPos;
    
    CCSprite *playerPSprite = (CCSprite*)[self getChildByTag:PLAYERP_TAG];
    CGPoint playerPPos = playerPSprite.position;
    playerPPos.x = (totDistance * (endSprite.position.x - endSprite.contentSize.width/2.0f - 50.0f) / (self.currentRoute.raceLength + endDelta)) + 50.0f;
    playerPSprite.position = playerPPos;
    
    /*
    CCSprite *enemyGSprite = (CCSprite*)[self getChildByTag:ENEMYG_TAG];
    CGPoint enemyGPos = enemyGSprite.position;
    CGFloat playerDistance = totEnemyDistance - totDistance;
    CGFloat totPixelDistance = self.currentRoute.raceLength * 10 * 0.016 * 20;
    //playerDistance / totracelaength = pixelDistance / totPixelDistance
    CGFloat pixelDistance = playerDistance * totPixelDistance / self.currentRoute.raceLength;
    
    if (pixelDistance > -100 && pixelDistance < 1000) {
        enemyGSprite.visible = YES;
        enemyGPos.x = (playerDistance * totPixelDistance / self.currentRoute.raceLength) + 70.0f;
        enemyGSprite.position = enemyGPos;
    } else {
        enemyGSprite.visible = NO;
    }
    */
    
    
    CCSprite *sprite = (CCSprite*)[self getChildByTag:FISH_TAG];
    CCSprite *bsprite = (CCSprite*)[self getChildByTag:B_TAG];
    CCSprite *dsprite = (CCSprite*)[self getChildByTag:D_TAG];
    CCSprite *psprite = (CCSprite*)[self getChildByTag:P_TAG];
    CCSprite *qsprite = (CCSprite*)[self getChildByTag:Q_TAG];
    
    //IPHONE INPUT
    CCSprite *currentTouchedSprite = nil;
    if ([input isAnyTouchOnNode:bsprite touchPhase:KKTouchPhaseBegan]) {
        currentTouchedSprite = bsprite;
    }
    if ([input isAnyTouchOnNode:dsprite touchPhase:KKTouchPhaseBegan]) {
        currentTouchedSprite = dsprite;
    }
    if ([input isAnyTouchOnNode:psprite touchPhase:KKTouchPhaseBegan]) {
        currentTouchedSprite = psprite;
    }
    if ([input isAnyTouchOnNode:qsprite touchPhase:KKTouchPhaseBegan]) {
        currentTouchedSprite = qsprite;
    }
    /*
     if ([input isAnyTouchOnNode:sprite touchPhase:KKTouchPhaseBegan]) {
     NSLog(@"%@ began", NSStringFromSelector(_cmd));
     
     }
     if ([input isAnyTouchOnNode:sprite touchPhase:KKTouchPhaseEnded]) {
     NSLog(@"%@ ended", NSStringFromSelector(_cmd));
     
     }
     */
    //KEYBOARD INPUT
    if ([input isKeyUpThisFrame:KKKeyCode_UpArrow]) {
        if (fishSprite.position.y <= qsprite.position.y) {
            currentTouchedSprite = psprite;
        } else if (fishSprite.position.y > qsprite.position.y && fishSprite.position.y <= psprite.position.y) {
            currentTouchedSprite = dsprite;
        } else if (fishSprite.position.y > psprite.position.y && fishSprite.position.y <= dsprite.position.y) {
            currentTouchedSprite = bsprite;
        }
    } else if ([input isKeyUpThisFrame:KKKeyCode_DownArrow]) {
        
        if (fishSprite.position.y <= psprite.position.y && fishSprite.position.y > qsprite.position.y) {
            currentTouchedSprite = qsprite;
        } else if (fishSprite.position.y <= dsprite.position.y && fishSprite.position.y > psprite.position.y) {
            currentTouchedSprite = psprite;
        } else if (fishSprite.position.y <= bsprite.position.y && fishSprite.position.y > dsprite.position.y) {
            currentTouchedSprite = dsprite;
        }
    }
    
    if (currentTouchedSprite != nil) {
        NSLog(@"%@ stat", NSStringFromSelector(_cmd));
        
        [currentTouchedSprite stopAllActions];
        
        //CGPoint loc = input.anyTouchLocation;
        CGPoint loc = currentTouchedSprite.position;
        loc.x -= 80;
        
        
        id move = nil;
        
        CGPoint targetPoint = loc;
        CGPoint originalPoint = sprite.position;
        
        CGFloat xDist = (originalPoint.x - targetPoint.x);
        CGFloat yDist = (originalPoint.y - targetPoint.y);
        CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
        
        CGFloat duration = distance/800;
        move = [CCMoveTo actionWithDuration:duration position:targetPoint];
        
        id rotate = nil;
        id rotate2 = nil;
        
        
        CCCallBlock *flip = [CCCallBlock actionWithBlock:^{
            sprite.flipX = NO;
        }];
        
        id moves = nil;
        if ((sprite.position.y - targetPoint.y) <= 0 && (sprite.position.x - targetPoint.x) <= 0) {
            //ALTO DX
            sprite.flipX = NO;
            rotate = [CCRotateTo actionWithDuration:0.2 angle:-30.0];
            rotate2 = [CCRotateTo actionWithDuration:0.2 angle:0.0];
            
            moves = [CCSequence actionWithArray:@[move, rotate2]];
        } else if ((sprite.position.y - targetPoint.y) <= 0 && (sprite.position.x - targetPoint.x) >= 0){
            //ALTO SX
            sprite.flipX = YES;
            rotate = [CCRotateTo actionWithDuration:0.2 angle:30.0];
            rotate2 = [CCRotateTo actionWithDuration:0.2 angle:0];
            
            moves = [CCSequence actionWithArray:@[move, rotate2, flip]];
        } else if ((sprite.position.y - targetPoint.y) >= 0 && (sprite.position.x - targetPoint.x) <= 0){
            //BASSO DX
            sprite.flipX = NO;
            rotate = [CCRotateTo actionWithDuration:0.2 angle:30.0];
            rotate2 = [CCRotateTo actionWithDuration:0.2 angle:0];
            moves = [CCSequence actionWithArray:@[move, rotate2]];
        } else if ((sprite.position.y - targetPoint.y) >= 0 && (sprite.position.x - targetPoint.x) >= 0){
            //BASSO SX
            sprite.flipX = YES;
            rotate = [CCRotateTo actionWithDuration:0.2 angle:-30.0];
            rotate2 = [CCRotateTo actionWithDuration:0.2 angle:0];
            moves = [CCSequence actionWithArray:@[move, rotate2, flip]];
        }
        [sprite runAction:rotate];
        [sprite runAction:moves];
    }
    
    //COLLISION DETECTION
    if (self.currentDifficulty) {
        for (Position *pos in self.currentDifficulty.positions) {
            if ([pos.type isEqualToString:@"obstacle"] || [pos.type isEqualToString:@"letter"]) {
                NSInteger difficultyNumber = [[pos.spriteName stringByReplacingOccurrencesOfString:@"difficulty" withString:@""] integerValue];
                CCSprite *difficultySprite = (CCSprite*)[self getChildByTag:(100 + difficultyNumber)];
                
                CGFloat fishImageSize = fishSprite.contentSize.width;
                CGFloat difficultySize = difficultySprite.contentSize.width;
                CGFloat fishCollisionRadius = fishImageSize * 0.4f;
                CGFloat difficultyCollisionRadius = difficultySize * 0.4f;
                
                CGFloat maxCollisionDistance = fishCollisionRadius + difficultyCollisionRadius;
                
                CGFloat actualDistance = ccpDistance(fishSprite.position, difficultySprite.position);
                
                if (actualDistance < maxCollisionDistance) {
                    //NSLog(@"COLLISION!!! con %i", difficultyNumber);
                    if (pos.speedEffect != 0) {
                        speed = speed + pos.speedEffect; //*0.5;
                        if (speed < self.minSpeed) speed = self.minSpeed;
                        if (speed > self.maxSpeed) speed = self.maxSpeed;
                        NSLog(@"speed: %f", speed);
                    }
                    
                    
                    if ([pos.type isEqualToString:@"obstacle"]) {
                        if (self.effectAudio == YES) {
                            [[SimpleAudioEngine sharedEngine] playEffect:@"wrong.caf"];
                        }
                    } else if ([pos.type isEqualToString:@"letter"]) {
                        if (pos.onPickSpriteName && ![pos.onPickSpriteName isEqualToString:@"vanish"]) {
                            CCSpriteFrame *effectFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@.png", pos.onPickSpriteName]];
                            [difficultySprite setDisplayFrame:effectFrame];
                            CCAction *restoreTexture = [CCCallBlock actionWithBlock:^{
                                CCSpriteFrame *restoreFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"difficulty%i.png", difficultyNumber]];
                                [difficultySprite setDisplayFrame:restoreFrame];
                            }];
                            CCAction *intervalPause = [CCDelayTime actionWithDuration:1.0];
                            CCSequence *moveSeq = [CCSequence actionWithArray:@[intervalPause, restoreTexture]];
                            [difficultySprite runAction:moveSeq];
                            
                        } else if(pos.onPickSpriteName && [pos.onPickSpriteName isEqualToString:@"vanish"]) {
                            difficultySprite.visible = NO;
                            CCAction *intervalPause = [CCDelayTime actionWithDuration:1.0];
                            CCAction *visibleAction = [CCCallBlock actionWithBlock:^{
                                difficultySprite.visible = YES;
                            }];
                            CCSequence *moveSeq = [CCSequence actionWithArray:@[intervalPause, visibleAction]];
                            [difficultySprite runAction:moveSeq];
                        }
                        if (pos.progressEffect > 0) {
                            if (self.effectAudio == YES) {
                                [[SimpleAudioEngine sharedEngine] playEffect:@"OneBubble.caf"];
                            }
                        } else {
                            if (self.effectAudio == YES) {
                                [[SimpleAudioEngine sharedEngine] playEffect:@"wrong.caf"];
                            }
                        }
                    }
                    self.currentDifficulty = nil;
                    break;
                }
            }
        }
    }
    
}

#if KK_PLATFORM_IOS
#pragma mark - GKPeerPickerControllerDelegate

- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type {
    if(type == GKPeerPickerConnectionTypeOnline) {
        [picker dismiss];
        // Display your own user interface here.
    }
}

#endif

@end
