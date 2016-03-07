// RouteParser.m
//
// Created by Carlo Carraro on 27/01/13.
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

#import "RouteParser.h"
#import "Route.h"
#import "Difficulty.h"
#import "Position.h"

static Route *currentRoute;
static Difficulty *currentDifficulty;
static Position *currentPosition;

@implementation RouteParser

- (Route*)routeFromURL:(NSURL*)url {
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    nsXmlParser.delegate = self;
    currentRoute = [[Route alloc] init];
    BOOL success = [nsXmlParser parse];
    if (success == YES) {
        return currentRoute;
    } else {
        NSLog(@"Error parsing document!");
        return nil;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"par"]) {
        NSString *parName = [attributeDict valueForKey:@"name"];
        if ([parName isEqualToString:@"RACE_LENGTH"]) {
            currentRoute.raceLength = [[attributeDict valueForKey:@"value"] integerValue];
        } else if ([parName isEqualToString:@"NUM_DIFFICULTIES"]) {
            currentRoute.numDifficulties = [[attributeDict valueForKey:@"value"] integerValue];
        } else if ([parName isEqualToString:@"NUM_LETTERS"]) {
            currentRoute.numLetters = [[attributeDict valueForKey:@"value"] integerValue];
        }
    }
    if ([elementName isEqualToString:@"difficulty"]) {
        currentDifficulty = [[Difficulty alloc] init];
        currentDifficulty.type = [[attributeDict valueForKey:@"type"] integerValue];
        currentDifficulty.distance = [[attributeDict valueForKey:@"distance"] integerValue];
        [currentRoute.difficulties addObject:currentDifficulty];
    }
    if ([elementName isEqualToString:@"cue"]) {
        currentDifficulty.cuePresent = YES;
        currentDifficulty.cuePos = [[attributeDict valueForKey:@"pos"] integerValue];
        currentDifficulty.group = [attributeDict valueForKey:@"group"];
        currentDifficulty.letter = [attributeDict valueForKey:@"letter"];
        currentDifficulty.place = [[attributeDict valueForKey:@"place"] integerValue];
    }
    if ([elementName isEqualToString:@"position"]) {
        currentPosition = [[Position alloc] init];
        currentPosition.number = [[attributeDict valueForKey:@"number"] integerValue];
        NSString *effectValue = [attributeDict valueForKey:@"effect"];
        if (effectValue && effectValue.length > 2) {
            NSArray *components = [effectValue componentsSeparatedByString:@","];
            for (NSString *component in components) {
                if ([[component substringToIndex:1] isEqualToString:@"v"]) {
                    currentPosition.speedEffect = [[component substringFromIndex:1] integerValue];
                } else if ([[component substringToIndex:1] isEqualToString:@"p"]) {
                    currentPosition.progressEffect = [[component substringFromIndex:1] integerValue];
                }
            }
        }
        currentPosition.spriteName = [attributeDict valueForKey:@"img"];
        currentPosition.type = [attributeDict valueForKey:@"type"];
        currentPosition.onPickSpriteName = [attributeDict valueForKey:@"onPick"];
        [currentDifficulty.positions addObject:currentPosition];
    }
}

@end
