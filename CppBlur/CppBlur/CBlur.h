//
//  CBlur.h
//  CppBlur
//
//  Created by Andrew Romanov on 23.10.2020.
//

#import <Foundation/Foundation.h>
#import <vector>

NS_ASSUME_NONNULL_BEGIN

namespace cpp_blur {
typedef std::vector<double> Bitmap;
}

@interface CBlur : NSObject

- (instancetype)initWithBitmap:(const cpp_blur::Bitmap&)source radius:(NSInteger)radius;
- (cpp_blur::Bitmap)blur;

@end

NS_ASSUME_NONNULL_END
