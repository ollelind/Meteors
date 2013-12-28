//
//  Highscore.h
//  Meteors
//
//  Created by Olle Lind on 26/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Highscore : NSObject

@property (nonatomic) int score;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) int localID;

-(id)initWithLocalRecord:(NSString *)record;
-(NSString *)getRecordString;

@end
