//
//  NSString+RegularChecker.h
//  RegularChecker
//
//  Created by Vinh Tran on 27.11.12.
//  Copyright (c) 2012 Vinh Tran. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (RegularChecker)

/** Method to check wether the String only contains given expressions (e.g. @"abc" -> "abbac":valid, "abcd":invalid )
 
 *  @param expressions is an array with single characters (e.g. 'a', '1', '?'...)
 *  @return YES - if the String
 */
- (BOOL)isValidExpressionFormat:(NSArray*)expressions;

/** Method to remove all characters which are not on white list
 
 @param expressions is an array with single characters
 @see isValidExpressionFormat:
 @return new string with allowed characters
 */
- (NSString*)stringCleanerWithWhiteList:(NSArray*)expressions;

/** Helper method to access to all digits and letters
 
 @return an array with all digits/letters
 */
+ (NSArray*) getAllDigitsAndLetters;


@end
