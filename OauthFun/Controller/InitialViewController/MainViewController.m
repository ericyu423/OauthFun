//
//  MainViewController.m
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"
#import "MainTableViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewUserButtonTitle;
@end

@implementation MainViewController

- (IBAction)viewUserButtonClicked:(UIButton *)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"token"] == nil) {
        WebViewController *webVC = [[WebViewController alloc] init];
        [self presentViewController:webVC animated:true completion:nil];
    }else{
        [self performSegueWithIdentifier:@"MainViewToMainTable" sender:self];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //shrink and hide button
    [self.viewUserButtonTitle setHidden:true];
    [self.viewUserButtonTitle setTransform:CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5)];
   
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"token"] == nil) {
        [self.viewUserButtonTitle setTitle:@"Please Login" forState: UIControlStateNormal];
    }else{
        [self.viewUserButtonTitle setTitle:@"User Search" forState: UIControlStateNormal];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.titleLabel setTransform:CGAffineTransformMakeTranslation(0,-200)];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.viewUserButtonTitle
                          duration:0.3f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            
                            //make button appear and enlarge to orginal size
                            [self.viewUserButtonTitle setHidden:false];
                            [self.viewUserButtonTitle setTransform:CGAffineTransformScale(CGAffineTransformIdentity,1.5, 1.5)];
                        } completion:^(BOOL finished){}
         ];
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

}



@end
