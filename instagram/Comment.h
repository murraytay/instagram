//
//  Comment.h
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"
@interface Comment : NSObject
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *createdAt;

+(Comment *)initWithText:(NSString *)myString;
@end
