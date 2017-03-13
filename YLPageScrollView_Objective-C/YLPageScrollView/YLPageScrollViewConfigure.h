//
//  YLPageScrollViewConfigure.h
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/13.
//  Copyright © 2017年 YL. All rights reserved.
//

#ifndef YLPageScrollViewConfigure_h
#define YLPageScrollViewConfigure_h


#define YLPageScrollViewSW \
        ([UIScreen mainScreen].bounds.size.width)
#define YLPageScrollViewSH \
        ([UIScreen mainScreen].bounds.size.height)


#define YLPageScrollViewRGBA(r, g, b, a) \
        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define YLPageScrollViewRGB(r, g, b)\
        YLPageScrollViewRGBA(r, g, b, 1.0)

#define YLPageScrollViewRandomColor \
        YLPageScrollViewRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#endif /* YLPageScrollViewConfigure_h */
