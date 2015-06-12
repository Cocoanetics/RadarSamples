//
//  ModalTransitionManager.m
//  TransitionTest
//
//  Created by Oliver Drobnik on 26/01/15.
//  Copyright (c) 2015 Product Layer. All rights reserved.
//

#import "ModalTransitionManager.h"

@interface ModalTransitionManager () <UIViewControllerAnimatedTransitioning>  // handles the transition internally

@end

@implementation ModalTransitionManager
{
	UIView *_dimView;
	UIPercentDrivenInteractiveTransition *_pinchHandler;
	UIViewController *_dismissableViewController;
	
	UIPinchGestureRecognizer *_pinchGesture;
	
	BOOL _runsForward;
	BOOL _isInteractive;
}

- (instancetype)init
{
	self = [super init];
	
	if (self)
	{
	}
	
	return self;
}

- (void)dealloc
{
	if (_pinchGesture.view)
	{
		[_pinchGesture.view removeGestureRecognizer:_pinchGesture];
	}
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 0.33;
}

- (void)_animateForwardTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	if (!_dimView)
	{
		_dimView = [[UIView alloc] initWithFrame:CGRectZero];
		_dimView.backgroundColor = [UIColor blackColor];
	}
	
	// get the involved VCs
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	toVC.modalPresentationStyle = UIModalPresentationCustom;
	toVC.modalPresentationCapturesStatusBarAppearance = YES;
	
	CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
	CGRect targetRect = [transitionContext finalFrameForViewController:toVC];
	
	fromVC.view.frame = sourceRect;
	UIView *container = [transitionContext containerView];
	
	[container addSubview:_dimView];
	_dimView.frame = targetRect;
	_dimView.alpha = 0;
	
	[container addSubview:toVC.view];
	
	if (CGRectEqualToRect(targetRect, CGRectZero))
	{
		toVC.view.frame = targetRect;
	}
	
	toVC.view.transform = CGAffineTransformMakeScale(1, 0);
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  animations:^{
							  fromVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
							  toVC.view.transform = CGAffineTransformIdentity;
							  _dimView.alpha = 1.0;
							  [fromVC setNeedsStatusBarAppearanceUpdate];
							  [toVC setNeedsStatusBarAppearanceUpdate];

						  } completion:^(BOOL finished) {
							  
							  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
							  
							  // remember which VC is the one to dismiss
							 _dismissableViewController = toVC;
							  
							  [toVC.view addGestureRecognizer:self.pinchGesture];
						  }];
}

- (void)_animateBackwardTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	// get the involved VCs
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
	CGRect targetRect = [transitionContext finalFrameForViewController:toVC];
	

	fromVC.view.frame = sourceRect;
	
	UIView *container = [transitionContext containerView];
	[container insertSubview:toVC.view belowSubview:fromVC.view];
	
	[container insertSubview:_dimView belowSubview:fromVC.view];
	_dimView.frame = targetRect;
	_dimView.alpha = 1;

	if (CGRectEqualToRect(targetRect, CGRectZero))
	{
		toVC.view.frame = targetRect;
	}
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  animations:^{
							  toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
							  _dimView.alpha = 0;
							  fromVC.view.transform = CGAffineTransformMakeScale(1, 0.001);
							  [fromVC setNeedsStatusBarAppearanceUpdate];
							  [toVC setNeedsStatusBarAppearanceUpdate];

						  } completion:^(BOOL finished) {
							  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
						  }];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	if (_runsForward)
	{
		[self _animateForwardTransition:transitionContext];
	}
	else
	{
		[self _animateBackwardTransition:transitionContext];
	}
}

- (void)animationEnded:(BOOL)transitionCompleted
{
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
	_runsForward = YES;
	return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	_runsForward = NO;
	return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
	// presentation is never interactive
	return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
	if (_isInteractive)
	{
		if (!_pinchHandler)
		{
			_pinchHandler = [UIPercentDrivenInteractiveTransition new];
		}
		return _pinchHandler;
	}
	
	// vending an interaction controller causes hanging if not interactive
	return nil;
}

#pragma mark - Interactive Pinch

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch
{
	switch (pinch.state)
	{
		case UIGestureRecognizerStateBegan:
		{
			_isInteractive = YES;
			[_dismissableViewController dismissViewControllerAnimated:YES completion:NULL];
			break;
		}
			
		case UIGestureRecognizerStateChanged:
		{
			CGFloat percent = MAX(0, 1.0 - MIN(1.0, pinch.scale));
			NSLog(@"Percent: %0.2f", percent);
			[_pinchHandler updateInteractiveTransition:percent];
			break;
		}
			
		case UIGestureRecognizerStateEnded:
		{
			CGFloat percent = (1.0 - MIN(1.0, pinch.scale));
			BOOL cancelled = ([pinch velocity] < 5.0 && percent <= 0.3);
			[self end:cancelled];
			break;
		}
			
		case UIGestureRecognizerStateCancelled:
		{
			CGFloat percent = (1.0 - pinch.scale);
			BOOL cancelled = ([pinch velocity] < 5.0 && percent <= 0.3);
			[self end:cancelled];
			break;
		}
			
		case UIGestureRecognizerStatePossible:
			break;
		case UIGestureRecognizerStateFailed:
			break;
	}
}

-(void)end:(BOOL)cancelled
{
	_isInteractive = NO;
	
	if (cancelled)
	{
		[_pinchHandler cancelInteractiveTransition];
	}
	else
	{
		[_pinchHandler finishInteractiveTransition];
	}
}

- (UIPinchGestureRecognizer *)pinchGesture
{
	if (!_pinchGesture)
	{
		_pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
	}
	
	return _pinchGesture;
}


@end
