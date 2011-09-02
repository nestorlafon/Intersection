#import "IntersecViewController.h"
#import "MovableView.h"

@implementation IntersecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *frameView = [[[UIView alloc] initWithFrame:CGRectMake(312, 234, 400, 300 )] autorelease];
    frameView.backgroundColor = [UIColor whiteColor];
    frameView.clipsToBounds = YES;
    [self.view addSubview:frameView];
    MovableView *innerView = [[[MovableView alloc] initWithFrame:CGRectMake(100, 75, 200, 150)] autorelease];
    innerView.backgroundColor = [UIColor redColor];
    [frameView addSubview:innerView];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
