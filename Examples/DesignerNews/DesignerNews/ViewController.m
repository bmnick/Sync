#import "ViewController.h"
#import "DesignerNewsTableViewCell.h"
#import "DATAStack.h"
#import "DataManager.h"

static NSString * const CellIdentifier = @"Cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DATAStack *dataStack;
@property (strong, nonatomic) NSArray *arrayWithStories;
@property CGFloat deviceWidth;
@property CGFloat deviceHeight;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self preferredStatusBarStyle];

    self.deviceWidth = [UIScreen mainScreen].bounds.size.width;
    self.deviceHeight = [UIScreen mainScreen].bounds.size.height;

    self.arrayWithStories = [NSArray new];

    [self setAllViewsInPlace];

     self.dataStack = [[DATAStack alloc] initWithModelName:@"DesignerNews"];

    DataManager *dataManager = [DataManager new];
    [dataManager compareAndChangeStoriesWithDataStack:self.dataStack];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Stories"];
    //request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"updated_at" ascending:YES]];
    self.arrayWithStories = [self.dataStack.mainContext executeFetchRequest:request error:nil];

    [self.tableView registerClass:[DesignerNewsTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.delegate = self;

    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DesignerNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    return cell;
}

#pragma mark - Helper methods

- (void)setAllViewsInPlace
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.deviceWidth, 90)];
    headerView.backgroundColor = [UIColor colorWithRed:0.2 green:0.46 blue:0.84 alpha:1];
    [self.view addSubview:headerView];

    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.deviceWidth, headerView.frame.size.height - 15)];
    labelTitle.text = @"Designer News";
    labelTitle.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:34];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:labelTitle];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.deviceWidth, self.deviceHeight - 90) style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UIStatusBar methods

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
