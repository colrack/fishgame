// EndLevelLayer.m
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

#import "EndLevelLayer.h"
#import "GameLayer.h"

@implementation EndLevelLayer

- (void)levelEndWithVictory:(BOOL)victory {
    CCDirector *director = [CCDirector sharedDirector];
    CGSize screenSize = [director winSize];
    CGPoint position = CGPointMake(screenSize.width/2.0f, screenSize.height/2.0f);
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    CCMenuItemFont* replay = [CCMenuItemFont itemWithString:@"Rigioca" block:^(id sender) {
        CCNode* scene = (CCNode*)self.parent;
        GameLayer* gl = (GameLayer*)[scene getChildByTag:1];
        [gl replayLevel];
        [scene removeChild:self cleanup:YES];
    }];
    
    if (victory == YES) {
        CCMenuItemFont* nextLevel = [CCMenuItemFont itemWithString:@"Livello successivo" block:^(id sender) {
            CCNode* scene = (CCNode*)self.parent;
            GameLayer* gl = (GameLayer*)[scene getChildByTag:1];
            [gl nextLevel];
            [scene removeChild:self cleanup:YES];
        }];
        CCMenu* menu = [CCMenu menuWithItems:replay, nextLevel, nil];
        menu.position = CGPointMake(screenSize.width/2, screenSize.height/2 - 200);
        [self addChild:menu];
        [menu alignItemsVerticallyWithPadding:40];
        
        NSString *spriteNameWonNemo = @"wonNemo.png";
        CCSpriteFrame *wonFrame = [frameCache spriteFrameByName:spriteNameWonNemo];
        CCSprite *wonSprite = [[CCSprite alloc] initWithSpriteFrame:wonFrame];
        [self addChild:wonSprite];
        
        wonSprite.position = position;
    } else {
        CCMenu* menu = [CCMenu menuWithItems:replay, nil];
        menu.position = CGPointMake(screenSize.width/2, screenSize.height/2 - 200);
        [self addChild:menu];
        [menu alignItemsVerticallyWithPadding:40];
        
        NSString *spriteNameLostNemo = @"lostNemo.png";
        CCSpriteFrame *lostFrame = [frameCache spriteFrameByName:spriteNameLostNemo];
        CCSprite *lostSprite = [[CCSprite alloc] initWithSpriteFrame:lostFrame];
        [self addChild:lostSprite];
        
        lostSprite.position = position;
    }
}

@end
