//
//  GetMoneyFromBankVC.m
//  红包Demo
//
//  Created by xiaerfei on 15/8/24.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "GetMoneyFromBankVC.h"
#import "GetMoneyFromBankCell.h"
#import "UIViewExt.h"



@interface GetMoneyFromBankVC ()<UITableViewDataSource,UITableViewDelegate,GetMoneyFromBankCellDelegate>
- (IBAction)tapGestureAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GetMoneyFromBankVC
{
    NSMutableDictionary *_paramsDict;
    UITextField *_currentSelectTextField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData
{
    _paramsDict = [[NSMutableDictionary alloc] init];
    self.tapGesture.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)configUI
{
    self.title = @"提现";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1];
    UIView *tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 60)];
    //    tableViewFooterView.backgroundColor = [UIColor grayColor];
    self.tableView.tableFooterView = tableViewFooterView;
    
    UIButton *inputRedPaperBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [inputRedPaperBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [inputRedPaperBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]
    [inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]];
    inputRedPaperBtn.enabled = YES;
    inputRedPaperBtn.frame = CGRectMake(50, 20, [UIScreen mainScreen].bounds.size.width - 100, 40);
    inputRedPaperBtn.layer.masksToBounds = YES;
    inputRedPaperBtn.layer.cornerRadius = 5;
    [inputRedPaperBtn addTarget:self action:@selector(putInToRedPaper) forControlEvents:UIControlEventTouchUpInside];
    [tableViewFooterView addSubview:inputRedPaperBtn];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetMoneyFromBankCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankOverage];
            break;
        case 1:
            cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankType];
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankUserName];
            } else if (indexPath.row == 1) {
                cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankNum];
            } else {
                cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankName];
            }
        }
            break;
        case 3:
            cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankMoney];
            break;
        case 4:
            cell = [self tableView:tableView reuseIdentifier:kGetMoneyFromBankRemark];
            break;
        default:
            break;
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 4) {
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-10, 20)];
        label.text = @"提现金额不得少于：500.00元";
        label.font = [UIFont systemFontOfSize:12];
        label.attributedText = [self textLabelColor:label.text leftPosition:9 rightPosition:label.text.length - 9 color:[UIColor colorWithRed:240.0f/255.0f green:200.0f/255.0f blue:56.0f/255.0f alpha:1] font:[UIFont systemFontOfSize:12]];
        [view addSubview:label];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark GetMoneyFromBankCellDelegate
- (void)currentBeginClickTextFild:(UITextField *)textField reuseIdentifier:(NSString *)reuseIdentifier
{
    self.tapGesture.enabled = YES;
    _currentSelectTextField = textField;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    BOOL isIPone5 = NO;
    BOOL isIPone6 = NO;
    if (screenHeight > 480 && screenHeight < 570) {
        isIPone5 = YES;
    } else if (screenHeight > 580) {
        isIPone6 = YES;
    }
    
    if ([reuseIdentifier isEqualToString:kGetMoneyFromBankUserName] && (isIPone5 == NO) && (isIPone6 == NO)) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = -20;
        }];
    } else if ([reuseIdentifier isEqualToString: kGetMoneyFromBankNum] && (isIPone5 == NO) && (isIPone6 == NO)) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = -60;
        }];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankName] && (isIPone6 == NO)) {
        CGFloat height = 0;
        if (isIPone5) {
            height = -40;
        } else {
            height = -130;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = height;
        }];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankMoney] && isIPone6 == NO) {
        CGFloat height = 0;
        if (isIPone5) {
            height = -100;
        } else {
            height = -190;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = height;
        }];
    } else if ([reuseIdentifier isEqualToString:kGetMoneyFromBankRemark]) {
        CGFloat height = 0;
        if (isIPone5) {
            height = -160;
        } else if (isIPone6) {
            height = -75;
        } else {
            height = -250;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = height;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = 0;
        }];
    }
}

- (void)currentEndClickTextFild:(UITextField *)textField reuseIdentifier:(NSString *)reuseIdentifier
{
    _paramsDict[reuseIdentifier] = textField.text;
    NSLog(@"%@",_paramsDict);
}

#pragma mark - event response
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.top = 0;
    }];
}
- (IBAction)tapGestureAction:(id)sender {
    self.tapGesture.enabled = NO;
    [_currentSelectTextField resignFirstResponder];
}
/**
 *   @author xiaerfei, 15-08-24 11:08:08
 *
 *   申请提现
 */
- (void)putInToRedPaper
{
    /*
     NSString *const kGetMoneyFromBankOverage  = @"GetMoneyFromBankOverage";
     NSString *const kGetMoneyFromBankType     = @"GetMoneyFromBankType";
     NSString *const kGetMoneyFromBankUserName = @"GetMoneyFromBankUserName";
     NSString *const kGetMoneyFromBankName     = @"GetMoneyFromBankName";
     NSString *const kGetMoneyFromBankNum      = @"GetMoneyFromBankNum";
     NSString *const kGetMoneyFromBankMoney    = @"GetMoneyFromBankMoney";
     NSString *const kGetMoneyFromBankRemark   = @"GetMoneyFromBankRemark";
     */
    NSString *tipsStr = nil;
    if ([_paramsDict[kGetMoneyFromBankUserName] length] == 0) {
        tipsStr = @"您没有填写用户名";
    } else if ([_paramsDict[kGetMoneyFromBankNum] length] == 0) {
        tipsStr = @"您没有填写银行卡卡号";
    } else if ([_paramsDict[kGetMoneyFromBankName] length] == 0) {
        tipsStr = @"您没有填写开户行全称";
    } else if ([_paramsDict[kGetMoneyFromBankMoney] length] == 0) {
        tipsStr = @"您没有填写提现金额";
    }
    if (tipsStr != nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:tipsStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    // 判断提现金额
    CGFloat money = [_paramsDict[kGetMoneyFromBankMoney] floatValue];
    
    if (money < 500) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提现金额少于500元" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    
    NSString *temp = [NSString stringWithFormat:@"请确认提现到银行卡：\n%@",[self cardSeperationOfspace:_paramsDict[kGetMoneyFromBankNum]]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:temp delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}
#pragma mark - private methods

- (GetMoneyFromBankCell *)tableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    GetMoneyFromBankCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GetMoneyFromBankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (NSMutableAttributedString*)textLabelColor:(NSString*)str leftPosition:(NSInteger)leftPos rightPosition:(NSInteger)rightPos color:(UIColor*)color font:(UIFont*)font
{
    
    NSMutableAttributedString *labelStr= [[NSMutableAttributedString alloc] initWithString:str];
    [labelStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(leftPos,rightPos)];
    [labelStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(leftPos, rightPos)];
    return labelStr;
}

- (NSString *)cardSeperationOfspace:(NSString *)card
{
    NSMutableString *str = [[NSMutableString alloc] init];
    NSRange rang;
    for (int i = 0; i < card.length-4; i += 4) {
        rang.location = i;
        rang.length = 4;
        [str appendString:[NSString stringWithFormat:@"%@ ",[card substringWithRange:rang]]];
    }
    [str appendString:[NSString stringWithFormat:@"%@ ",[card substringWithRange:NSMakeRange(card.length- 3,3)]]];
    return str;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

@end
