// GameLayer.h
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

#import "cocos2d.h"

@class Route;
@class Difficulty;

@interface GameLayer: CCLayer  {
	//NSString* helloWorldString;
	//NSString* helloWorldFontName;
	//int helloWorldFontSize;
    
    BOOL pause;
    BOOL schedule;
    double totTime;
    double currentDistance;
    double totDistance;
    double totEnemyDistance;
    CGFloat speed;
    CGFloat enemySpeed;
}

//@property (nonatomic, copy) NSString* helloWorldString;
//@property (nonatomic, copy) NSString* helloWorldFontName;
//@property (nonatomic) int helloWorldFontSize;

//@property (nonatomic, assign) BOOL pause;
//@property (nonatomic, assign) CGFloat currentDistance;
//@property (nonatomic, assign) CGFloat totDistance;
//@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat maxTime;
//@property (nonatomic, assign) CGFloat totTime;
@property (nonatomic, assign) CGFloat minSpeed;
@property (nonatomic, assign) CGFloat maxSpeed;
@property (nonatomic, assign) NSUInteger currentLevel;
@property (nonatomic, strong) Route *currentRoute;
@property (nonatomic, strong) Difficulty *currentDifficulty;
@property (nonatomic, strong) CCAction *fishAnimation;
@property (nonatomic, strong) NSDictionary *comicsNameTag;
@property (nonatomic, strong) NSDictionary *comicsGroupNameTag;

@property (nonatomic) BOOL bgAudio;
@property (nonatomic) BOOL effectAudio;

#if KK_PLATFORM_IOS
@property (nonatomic, strong) GKPeerPickerController *peerPickerController;
#endif

- (void)resume;
- (void)nextLevel;
- (void)replayLevel;

@end
