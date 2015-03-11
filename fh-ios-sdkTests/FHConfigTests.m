//
//  FHTests.m
//  FHTests
//
//  Created by Wei Li on 08/08/2012.
//  Copyright (c) 2012 FeedHenry. All rights reserved.
//

#import "FHConfigTests.h"
#import "FHConfig.h"

@implementation FHConfigTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testReadConfig
{
  FHConfig* fhconfig = [FHConfig getSharedInstance];
  NSLog(@"%@", [fhconfig getConfigValueForKey:@"host"]);
  NSLog(@"%@", [fhconfig getConfigValueForKey:@"appid"]);
  XCTAssertTrue([[fhconfig getConfigValueForKey:@"host"] isEqualToString: @"http://testing.feedhenry.com"] , @"");
  XCTAssertTrue([[fhconfig getConfigValueForKey:@"appid"] isEqualToString:@"testappid"], @"");
  XCTAssertNil([fhconfig getConfigValueForKey:@"invalidkey"], @"");
}

@end
