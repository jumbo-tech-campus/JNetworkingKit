#import "FirstViewController.h"
#import "DemoApp-Swift.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imageUrl = @"https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Jumbo_Logo.svg/1280px-Jumbo_Logo.svg.png";

    [ImageOperation getImageWithUrl:imageUrl onSuccess:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Fetched image!");

            [self.imageView setImage:image];
        });

    } onError:^(NSError *error) {
        NSLog(@"Error fetching image: %@", error.localizedDescription);
    }];
}

@end
