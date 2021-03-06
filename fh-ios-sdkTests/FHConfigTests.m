/*
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "FHConfig.h"
#import <OCMock/OCMock.h>
#import "FHDataManager.h"
#import <XCTest/XCTest.h>

@interface FHConfigTests : XCTestCase
@end

@implementation FHConfigTests {
    SEL _configSelector, _initWithNameSelector;
}

- (void) setUp {
    [super setUp];
    _configSelector = NSSelectorFromString(@"config");
    _initWithNameSelector = NSSelectorFromString(@"initWithFileName:");
    // Set-up code here.
}

- (void) tearDown {
    // Tear-down code here.

    [super tearDown];
}

- (void) testReadConfig {
    // given
    
    // when default config file
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    
    // then
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"host"], @"http://testing.feedhenry.com");
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"appid"], @"APP_ID");
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"appkey"], @"APP_KEY");
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"projectid"], @"PROJECT_ID");
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"connectiontag"], @"CONNECTION_TAG");
    XCTAssertEqualObjects([fhconfig getConfigValueForKey:@"mode"], @"dev");
    XCTAssertNil([fhconfig getConfigValueForKey:@"invalidkey"]);

}

- (void) testConfigFileNotFound {
    // given
    
    // when default config file
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];

    // then
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    XCTAssertThrowsSpecificNamed([fhconfig performSelector:_initWithNameSelector withObject:@"invalidName"], NSException, @"fhconfigException");
    #pragma clang diagnostic pop
}

-(void) testGetValueExisting {
    // given
    FHConfig *fhconfig = [FHConfig getSharedInstance];
    
    // when
    NSString* appId = [fhconfig getConfigValueForKey:@"appid"];
    
    // then
    XCTAssertEqualObjects(appId, @"APP_ID");
}

-(void) testGetValueEmpty {
    // given
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    [fhconfig performSelector:@selector(setConfigValue:ForKey:) withObject:@"" withObject:@"appid"];
    
    // when
    NSString* appId = [fhconfig getConfigValueForKey:@"appid"];
    
    // then
    XCTAssertTrue(appId == nil);
}

-(void) testGetValuefilledWithSpaces {
    // given
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    [fhconfig performSelector:@selector(setConfigValue:ForKey:) withObject:@"   " withObject:@"appid"];
    
    // when
    NSString* appId = [fhconfig getConfigValueForKey:@"appid"];
    
    // then
    XCTAssertTrue(appId == nil);
}

-(void) testGetValuefilledNSNull {
    // given
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    [fhconfig performSelector:@selector(setConfigValue:ForKey:) withObject:[NSNull null] withObject:@"appid"];
    
    // when
    NSString* appId = [fhconfig getConfigValueForKey:@"appid"];
    
    // then
    XCTAssertTrue(appId == nil);
}

-(void) testUuidAlreadyExistingInDB {
    // given
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    id mock = OCMClassMock([FHDataManager class]);
    
    // when
    OCMStub([mock read:@"FHUUID"]).andReturn(@"ABCD");
    NSString* uuid = [fhconfig uuid];
    
    // then assert, verify
    XCTAssertEqualObjects(uuid, @"ABCD");
    OCMVerify([mock read:@"FHUUID"]);
}

-(void) testNewUuid {
    // given
    FHConfig *fhconfig = [FHConfig performSelector:_configSelector];
    id mock = OCMClassMock([FHDataManager class]);
    
    // when
    OCMStub([mock read:@"FHUUID"]).andReturn(nil);
    NSString* uuid = [fhconfig uuid];
    
    // then assert, verify
    XCTAssertNotNil(uuid);
    OCMVerify([mock save:@"FHUUID" withObject:[OCMArg any]]);
}

@end
