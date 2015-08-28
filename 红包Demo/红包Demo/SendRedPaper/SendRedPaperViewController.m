//
//  SendRedPaperViewController.m
//  RongYu100
//
//  Created by xiaerfei on 15/8/21.
//  Copyright (c) 2015年 ___RongYu100___. All rights reserved.
//

#import "SendRedPaperViewController.h"
#import "SendRedPaperCell.h"
#import "UIViewExt.h"
#import "SendReadyRedPaper.h"
#import "SendRedPaperSelectUser.h"

@interface SendRedPaperViewController ()<UITableViewDataSource,UITableViewDelegate,SendRedPaperCellDelegate,UIActionSheetDelegate,SendReadyRedPaperDelegate>
{
    NSMutableArray *_redPaperArray;
    NSMutableArray *_redPaperFlayArray;
    
    UILabel *_leftValue;
    id _currentClickView;
    NSMutableDictionary *_paramsDict;
    SendReadyRedPaper *_readyRedPaper;
    UIButton *_inputRedPaperBtn;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)tapGestureAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureAction;


@end

@implementation SendRedPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData
{
    [self transFormSendRedPaperType:SendRedPaperTypeOfRegularMoney];
    _paramsDict = [[NSMutableDictionary alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)configUI
{
    self.title = @"发红包";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1];
    
    UIView *tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 100)];
//    tableViewFooterView.backgroundColor = [UIColor grayColor];
    self.tableView.tableFooterView = tableViewFooterView;
    
    _inputRedPaperBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_inputRedPaperBtn setTitle:@"放入红包" forState:UIControlStateNormal];
    [_inputRedPaperBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]
    [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1]];
    _inputRedPaperBtn.enabled = NO;
    _inputRedPaperBtn.frame = CGRectMake(50, 20, [UIScreen mainScreen].bounds.size.width - 100, 40);
    _inputRedPaperBtn.layer.masksToBounds = YES;
    _inputRedPaperBtn.layer.cornerRadius = 5;
    [_inputRedPaperBtn addTarget:self action:@selector(putInToRedPaper) forControlEvents:UIControlEventTouchUpInside];
    [tableViewFooterView addSubview:_inputRedPaperBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 280)/2.0f, 70, 280, 20)];
    label.text = @"过期未拆红包，金额将于48小时后自动退回我的钱包";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:116.0f/255.0f green:118.0f/255.0f blue:118.0f/255.0f alpha:1];
    [tableViewFooterView addSubview:label];
    
    self.tapGestureAction.enabled = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _redPaperArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SendRedPaperCell *cell = nil;
    cell = [self tableView:tableView reuseIdentifier:_redPaperFlayArray[indexPath.section]];
    cell.delegate = self;
    [cell configWithData:_redPaperArray[indexPath.section] reuseIdentifier:_redPaperFlayArray[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _redPaperArray.count - 1) {
        return 80;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 30;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.width, 20)];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"红包总金额为：18.8元";
        label.attributedText = [self textLabelColor:label.text leftPosition:7 rightPosition:label.text.length-7 color:[UIColor colorWithRed:240.0f/255.0f green:200.0f/255.0f blue:56.0f/255.0f alpha:1] font:[UIFont systemFontOfSize:13]];
        [view addSubview:label];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"浮动金额",@"固定金额", nil];
        [sheet showInView:self.view];
        
        SendRedPaperCell * cell = (SendRedPaperCell *)[tableView cellForRowAtIndexPath:indexPath];
        _leftValue = cell.leftValue;
    }
}
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    NSString *str = nil;
    NSLog(@"index = %ld",(long)buttonIndex);
    SendRedPaperCell * cell = (SendRedPaperCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
    cell.leftValueWrite.text = @"";

    if (buttonIndex == 0) {
        str = @"浮动金额";
        [self transFormSendRedPaperType:SendRedPaperTypeOfChangeMoney];
        SendRedPaperCell * cellT = (SendRedPaperCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
        cellT.leftValueWrite.text = @"";
            } else if (buttonIndex == 1) {
        str = @"固定金额";

        [self transFormSendRedPaperType:SendRedPaperTypeOfRegularMoney];
    }
    
    [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1]];
    _inputRedPaperBtn.enabled = NO;
    [_paramsDict removeAllObjects];
    _paramsDict[kSendRedPaperCellRedPaperType] = str;
    _leftValue.text = str;
    [self.tableView reloadData];
}

