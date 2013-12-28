//
//  HighscoreClient.h
//  Meteors
//
//  Created by Olle Lind on 25/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighscoreClient : NSObject

+(HighscoreClient *)sharedClient;

-(int)writeToLocalHighscore:(int)score;
-(NSArray *)readLocalHighscores;

@end
