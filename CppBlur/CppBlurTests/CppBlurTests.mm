//
//  CppBlurTests.m
//  CppBlurTests
//
//  Created by Andrew Romanov on 23.10.2020.
//

#import <XCTest/XCTest.h>
#import <GameKit/GameKit.h>
#import "CBlur.h"

@interface CppBlurTests : XCTestCase

@property (nonatomic) cpp_blur::Bitmap source;

@end

@implementation CppBlurTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    size_t count = 10000;
    _source = cpp_blur::Bitmap();
    _source.reserve(count);
    auto random = [[GKRandomDistribution alloc] initWithRandomSource:[[GKRandomSource alloc] init] lowestValue:0 highestValue:count-1];
    auto inserter = std::back_inserter(_source);
    for (auto i = 0; i < count; i++) {
        inserter = random.nextUniform;
    }
}



- (void)testPerformanceExample {
    auto blur = [[CBlur alloc] initWithBitmap:_source radius:10];
    auto random = [[GKRandomDistribution alloc] initWithRandomSource:[[GKRandomSource alloc] init] lowestValue:0 highestValue: _source.size() - 1];
    [self measureBlock:^{
        cpp_blur::Bitmap result = [blur blur];
        auto randValue = [random nextInt];
        auto value = result.at(randValue);
    }];
}

@end
