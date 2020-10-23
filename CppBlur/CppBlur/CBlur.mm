//
//  CBlur.m
//  CppBlur
//
//  Created by Andrew Romanov on 23.10.2020.
//

#import "CBlur.h"


using namespace cpp_blur;

template <class T> inline T clamp(T val, T minVal, T maxVal)  {
    T result = std::max(std::min(val, maxVal), minVal);
    return result;
}

@interface CBlur () {
    Bitmap _source;
}
@property (nonatomic) NSInteger radius;

@end


@implementation CBlur

- (instancetype)initWithBitmap:(const cpp_blur::Bitmap&)source radius:(NSInteger)radius {
    if (self = [super init]) {
        _source = source;
        self.radius = radius;
    }

    return self;
}


- (cpp_blur::Bitmap)blur {
    Bitmap result(_source);
    auto indexes = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, _source.size())];
    int minIndex = 0;
    int maxIndex = static_cast<int>(result.size()) - 1;
    [indexes enumerateIndexesWithOptions:NSEnumerationConcurrent
                              usingBlock:[&](NSUInteger idx, BOOL* _Nonnull stop){
        double sum = 0.0;
        for (int i = static_cast<int>(idx) - static_cast<int>(self.radius); i <= idx + self.radius; i++) {
            int index = clamp(i, minIndex, maxIndex);
            sum += self->_source.at(index);
        }
        sum /= static_cast<double>(self.radius * 2 + 1);
        result.at(idx) = sum;
    }];

    return result;
}

@end
