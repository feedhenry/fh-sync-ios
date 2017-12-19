//  Created by Wojciech Trocki on 12/14/17.
//  Copyright © 2017 FeedHenry. All rights reserved.
//

#import "NetworkHandler.h"
#import "FHResponse.h"

@implementation NetworkHandler
    - (void)performActRequest:(NSString *)funcName
                     WithArgs:(NSDictionary *)arguments
                   AndSuccess:(void (^)(FHResponse *success))sucornil
                   AndFailure:(void (^)(FHResponse *failed))failornil {
        
    }
@end
