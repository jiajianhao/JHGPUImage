//
//  ViewController.m
//  JHGPUImage
//
//  Created by admin on 2017/3/10.
//  Copyright © 2017年 jiajianhao. All rights reserved.
//

#import "ViewController.h"
#import "GroupViewController.h"
#import "GroupViewController2.h"
#import "BlendViewController.h"
#import "GroupViewController3.h"
#import "BeautifyFilterViewController.h"
#import "GPUImageFilterViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTableView;
    NSMutableArray *arrayForTypes;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent=NO;
    
    arrayForTypes = [[NSMutableArray alloc]initWithObjects:@"GroupViewController",@"GroupViewController2",@"BlendViewController",@"GroupViewController3",@"BeautifyFilterViewController",@"GPUImageFilterViewController",nil];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mWidth, mHeight) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setSectionIndexColor:UIColorFromRGB(0xFF5000)];
    [myTableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:myTableView];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return arrayForTypes;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayForTypes count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [arrayForTypes objectAtIndex:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier= @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    //自适应图片（大小）
    cell.textLabel.text = [arrayForTypes objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"heart.png"];
    cell.detailTextLabel.text = [arrayForTypes objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
//        [self nslockDemo];
        GroupViewController *view1 =[[GroupViewController alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];
    }
    if(indexPath.row==1){
//        [self synchronizeDemo];
        GroupViewController2 *view1 =[[GroupViewController2 alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];

    }
    if(indexPath.row==2){
//        [self gcdDemo];
        
        BlendViewController *view1 =[[BlendViewController alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];
    }
    if(indexPath.row==3){
//        [self pthreadDemo];
        GroupViewController3 *view1 =[[GroupViewController3 alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];
    }
    if(indexPath.row==4){
        //        [self pthreadDemo];
        BeautifyFilterViewController *view1 =[[BeautifyFilterViewController alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];
    }
    if(indexPath.row==5){
        //        [self pthreadDemo];
        GPUImageFilterViewController *view1 =[[GPUImageFilterViewController alloc]init];
        [self.navigationController pushViewController:view1 animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
