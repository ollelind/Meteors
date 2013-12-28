//
//  HighscoreClient.m
//  Meteors
//
//  Created by Olle Lind on 25/12/13.
//  Copyright (c) 2013 Olle Lind. All rights reserved.
//

#import "HighscoreClient.h"

#define NUMBER_OF_LOCAL_HIGHSCORES 10

@implementation HighscoreClient{
    NSString *_localHighscorePath;
}

static HighscoreClient *_sharedClient = nil;

+(HighscoreClient *)sharedClient{
    static dispatch_once_t onceToken;
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HighscoreClient allocWithZone:nil] init];
    });
    
    return _sharedClient;
}

-(id)init{
    self = [super init];
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if(paths.count > 0){
            _localHighscorePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"local_highscore"];
        }
    }
    return self;
}

-(int)writeToLocalHighscore:(int)score{
    return 0;
    
    
    // Get the local highscores and make sure they are sorted
    NSArray *currentHighscores = [self readLocalHighscores];
    NSArray *sortedArray = [currentHighscores sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *firstScore = (NSString *)obj1;
        NSString *secondScore = (NSString *)obj2;
        return firstScore.intValue < secondScore.intValue;
    }];
    NSMutableArray *list = [NSMutableArray arrayWithArray:sortedArray];
    // Check if the new score belongs on the highscore
    /*int addedIndex = -1;
    for(int i=list.count; i > 0; i--){
        NSString *string = [list objectAtIndex:i];
        int tempScore = string.intValue;
        if(score > tempScore){
            [list insertObject:[NSString stringWithFormat:@"%d", score] atIndex:i];
            addedIndex = i;
            break;
        }
    }
    
    }*/
    NSArray *limitedAmountOfHighscoresArray = [sortedArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(NUMBER_OF_LOCAL_HIGHSCORES, sortedArray.count))]];
    [limitedAmountOfHighscoresArray writeToFile:_localHighscorePath atomically:YES];
}

-(NSArray *)readLocalHighscores{
    NSArray *arrayFromFile = [NSArray arrayWithContentsOfFile:_localHighscorePath];
    return (arrayFromFile != nil) ? arrayFromFile : [NSArray array];
}
@end
