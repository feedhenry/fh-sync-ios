//  Created by Wojciech Trocki on 12/14/17.
//  Copyright © 2017 FeedHenry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHResponse.h"

@interface NetworkHandler: NSObject
    /**
        @param funcName The cloud side function name
        @param arguments The parameters for the cloud side functions
        @param sucornil Block to be executed if the execution of the cloud side function
        is successful
        @param failornil Block to be executed if the execution of the cloud side
        function is failed
    */
    - (void)performActRequest:(NSString *)funcName
                     WithArgs:(NSDictionary *)arguments
                   AndSuccess:(void (^)(FHResponse *success))sucornil
                   AndFailure:(void (^)(FHResponse *failed))failornil;

@end
