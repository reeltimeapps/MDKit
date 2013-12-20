//
//  Base64.h
//  MDKit
//
//  Created by Matthew Dicembrino on 2012-08-17.
//
//

#import <Foundation/Foundation.h>

@interface MDBase64 : NSObject

+ (NSString*)base64forData:(NSData*)theData;

@end
