/*
 NSString+RegularChecker.m
 
 Copyright (c) 2012 Truong Vinh Tran
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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
    
    //check wether string is same as before the transformation
    if ([[self stringCleanerWithWhiteList:expressions] isEqualToString:self]) {
        return YES;
    }else{
	    //string is not valid. it contains other characters
        return NO;
    }
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
    
	//string with all valid characters
    NSString *inputCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 äöüÄÖÜß*-_\"";
    
	//check every character for the validation
    for (int i=0; i<inputCharacters.length; i++) {
        NSString * character = [inputCharacters substringWithRange:NSMakeRange(i, 1)];
        [list addObject:character];
    }
    return list;
}

@end