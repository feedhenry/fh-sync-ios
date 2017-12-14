//
//  Definitions.h
//  fh-ios-sdk
//
//  Created by Wojciech Trocki on 12/14/17.
//  Copyright © 2017 FeedHenry. All rights reserved.
//

#ifndef Definitions_h
#define Definitions_h

#define SDK_VERSION @"1.0.0"

// cater for debug/release mode of logging
#ifdef DEBUG
#define DLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...) /* */
#endif

#endif /* Definitions_h */
