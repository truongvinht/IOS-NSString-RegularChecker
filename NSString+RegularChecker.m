//
//  NSString+RegularChecker.m
//  RegularChecker
//
//  Created by Vinh Tran on 27.11.12.
//  Copyright (c) 2012 Vinh Tran. All rights reserved.
//

#import "NSString+RegularChecker.h"

@implementation NSString (RegularChecker)




- (BOOL)isValidExpressionFormat:(NSArray*)expressions{
    
    if (!expressions) {
        //is invalid because no expressions
        return NO;
    }
    
    if ([expressions count]>self.length) {
        //still invalid because the number of expression is shorter than the length of the string
        return NO;
    }
    
#warning implementation incomplete
    
    return NO;
}

- (NSString*)stringCleanerWithWhiteList:(NSArray*)expressions{
    
    //expression is nil -> return nil as well, because there is no matching
    if (!expressions||[expressions count]==0) {
        return nil;
    }
    
    //create a tmp arra for invalid characters
    NSMutableArray *invalidOccuringCharacters = [NSMutableArray new];
    
    for (int i=0; i<self.length; i++) {
        
        //get single character for comparing
        NSString * character = [self substringWithRange:NSMakeRange(i, 1)];
        
        BOOL hasCharacter = NO;
        
        //look for the current character in the array
        for (int j=0; j<expressions.count; j++) {
            if ([character isEqualToString:[expressions objectAtIndex:j]] ) {
                hasCharacter = YES;
                break;
            }
        }
        
        //add the invalid character
        if (!hasCharacter) {
            [invalidOccuringCharacters addObject:character];
        }
        
    }
    
    NSString *copyOfCurrentString = [self copy];
    
    //replace all invalid characters
    for (NSString *invalidChar in invalidOccuringCharacters) {
        copyOfCurrentString = [copyOfCurrentString stringByReplacingOccurrencesOfString:invalidChar withString:@""];
    }
    
    //replace all * with .*
    copyOfCurrentString = [copyOfCurrentString stringByReplacingOccurrencesOfString:@"*" withString:@".*"];
    
    return copyOfCurrentString;
}

#pragma mark - Helper Method

+ (NSArray*) getAllDigitsAndLetters{
    NSMutableArray *list = [NSMutableArray new];
    
    NSString *inputCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 äöüÄÖÜß*";
    
    for (int i=0; i<inputCharacters.length; i++) {
        NSString * character = [inputCharacters substringWithRange:NSMakeRange(i, 1)];
        [list addObject:character];
    }
    return list;
}

@end
