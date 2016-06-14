//
//  MEListViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 09/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEListViewController.h"
#import "MEListCollectionViewCell.h"
#import "MEApplicationHelper.h"
#import "MEAddViewController.h"
@import SafariServices;

@interface MEListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (strong, nonatomic) NSArray *articleArray;
@property (weak, nonatomic) IBOutlet UICollectionView *articleCollectionView;
@end

@implementation MEListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[MEApplicationHelper sharedHelper]startListeningToBDChanges:^(NSArray *modifiedArray) {
        if (_articleArray.count>0){
            _articleArray = modifiedArray;
        }
        else{
            _articleArray = modifiedArray;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_articleCollectionView reloadData];
            });
            
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _articleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MEListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MEListCollectionViewCell" forIndexPath:indexPath];
    cell.articleObject = [_articleArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}


- (IBAction)addNew:(UIButton *)sender {
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if (user != nil && !user.anonymous) {
            
        }
        else{
            MEAddViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"MEAddViewController"];
            [self presentViewController:newView animated:YES completion:^{
                
            }];
        }
    }];
    
}

- (IBAction)refresh:(UIButton *)sender {
    [self.articleCollectionView performBatchUpdates:^{
        [self.articleCollectionView reloadData];
    } completion:^(BOOL finished) {}];
}


@end
