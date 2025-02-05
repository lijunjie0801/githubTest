//
//  ResetPassWordController.m
//  IOSFramework
//
//  Created by xu on 16/3/19.
//
//

#import "ResetPassWordController.h"
#import "Check.h"

@interface ResetPassWordController ()

@end

@implementation ResetPassWordController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f7f1ee"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.title = @"找回密码";
    [self setBackPasswordUI];
}
#pragma 找回密码界面
-(void)setBackPasswordUI{
    UIView *phoneView = [[UIView alloc]init];
    [phoneView autoSetDimensionsToSize:CGSizeMake(0, 50)];
    [phoneView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:phoneView];
    [phoneView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [phoneView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [phoneView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    /*手机号*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"密码";
    nameLabel.font = [UIFont systemFontOfSize:16];
    [phoneView addSubview:nameLabel];
    [nameLabel autoSetDimensionsToSize:CGSizeMake(65, 50)];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    
    /*姓名输入框*/
    UITextField *nameField = [[UITextField alloc]init];
    nameField.secureTextEntry = YES;
    [nameField setBackgroundColor:[UIColor whiteColor]];
    self.nameField = nameField;
    [phoneView addSubview:nameField];
    [nameField autoSetDimensionsToSize:CGSizeMake(0, 40)];
    [nameField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [nameField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [nameField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    
    UIView *passWordView = [[UIView alloc]init];
    [passWordView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    [passWordView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:passWordView];
    [passWordView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [passWordView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [passWordView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:71];
    
    /*确认密码*/
    UILabel *changPassword = [[UILabel alloc]init];
    changPassword.text = @"确认密码";
    changPassword.font = [UIFont systemFontOfSize:16];
    [passWordView addSubview:changPassword];
    [changPassword autoSetDimensionsToSize:CGSizeMake(65, 50)];
    [changPassword autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [changPassword autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    
    /*确认密码输入框*/
    UITextField *passWordField = [[UITextField alloc]init];
    passWordField.secureTextEntry = YES;
    [passWordField setBackgroundColor:[UIColor whiteColor]];
    passWordField.placeholder = @"请填写密码";
    self.passwordField = passWordField;
    [passWordView addSubview:passWordField];
    [passWordField autoSetDimensionsToSize:CGSizeMake(0, 40)];
    [passWordField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [passWordField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [passWordField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    
    /*下一步按钮*/
    UIButton *nextBtn = [[UIButton alloc]init];
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor colorWithHexString:@"ed6d2a"]];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    [nextBtn autoSetDimensionsToSize:CGSizeMake(0, 40)];
    [nextBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [nextBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [nextBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:passWordField withOffset:20];
    
}
#pragma 下一步
-(void)nextBtnClick{
    BOOL isPassWord = [Check checkIsDLU:self.passwordField.text];
    if (!isPassWord) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码需要包含字母、数字、下划线,至少六位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:sureAction];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
    }
    if (![self.nameField.text isEqualToString:self.passwordField.text]){
        showAlert(@"两次密码输入不同！");
        return;
    }
    NSDictionary *dic = @{@"channelType":@"01",
                          @"requestService":@"modifyPassword",
                          @"requestObject":@{
                                  @"mobile":self.phoneNumber,
                                  @"newpassword":self.passwordField.text,
                                  @"validateObject":@{
                                          @"operateType":@"2",
                                          @"operateCode":self.phoneNumber,
                                          @"mobile":self.phoneNumber,
                                          @"verificationCode":self.verificationCode,
                                          }}};
//    [[CY_NetAPIManager sharedManager] request_getchangePassWord:dic andBlock:^(id data, NSError *error) {
//        NSDictionary *dic = data[@"responseObject"];
//        NSString *firstMessage = data[@"resultMessage"];
//        NSString *firstCode = data[@"resultCode"];
//        NSString *resultCode = dic[@"resultCode"];
//        NSString *resultMessage = dic[@"resultMessage"];
//        if ([firstCode isEqualToString:@"0"]) {
//            if ([resultCode  isEqualToString:@"0"]) {
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//            else{
//                showAlert(resultMessage);
//                return;
//            }
//        }else
//        {
//            showAlert(firstMessage);
//            return;
//        }
//    }];
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
        //        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
        _backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
        [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
