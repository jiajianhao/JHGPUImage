//
//  GroupViewController.m
//  JHGPUImage
//
//  Created by admin on 2017/3/10.
//  Copyright © 2017年 jiajianhao. All rights reserved.
//

#import "GroupViewController3.h"

@interface GroupViewController3 (){
    UIImage *_inputImage;
    UIImage *_outputImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic,strong) GPUImagePicture        *picture;
@property (nonatomic,strong) GPUImageView           *imageView;
@property (nonatomic,strong) GPUImageFilterGroup    *filterGroup;
@end

@implementation GroupViewController3

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // 图片输入源
    _inputImage = [UIImage imageNamed:@"28_02.jpg"];
    
    // 初始化 picture
    _picture    = [[GPUImagePicture alloc] initWithImage:_inputImage smoothlyScaleOutput:YES];
    
    // 初始化 imageView
    _imageView  = [[GPUImageView alloc] initWithFrame:self.iconImageView.bounds];
    [self.iconImageView addSubview:_imageView];
    
    // 初始化 filterGroup
    _filterGroup = [[GPUImageFilterGroup alloc] init];
    [_picture addTarget:_filterGroup];
    
    
    // 添加 filter
    /**
     原理：
     1. filterGroup(addFilter) 滤镜组添加每个滤镜
     2. 按添加顺序（可自行调整）前一个filter(addTarget) 添加后一个filter
     3. filterGroup.initialFilters = @[第一个filter]];
     4. filterGroup.terminalFilter = 最后一个filter;
     
     */
    GPUImageBilateralFilter *filter1         = [[GPUImageBilateralFilter alloc] init];//磨皮
    GPUImageBrightnessFilter *filter2        = [[GPUImageBrightnessFilter alloc] init];
//    GPUImageColorInvertFilter *filter3 = [[GPUImageColorInvertFilter alloc] init];
//    GPUImageSepiaFilter       *filter4 = [[GPUImageSepiaFilter alloc] init];
    [self addGPUImageFilter:filter1];
    [self addGPUImageFilter:filter2];
//    [self addGPUImageFilter:filter3];
//    [self addGPUImageFilter:filter4];
    
    // 处理图片
    [_picture processImage];
    [_filterGroup useNextFrameForImageCapture];
    
    self.iconImageView.image = [_filterGroup imageFromCurrentFramebuffer];
    
}

- (void)addGPUImageFilter:(GPUImageOutput<GPUImageInput> *)filter
{
    [_filterGroup addFilter:filter];
    
    GPUImageOutput<GPUImageInput> *newTerminalFilter = filter;
    
    NSInteger count = _filterGroup.filterCount;
    
    if (count == 1)
    {
        _filterGroup.initialFilters = @[newTerminalFilter];
        _filterGroup.terminalFilter = newTerminalFilter;
        
    } else
    {
        GPUImageOutput<GPUImageInput> *terminalFilter    = _filterGroup.terminalFilter;
        NSArray *initialFilters                          = _filterGroup.initialFilters;
        
        [terminalFilter addTarget:newTerminalFilter];
        
        _filterGroup.initialFilters = @[initialFilters[0]];
        _filterGroup.terminalFilter = newTerminalFilter;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