#pragma mark - SendRedPaperCellDelegate
- (void)currentBeginClickTextFild:(id)textField reuseIdentifier:(NSString *)reuseIdentifier
{
    self.tapGestureAction.enabled = YES;
    _currentClickView = textField;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight > 580) {
        return;
    }
    BOOL isPhone5 = NO;
    if (screenHeight == 568) {
        isPhone5 = YES;
    }
    NSLog(@"%@",reuseIdentifier);
    CGFloat height = 0;
    if ([reuseIdentifier isEqualToString:kSendRedPaperCellRemark]) {
        height = (isPhone5 == YES?80:100);
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = -height;
        }];
    } else if ([reuseIdentifier isEqualToString:kSendRedPaperCellRedPaperNum]) {
        height = (isPhone5 == YES?0:75);
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = -height;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.top = 0;
        }];
    }
}

- (void)currentEndClickTextFild:(id)textField reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([textField isKindOfClass:[UITextField class]]) {
        UITextField *filed = textField;
        _paramsDict[reuseIdentifier] = filed.text;
    }
    if ([textField isKindOfClass:[UITextView class]]) {
        UITextView *textView = textField;
        _paramsDict[reuseIdentifier] = textView.text;
    }
    if (_sendRedPaperType == SendRedPaperTypeOfRegularMoney) {
        if ([_paramsDict[kSendRedPaperCellRedPaperMoney] length] != 0 && [_paramsDict[kSendRedPaperCellRedPaperNum] length] != 0) {
            //[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]
            [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]];
            _inputRedPaperBtn.enabled = YES;
        } else {
            [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1]];
            _inputRedPaperBtn.enabled = NO;
        }
    } else {
        if ([_paramsDict[kSendRedPaperCellRedPaperMoney] length] != 0) {
            //[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]
            [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f green:53.0f/255.0f blue:62.0f/255.0f alpha:1]];
            _inputRedPaperBtn.enabled = YES;
        } else {
            [_inputRedPaperBtn setBackgroundColor:[UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1]];
            _inputRedPaperBtn.enabled = NO;
        }
    }

}

- (void)clickSendReadyRedPaper:(SendReadyRedPaper *)sendReadyRedPaper isDismiss:(BOOL)dismiss
{

    if (dismiss) {
        [_readyRedPaper removeFromSuperview];
        _readyRedPaper = nil;
    } else {
        SendRedPaperSelectUser *selectUser = [[SendRedPaperSelectUser alloc] init];
        [self.navigationController pushViewController:selectUser animated:YES];
    }
}
#pragma mark - private methods

- (SendRedPaperCell *)tableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    SendRedPaperCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[SendRedPaperCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)transFormSendRedPaperType:(SendRedPaperType)sendRedPaperType
{
    _sendRedPaperType = sendRedPaperType;
    if (sendRedPaperType == SendRedPaperTypeOfRegularMoney) {
        _redPaperArray = [NSMutableArray arrayWithObjects:@"付款方式",@"红包类型",@"单个金额",@"红包个数",@"", nil];
        _redPaperFlayArray = [NSMutableArray arrayWithObjects:kSendRedPaperCellPaymentMethod,kSendRedPaperCellRedPaperType,kSendRedPaperCellRedPaperMoney,kSendRedPaperCellRedPaperNum,kSendRedPaperCellRemark, nil];
    } else {
        _redPaperArray = [NSMutableArray arrayWithObjects:@"付款方式",@"红包类型",@"红包金额",@"", nil];
        _redPaperFlayArray = [NSMutableArray arrayWithObjects:kSendRedPaperCellPaymentMethod,kSendRedPaperCellRedPaperType,
                              kSendRedPaperCellRedPaperMoney,kSendRedPaperCellRemark, nil];
    }
}

- (NSMutableAttributedString*)textLabelColor:(NSString*)str leftPosition:(NSInteger)leftPos rightPosition:(NSInteger)rightPos color:(UIColor*)color font:(UIFont*)font
{
    
    NSMutableAttributedString *labelStr= [[NSMutableAttributedString alloc] initWithString:str];
    [labelStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(leftPos,rightPos)];
    [labelStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(leftPos, rightPos)];
    return labelStr;
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
    [_currentClickView resignFirstResponder];
    self.tapGestureAction.enabled = NO;
}

- (void)putInToRedPaper
{
    _readyRedPaper = [[SendReadyRedPaper alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    _readyRedPaper.delegate = self;
    [self.view addSubview:_readyRedPaper];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


@end
