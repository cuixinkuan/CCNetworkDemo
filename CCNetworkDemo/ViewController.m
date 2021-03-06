//
//  ViewController.m
//  CCNetworkDemo
//
//  Created by admin on 2018/1/11.
//  Copyright © 2018年 cuixinkuan. All rights reserved.
//

#import "ViewController.h"
#import "GetImageApi.h"
#import "GetUserInfoApi.h"
#import "RegisterApi.h"
#import "CCBatchRequest.h"
#import "CCChainRequest.h"
#import "CCBaseRequest+AnimatingAccessory.h"

@interface ViewController () <CCChainRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Request Test";
    self.view.backgroundColor = [UIColor brownColor];
    
    UILabel * testlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    testlabel.text = @"CCNetwork";
    testlabel.textAlignment = NSTextAlignmentCenter;
    testlabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [self.view addSubview:testlabel];
    
    UIButton * reqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reqBtn.backgroundColor = [UIColor redColor];
    reqBtn.frame = CGRectMake(testlabel.center.x - 60, testlabel.center.y + 200, 120, 35);
    [reqBtn setTitle:@"发请求" forState:UIControlStateNormal];
    [reqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reqBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [reqBtn addTarget:self action:@selector(reqBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reqBtn];
}

- (void)loginBtnClick:(id)sender {
    RegisterApi * api = [[RegisterApi alloc] initWithUsername:@"username**" password:@"password**"];
    [api startWithCompletionBlockWithSuccess:^(__kindof CCBaseRequest * _Nonnull request) {
       // 你可以直接在这里使用self
    } failure:^(__kindof CCBaseRequest * _Nonnull request) {
        // 你可以直接在这里使用self
    }];
}

- (void)reqBtnClick:(UIButton *)sender {
    [self loadCacheData];
//    [self sendBatchRequest];
//    [self sendChainRequest];
}

- (void)loadCacheData {
//    NSString * userId = @"54534534";
//    GetUserInfoApi * api = [[GetUserInfoApi alloc] initWithUserId:userId];
//    if ([api loadCacheWithError:nil]) {
//        NSDictionary * json = [api responseJSONObject];
//        // show failed cached data
//        NSLog(@"-------> json = %@",json);
//    }
    
    // 传参
    NSString * startKey = @"username";
    NSString * endKey = @"password";
    NSString * starDateStr = @"13120829059";
    NSString * endDateStr = @"123456";
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:startKey forKey:@"startkey"];
    [para setObject:starDateStr forKey:@"startvalue"];
    [para setObject:endKey forKey:@"endkey"];
    [para setObject:endDateStr forKey:@"endvalue"];
    
    GetUserInfoApi * api = [[GetUserInfoApi alloc] initWithParameters:para];
    api.animatingView = self.view;
    api.animatingText = @"正在加载...";
    [api startWithCompletionBlockWithSuccess:^(__kindof CCBaseRequest * _Nonnull request) {
        
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请求成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           // cancel...
        }];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // sure...
            NSLog(@"-------> update UI !!!");
            NSDictionary * parameters = request.responseJSONObject;
            NSLog(@"------->Json:%@",parameters);
        }];
        [alertVc addAction:cancelAction];
        [alertVc addAction:sureAction];
        [self presentViewController:alertVc animated:YES completion:^{
           //
        }];
    } failure:^(__kindof CCBaseRequest * _Nonnull request) {
        NSLog(@"-------> request failed...");
        NSLog(@"------->Error:%@",request.error.description);
    }];
    
}

// send batch request
- (void)sendBatchRequest {
    GetImageApi * a = [[GetImageApi alloc] initWithImageId:@"1.jpg"];
    GetImageApi * b = [[GetImageApi alloc] initWithImageId:@"2.jpg"];
    GetImageApi * c = [[GetImageApi alloc] initWithImageId:@"3.jpg"];
    GetUserInfoApi * d = [[GetUserInfoApi alloc] initWithUserId:@"123"];
    CCBatchRequest * batchRequest = [[CCBatchRequest alloc] initWithRequestArray:@[a,b,c,d]];
    [batchRequest startWithCompletionBlockWithSuccess:^(CCBatchRequest * _Nonnull batchRequest) {
        NSLog(@"--------> Sucess");
        NSArray * requests = batchRequest.requestArray;
        GetImageApi * a = (GetImageApi *)requests[0];
        //....
        NSLog(@"--------> %@",a);
        // deal with requests result ...
    } failure:^(CCBatchRequest * _Nonnull batchRequest) {
        NSLog(@"--------> Failed");
    }];
}

// send chain request
- (void)sendChainRequest {
    RegisterApi * reg = [[RegisterApi alloc] initWithUsername:@"username" password:@"password"];
    CCChainRequest * chainReq = [[CCChainRequest alloc] init];
    [chainReq addRequest:reg callback:^(CCChainRequest * _Nonnull chainRequest, CCBaseRequest * _Nonnull baseRequest) {
        RegisterApi * result = (RegisterApi *)baseRequest;
        NSString * userId = [result userId];
        GetUserInfoApi * api = [[GetUserInfoApi alloc] initWithUserId:userId];
        [chainRequest addRequest:api callback:nil];
    }];
    chainReq.delegate = self;
    // start to send request
    [chainReq start];
}

#pragma  mark - CCChainRequestDelegate -
- (void)chainRequestFinished:(CCChainRequest *)chainRequest {
    // all request are done
    NSLog(@"--------> all request are done");
}

- (void)chainRequestFailed:(CCChainRequest *)chainRequest failedBaseRequest:(CCBaseRequest *)request {
    // some one of request is failed
    NSLog(@"--------> some one of request is failed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
