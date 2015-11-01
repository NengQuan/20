//
//  MySeeBigViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MySeeBigViewController.h"
#import "UIImageView+WebCache.h"
#import "MyTopics.h"
#import "SVProgressHUD.h"
#import "UIView+Extension.h"

@interface MySeeBigViewController () <UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollview;

@property (nonatomic,weak) UIImageView *bigview;
@end

@implementation MySeeBigViewController
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.bigview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.frame = MyScreen;
    [self.view insertSubview:scrollview atIndex:0];
    scrollview.delegate = self;
    self.scrollview = scrollview;
    
    UIImageView *imageview = [[UIImageView alloc]init];
    [imageview sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage]];
    self.bigview = imageview;
    [self.scrollview addSubview:imageview];
    
    imageview.width = scrollview.width;
    imageview.x = 0;
    imageview.height = imageview.width * self.topic.height / self.topic.width;
    if (self.topic.height >= scrollview.height) {
        imageview.y = 0;
        
    } else {
        imageview.centerY = scrollview.height / 2;
    }
    
    // 设置scrollview的滚动范围
    scrollview.contentSize = CGSizeMake(scrollview.width,imageview.height);
    
    // 设置缩放比例
    CGFloat maxscale = self.topic.height / self.bigview.height;
    if (maxscale > 1.0) {
        scrollview.maximumZoomScale = maxscale;
    }

}

#pragma mark - UIScrollviewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.bigview;
}



@end
