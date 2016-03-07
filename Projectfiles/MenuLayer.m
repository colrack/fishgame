// MenuLayer.m
//
// Created by Carlo Carraro on 01/02/13.
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

#import "MenuLayer.h"
#import "GameLayer.h"

@implementation MenuLayer

- (id)initWithColor:(ccColor4B)color {
    if ((self = [super initWithColor:color])) {
        CCDirector *director = [CCDirector sharedDirector];
        CGSize screenSize = [director winSize];
        CCMenuItemFont* resume = [CCMenuItemFont itemWithString:@"Riprendi" block:^(id sender) {
            CCNode* scene = (CCNode*)self.parent;
            GameLayer* gl = (GameLayer*)[scene getChildByTag:1];
            
            NSLog(@"scene: %@", scene);
            NSLog(@"gl: %@", gl);
            
            [scene removeChild:self cleanup:YES];
            
            [gl resume];
        }];
        resume.contentSize = CGSizeMake(100, 100);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger bgAudioOn = [[defaults valueForKey:@"bgAudio"] integerValue];
        NSInteger effectOn = [[defaults valueForKey:@"effectAudio"] integerValue];
        
        CCMenuItemFont* toggleBgAudioOff = [CCMenuItemFont itemWithString:@"Musiche: NO"];
        CCMenuItemFont* toggleBgAudioOn = [CCMenuItemFont itemWithString:@"Musiche: SI"];
        NSArray* bgAudioItems = [NSArray arrayWithObjects:toggleBgAudioOff, toggleBgAudioOn, nil];
        CCMenuItemToggle* bgAudio = [CCMenuItemToggle itemWithItems:bgAudioItems block:^(id sender) {
            CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
            NSInteger index = toggleItem.selectedIndex;
            NSLog(@"index %i", index);
            [defaults setObject:[NSNumber numberWithInteger:index] forKey:@"bgAudio"];
            
            CCNode* scene = (CCNode*)self.parent;
            GameLayer* gl = (GameLayer*)[scene getChildByTag:1];
            if (index == 1)
                gl.bgAudio = YES;
            else gl.bgAudio = NO;
        }];
        bgAudio.selectedIndex = bgAudioOn;
        
        CCMenuItemFont* toggleEffectAudioOff = [CCMenuItemFont itemWithString:@"Effetti: NO"];
        CCMenuItemFont* toggleEffectAudioOn = [CCMenuItemFont itemWithString:@"Effetti: SI"];
        NSArray* effectAudioItems = [NSArray arrayWithObjects:toggleEffectAudioOff, toggleEffectAudioOn, nil];
        CCMenuItemToggle* effectAudio = [CCMenuItemToggle itemWithItems:effectAudioItems block:^(id sender) {
            CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
            NSInteger index = toggleItem.selectedIndex;
            [defaults setObject:[NSNumber numberWithInteger:index] forKey:@"effectAudio"];
            
            CCNode* scene = (CCNode*)self.parent;
            GameLayer* gl = (GameLayer*)[scene getChildByTag:1];
            if (index == 1)
                gl.effectAudio = YES;
            else gl.effectAudio = NO;
        }];
        effectAudio.selectedIndex = effectOn;
        
        CCMenu* menu = [CCMenu menuWithItems:resume, bgAudio, effectAudio, nil];
        menu.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        [self addChild:menu];
        [menu alignItemsVerticallyWithPadding:40];
    }
    return self;
}

@end
