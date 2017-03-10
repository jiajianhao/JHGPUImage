//
//  GroupViewController2.m
//  JHGPUImage
//
//  Created by admin on 2017/3/10.
//  Copyright © 2017年 jiajianhao. All rights reserved.
//

#import "GroupViewController2.h"

@interface GroupViewController2 ()
@property (nonatomic,strong) GPUImageVideoCamera    *videoCamera;
@property (nonatomic,strong) GPUImageView           *filterImageView;
@property (nonatomic,strong) GPUImageFilterGroup    *filterGroup;
@end

@implementation GroupViewController2


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    // 初始化 videoCamera
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation              = UIInterfaceOrientationPortrait;
    _videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    _videoCamera.horizontallyMirrorRearFacingCamera  = NO;
    
    // 初始化 filterGroup
    _filterGroup = [[GPUImageFilterGroup alloc] init];
    [_videoCamera addTarget:_filterGroup];
    
    // 添加 filter
    /**
     原理：
     1. filterGroup(addFilter) 滤镜组添加每个滤镜
     2. 按添加顺序（可自行调整）前一个filter(addTarget) 添加后一个filter
     3. filterGroup.initialFilters = @[第一个filter]];
     4. filterGroup.terminalFilter = 最后一个filter;
     
     */
//    GPUImageRGBFilter *filter1         = [[GPUImageRGBFilter alloc] init];
//    GPUImageToonFilter *filter2        = [[GPUImageToonFilter alloc] init];
//    GPUImageSepiaFilter *filter3       = [[GPUImageSepiaFilter alloc] init];
//    GPUImageColorInvertFilter *filter4 = [[GPUImageColorInvertFilter alloc] init];
//    [self addGPUImageFilter:filter1];
//    [self addGPUImageFilter:filter2];
//    [self addGPUImageFilter:filter3];
//    [self addGPUImageFilter:filter4];
    GPUImageBilateralFilter *filter1         = [[GPUImageBilateralFilter alloc] init];//磨皮
    GPUImageBrightnessFilter *filter2        = [[GPUImageBrightnessFilter alloc] init];
    //    GPUImageColorInvertFilter *filter3 = [[GPUImageColorInvertFilter alloc] init];
    //    GPUImageSepiaFilter       *filter4 = [[GPUImageSepiaFilter alloc] init];
    [self addGPUImageFilter:filter1];
    [self addGPUImageFilter:filter2];
    //    [self addGPUImageFilter:filter3];
    //    [self addGPUImageFilter:filter4];
    
    // 初始化 imageView
    _filterImageView  = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_filterImageView];
    [_filterGroup addTarget:_filterImageView];
    
    
    [_videoCamera startCameraCapture];
    
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

@end
