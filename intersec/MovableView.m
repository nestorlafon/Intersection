//
//  MovableView.m
//  intersec
//
//  Created by Nestor on 02/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovableView.h"

#define INSET 50

@implementation MovableView

-(BOOL) validInset {
    
    CGRect outerLimit = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    CGRect intersectionRect = CGRectIntersection(self.frame, outerLimit);
    NSLog(@"self.frame:%f,%f,%f,%f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    NSLog(@"outer.frame:%f,%f,%f,%f", outerLimit.origin.x, outerLimit.origin.y, outerLimit.size.width, outerLimit.size.height);
    NSLog(@"intersec.frame:%f,%f,%f,%f", intersectionRect.origin.x, intersectionRect.origin.y, intersectionRect.size.width, intersectionRect.size.height);
    NSLog(@"========================");
    if ( CGRectIsNull(intersectionRect) ||
         intersectionRect.size.width < INSET ||
         intersectionRect.size.height < INSET ) {
        return NO;
    }
    else {
        return YES;
    }
}

-(void)rotate:(id)sender {
	if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
		lastRotation = 0.0;
		return;
	}
    
	CGFloat rotation = 0.0 - (lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
	[[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
    
    if (![self validInset]){
        [[(UIRotationGestureRecognizer*)sender view] setTransform:currentTransform];
    }
    
	lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}

-(void)move:(id)sender {
    
    if([(UITapGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
		firstX = 0.0;
        firstY = 0.0;
		return;
	}
    
    CGPoint translation = [(UIPanGestureRecognizer*)sender translationInView:self];
    
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformTranslate(currentTransform, -(firstX - translation.x), -(firstY - translation.y));
    
    [[(UITapGestureRecognizer*)sender view] setTransform:newTransform];
    
    //Undo if inset is not valid after transform
    if (![self validInset]) {
        [[(UITapGestureRecognizer*)sender view] setTransform:currentTransform];
    }
    
    firstX = translation.x;
    firstY = translation.y;
}

-(void)scale:(id)sender {
	if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
		lastScale = 1.0;
		return;
	}
    
	CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
	[[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];
    
    if (![self validInset]) {
        [[(UIPinchGestureRecognizer*)sender view] setTransform:currentTransform];
    }
    
	lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIRotationGestureRecognizer *rotationRecognizer = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)] autorelease];
        [rotationRecognizer setDelegate:self];
        [self addGestureRecognizer:rotationRecognizer];
        
        UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)] autorelease];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [panRecognizer setDelegate:self];
        [self addGestureRecognizer:panRecognizer];
        
        UIPinchGestureRecognizer *pinchRecognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)] autorelease];
        [pinchRecognizer setDelegate:self];
        [self addGestureRecognizer:pinchRecognizer];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
