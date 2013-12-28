//
//  Highscore.m
//  Meteors
//
//  Created by Olle Lind on 26/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "Highscore.h"

@implementation Highscore

-(id)initWithLocalRecord:(NSString *)record{
    self = [self init];
    if(self){
        NSArray *parameters = [record componentsSeparatedByString:@":"];
        self.localID = [parameters[0] intValue];
        self.name = parameters[1];
        self.score = [parameters[2] intValue];
    }
    return self;
}
-(NSString *)getRecordString{
    return [NSString stringWithFormat:@"%d:%@:%d", self.localID, self.name, self.score];
}

@end
