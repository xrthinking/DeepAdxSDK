//
//  ViewController.m
//  DeepAdxDebug
//
//  Created by cc on 2022/5/24.
//

#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *dataArr;

@property (nonatomic, strong) UIImageView *logoImgV;
@property (nonatomic, strong) UILabel *idfaLab;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DEEPADX-聚合广告平台";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
  
    _dataArr = @[
        @{@"title":@"开屏广告", @"targetVCName": @"DemoSplashViewController"},
        @{@"title":@"Banner广告", @"targetVCName": @"DemoBannerViewController"},
        @{@"title":@"插屏广告", @"targetVCName": @"DemoInterstitialViewController"},
        @{@"title":@"激励视频广告", @"targetVCName": @"DemoRewardVideoViewController"},
        @{@"title":@"原生广告", @"targetVCName": @"DemoListFeedExpressViewController"},
        @{@"title":@"IDFA", @"targetVCName": @""},
    ];
    
    [_tableView reloadData];
}

- (void)initSubviews {

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    _tableView.backgroundView = [UIView new];
    
    UILabel *vLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    vLbl.textAlignment = NSTextAlignmentCenter;
    
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)toSettingsViewController {
    [self.navigationController pushViewController:[[NSClassFromString(@"SettingsViewController") alloc] init] animated:YES];
}

// MARK: UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = _dataArr[indexPath.row][@"title"];
    if (indexPath.row == _dataArr.count - 1) {
        [self addIdfaLabeWithView:cell.contentView];
    }
    cell.detailTextLabel.text = [self getIDFA];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(_dataArr[indexPath.row][@"targetVCName"]) alloc] init];
//    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.title = _dataArr[indexPath.row][@"title"];
    if (!vc) {
        return;
    }
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSString *)getIDFA{
    
    NSString *idfa = @"";
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    } else {
        idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    }
    return idfa;
}

- (void)addIdfaLabeWithView:(UIView *)view {
    [view addSubview:self.idfaLab];
    [self.idfaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(view);
        make.left.equalTo(view).offset(100);
    }];
    
    NSString *idfa = [self getIDFA];
    BOOL hasValue = ![idfa isEqualToString:@""];
    self.idfaLab.text = hasValue ? idfa : @"请在设置-隐私-跟踪中允许App请求跟踪";
    if (@available(iOS 13.0, *)) {
        self.idfaLab.textColor = hasValue ? [UIColor systemBlueColor] : [UIColor labelColor];
    } else {
        self.idfaLab.textColor = hasValue ? [UIColor systemBlueColor] : [UIColor darkTextColor];
    }
    self.idfaLab.userInteractionEnabled = hasValue;
    for (UIGestureRecognizer *g in [self.idfaLab.gestureRecognizers copy]) {
        [self.idfaLab removeGestureRecognizer:g];
    }
    if (hasValue) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyIDFAToPasteboard)];
        [self.idfaLab addGestureRecognizer:tap];
    }
}

- (void)copyIDFAToPasteboard {
    NSString *idfa = [self getIDFA];
    if (idfa.length == 0) {
        return;
    }
    [UIPasteboard generalPasteboard].string = idfa;
    [self showCopyToast];
}

static NSInteger const kIDFACopyToastTag = 929929;

- (void)showCopyToast {
    [[self.view viewWithTag:kIDFACopyToastTag] removeFromSuperview];
    UILabel *toast = [[UILabel alloc] init];
    toast.tag = kIDFACopyToastTag;
    toast.text = @"已复制";
    toast.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    toast.textColor = [UIColor whiteColor];
    toast.textAlignment = NSTextAlignmentCenter;
    toast.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.78];
    toast.layer.cornerRadius = 10;
    toast.clipsToBounds = YES;
    [self.view addSubview:toast];
    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(120);
    }];
    toast.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{ toast.alpha = 1; }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{ toast.alpha = 0; } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
    });
}

- (UILabel *)idfaLab {
    if (!_idfaLab) {
        _idfaLab = [UILabel new];
        _idfaLab.numberOfLines = 0;
    }
    return _idfaLab;
}
@end
