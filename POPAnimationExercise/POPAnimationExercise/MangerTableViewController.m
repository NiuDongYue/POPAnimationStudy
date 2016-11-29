
#import "MangerTableViewController.h"
#import "RETableViewManager.h"
#import "POP.h"

@interface MangerTableViewController ()

@property(strong, nonatomic) RETableViewManager *manager;

@end

@implementation MangerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    self.manager.delegate = self;

    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    [section addItem:[RETableViewItem itemWithTitle:@"移动动画" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];

        [self.view addSubview:imageView];

        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.duration = 3;
        positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-100, 80)];
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 80)];
        positionAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            [imageView removeFromSuperview];
        };
        [imageView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
        
    }]];

    [section addItem:[RETableViewItem itemWithTitle:@"震荡动画" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];
        imageView.center = CGPointMake(100, 100);
        [self.view addSubview:imageView];
        
        POPBasicAnimation *positionYAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        positionYAnimation.duration = 0.5;
        positionYAnimation.toValue = @(imageView.frame.size.height / 2 - 10);
        /*************震荡几次结束***************/
//        positionYAnimation.repeatCount = 10;
        //这个属性是一直震荡
        positionYAnimation.repeatForever = YES;
        positionYAnimation.autoreverses = YES;
        positionYAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [imageView removeFromSuperview];
            });
        };
        [imageView.layer pop_addAnimation:positionYAnimation forKey:@"positionYAnimation"];
    }]];

    [section addItem:[RETableViewItem itemWithTitle:@"渐隐渐现动画" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];
        imageView.center = CGPointMake(100, 100);
        [self.view addSubview:imageView];
        
        POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        opacityAnimation.duration = 3;
        opacityAnimation.fromValue = @(0);
        opacityAnimation.toValue = @(1);
        opacityAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            POPBasicAnimation *opacityAnimation_0 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            opacityAnimation_0.duration = 3;
            opacityAnimation_0.beginTime = 3;
            opacityAnimation_0.fromValue = @(1);
            opacityAnimation_0.toValue = @(0);
            opacityAnimation_0.completionBlock = ^(POPAnimation *animation, BOOL finished) {
                [imageView removeFromSuperview];
            };
            [imageView.layer pop_addAnimation:opacityAnimation_0 forKey:@"opacityAnimation_0"];
        };
        [imageView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"变大动画" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];
        imageView.center = CGPointMake(100, 100);
        [self.view addSubview:imageView];
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.duration = 3;
        scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
        scaleAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            [imageView removeFromSuperview];
        };
        [imageView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"转圈动画" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];
        imageView.center = CGPointMake(100, 100);
        [self.view addSubview:imageView];
        
        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        rotationAnimation.duration = 3;
        rotationAnimation.toValue = @(2 * M_PI);
        rotationAnimation.repeatForever = YES;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [imageView removeFromSuperview];
        });
        [imageView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
