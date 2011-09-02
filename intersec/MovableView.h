//
//  MovableView.h
//  intersec
//
//  Created by Nestor on 02/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MovableView : UIView <UIGestureRecognizerDelegate>{
    CGFloat lastRotation;
    CGFloat firstX;
	CGFloat firstY;
    CGFloat lastScale;
}
@end
