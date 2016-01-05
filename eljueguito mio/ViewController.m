//
//  ViewController.m
//  eljueguito mio
//
//  Created by mac on 30/05/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"
#import "Menu.h"
#import "GCHelper.h"
#import "GADRequest.h"

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _adsenabled = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showAd" object:nil];


    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;

    // Create and configure the scene.
    menu * scene = [menu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    self.adBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    _adBanner.delegate = self;
    
    self.adBanner.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.adBanner.frame = CGRectMake(0, 0 - _adBanner.frame.size.height, _adBanner.frame.size.width, _adBanner.frame.size.height);
    self.adBanner.rootViewController = (id)self;
    
    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [self.adBanner loadRequest:request];
    
    // Present the scene.
    [skView presentScene:scene];
    
    [[GCHelper sharedInstance]authenticateLocalPlayer:self];

}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)adViewDidReceiveAd:(GADBannerView *)view
{
    if (_adsenabled == true)
    {
        
    
    view.frame = CGRectMake(0, 0 - view.frame.size.height, view.frame.size.width, view.frame.size.height);
    [self.view addSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(0,0, view.frame.size.width, view.frame.size.height);
        }
                     completion:nil];
    }
}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [self.adBanner loadRequest:request];
}

- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"hideAd"])
    {
        [UIView animateWithDuration:0.5 animations:^{
            _adBanner.frame = CGRectMake(0, 0 - _adBanner.frame.size.height, _adBanner.frame.size.width, _adBanner.frame.size.height);
        }
                         completion:nil];
        [_adBanner removeFromSuperview];
        
        _adsenabled = false;
    }else if ([notification.name isEqualToString:@"showAd"])
    {
        GADRequest *request = [GADRequest request];
        // Enable test ads on simulators.
        request.testDevices = @[ GAD_SIMULATOR_ID ];
        [self.adBanner loadRequest:request];
        _adsenabled = true;

    }
}

@end
