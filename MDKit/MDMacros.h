//
//  MDMacros.h
//  MDKit
//
//  Created by Matthew Dicembrino on 11/23/13.
//  Copyright (c) 2013 Reel Time Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NULL_NIL(_O)                    _O != [NSNull null] ? _O : nil
#define NSNULL_IF_NIL(_O)               _O != nil ? _O : [NSNull null]
#define DICT_GET(_DICT, _KEY)           NULL_NIL([_DICT objectForKey:_KEY])
#define DICT_GET_INT(_DICT, _KEY)       [DICT_GET(_DICT, _KEY) intValue]
#define DICT_GET_INTEGER(_DICT, _KEY)   [DICT_GET(_DICT, _KEY) integerValue]
#define DICT_GET_FLOAT(_DICT, _KEY)     [DICT_GET(_DICT, _KEY) floatValue]

@interface MDMacros : NSObject

@end
