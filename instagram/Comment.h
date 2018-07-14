//
//  Comment.h
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"
@interface Comment : PFObject<PFSubclassing>
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonnull) PFFile *file;

+(Comment *)initWithText:(NSString *)myString andPostCaption:(NSString *)caption;
@end
