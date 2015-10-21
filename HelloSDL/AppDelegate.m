//
//  AppDelegate.m
//  HelloSDL
//
//  Created by James Sokoll on 10/7/15.
//  Copyright © 2015 Ford Motor Company. All rights reserved.
//

#import "AppDelegate.h"
#import "HSDLHMIManager.h"
#import "HSDLVehicleDataManager.h"
#import "SDLManager.h"

#warning TODO : Replace these constants with your app's name, assigned ID, and company logo
static NSString *const appName = @"HelloSDL";
static NSString *const appId = @"8675309";
static NSString *const companyLogo = @"Ford_logo_no_background.png";

@interface AppDelegate ()

@property UIViewController *lockScreenViewController;
@property UIViewController *mainViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *lockVC = [storyBoard instantiateViewControllerWithIdentifier:@"LockScreenViewController"];

    [self setLockScreenViewController:lockVC];
    [self setMainViewController:[[self window] rootViewController]];

    // Start the proxy with default configuration

    SDLManager *proxyManager = [SDLManager sharedManager];
    HSDLHMIManager *hmiManager = nil;
    HSDLVehicleDataManager *vdManager = nil;

    SDLLifecycleConfiguration *appConfig = [SDLLifecycleConfiguration defaultConfigurationWithAppName:appName appId:appId];
    SDLLockScreenConfiguration *lockScreenConfig = [SDLLockScreenConfiguration enabledConfigurationWithBackgroundColor:[UIColor blackColor] appIcon:[UIImage imageNamed:companyLogo]];
    SDLConfiguration *appAndLSConfig = [SDLConfiguration configurationWithLifecycle:appConfig lockScreen:lockScreenConfig];

    [proxyManager startProxyWithConfiguration:appAndLSConfig];
    hmiManager = [HSDLHMIManager sharedManager];
    vdManager = [HSDLVehicleDataManager sharedManager];

    // Register for notifications
    [self registerForSDLNotifications];

    return YES;
}


#pragma mark Default methods

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark Notification callbacks

- (void)registerForSDLNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center addObserver:self selector:@selector(didChangeLockScreenStatus:) name:SDLDidChangeLockScreenStatusNotification object:nil];
    [center addObserver:self selector:@selector(didDisconnect:) name:SDLDidDisconnectNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveFirstFullHMIStatus:) name:SDLDidReceiveFirstFullHMIStatusNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveFirstNonNoneHMIStatus:) name:SDLDidReceiveFirstNonNoneHMIStatusNotification object:nil];
    [center addObserver:self selector:@selector(didChangeDriverDistractionState:) name:SDLDidChangeDriverDistractionStateNotification object:nil];
    [center addObserver:self selector:@selector(didChangeHMIStatus:) name:SDLDidChangeHMIStatusNotification object:nil];
    [center addObserver:self selector:@selector(didConnect:) name:SDLDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(didRegister:) name:SDLDidRegisterNotification object:nil];
    [center addObserver:self selector:@selector(didFailToRegister:) name:SDLDidFailToRegisterNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveError:) name:SDLDidReceiveErrorNotification object:nil];
    [center addObserver:self selector:@selector(didUnregister:) name:SDLDidUnregisterNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveAudioPassThru:) name:SDLDidReceiveAudioPassThruNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveButtonEvent:) name:SDLDidReceiveButtonEventNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveButtonPress:) name:SDLDidReceiveButtonPressNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveCommand:) name:SDLDidReceiveCommandNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveEncodedData:) name:SDLDidReceiveEncodedDataNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveNewHash:) name:SDLDidReceiveNewHashNotification object:nil];
    [center addObserver:self selector:@selector(didChangeLanguage:) name:SDLDidChangeLanguageNotification object:nil];
    [center addObserver:self selector:@selector(didChangePermissions:) name:SDLDidChangePermissionsNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveData:) name:SDLDidReceiveDataNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveSystemRequest:) name:SDLDidReceiveSystemRequestNotification object:nil];
    [center addObserver:self selector:@selector(didChangeTurnByTurnState:) name:SDLDidChangeTurnByTurnStateNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveTouchEvent:) name:SDLDidReceiveTouchEventNotification object:nil];
    [center addObserver:self selector:@selector(didReceiveVehicleData:) name:SDLDidReceiveTouchEventNotification object:nil];
}

- (void)didChangeLockScreenStatus:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangeLockScreenStatus notification from SDL: %@", notification);
}

- (void)didDisconnect:(NSNotification *)notification {
    NSLog(@"AppDelegate didDisconnect notification from SDL: %@", notification);
}

- (void)didReceiveFirstFullHMIStatus:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveFirstFullHMIStatus notification from SDL: %@", notification);
}

- (void)didReceiveFirstNonNoneHMIStatus:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveFirstNonNoneHMIStatus notification from SDL: %@", notification);
}

- (void)didChangeDriverDistractionState:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangeDriverDistractionState notification from SDL: %@", notification);
}

- (void)didChangeHMIStatus:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangeHMIStatus notification from SDL: %@", notification);
}

- (void)didConnect:(NSNotification *)notification {
    NSLog(@"AppDelegate didConnect notification from SDL: %@", notification);
}

- (void)didRegister:(NSNotification *)notification {
    NSLog(@"AppDelegate didRegister notification from SDL: %@", notification);
}

- (void)didFailToRegister:(NSNotification *)notification {
    NSLog(@"AppDelegate didFailToRegister notification from SDL: %@", notification);
}

- (void)didReceiveError:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveError notification from SDL: %@", notification);
}

- (void)didUnregister:(NSNotification *)notification {
    NSLog(@"AppDelegate didUnregister notification from SDL: %@", notification);
}

- (void)didReceiveAudioPassThru:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveAudioPassThru notification from SDL: %@", notification);
}

- (void)didReceiveButtonEvent:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveButtonEvent notification from SDL: %@", notification);
}

- (void)didReceiveButtonPress:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveButtonPress notification from SDL: %@", notification);
}

- (void)didReceiveCommand:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveCommand notification from SDL: %@", notification);
}

- (void)didReceiveEncodedData:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveEncodedData notification from SDL: %@", notification);
}

- (void)didReceiveNewHash:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveNewHash notification from SDL: %@", notification);
}

- (void)didChangeLanguage:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangeLanguage notification from SDL: %@", notification);
}

- (void)didChangePermissions:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangePermissions notification from SDL: %@", notification);
}

- (void)didReceiveData:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveData notification from SDL: %@", notification);
}

- (void)didReceiveSystemRequest:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveSystemRequest notification from SDL: %@", notification);
}

- (void)didChangeTurnByTurnState:(NSNotification *)notification {
    NSLog(@"AppDelegate didChangeTurnByTurnState notification from SDL: %@", notification);
}

- (void)didReceiveTouchEvent:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveTouchEvent notification from SDL: %@", notification);
}

- (void)didReceiveVehicleData:(NSNotification *)notification {
    NSLog(@"AppDelegate didReceiveVehicleData notification from SDL: %@", notification);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
