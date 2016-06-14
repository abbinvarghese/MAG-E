//
//  MEAddViewController.m
//  MAG-E
//
//  Created by Abbin Varghese on 10/06/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "MEAddViewController.h"
#import "MEApplicationHelper.h"
@import WebKit;
@import Firebase;

@interface MEAddViewController ()<UISearchBarDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *articleTitle;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstrain;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation MEAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height-66-44)];
    _webView.navigationDelegate = self;
    
    [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.view insertSubview:_webView belowSubview:_toolBar];
    
    NSURL *url = [NSURL URLWithString:[UIPasteboard generalPasteboard].string];
    
    if (url && url.scheme && url.host) {
        _searchBar.text = [UIPasteboard generalPasteboard].string;
    }
    
    _postButton.layer.cornerRadius = 5;
    _postButton.layer.masksToBounds = YES;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardNotScreen:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardNotScreen:(NSNotification *)notification{
    
    self.toolBarBottomConstrain.constant = 0;
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardOnScreen:(NSNotification *)notification{
    
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    self.toolBarBottomConstrain.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)post:(UIButton *)sender {
    if (!_webView.loading) {
        if (_webView.URL && _webView.URL.host && _webView.URL.scheme) {
            [MEApplicationHelper postArticleForReview:_webView.URL withHeading:_articleTitle];
            [self cancel:nil];
        }
        else{
            [self searchBarSearchButtonClicked:_searchBar];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSURL *url = [NSURL URLWithString:searchBar.text];
    if (url && url.scheme && url.host) {
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    else{
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://google.com/search?q=%@",searchBar.text]]]];
    }
}

- (IBAction)cancel:(UIButton *)sender {
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Load Error" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))] && object == self.webView) {
        _articleTitle = _webView.title;
    }
    else if ([keyPath isEqualToString:@"loading"] && object == self.webView){
        _searchBar.text = [NSString stringWithFormat:@"%@",_webView.URL];
        _backButton.enabled = _webView.canGoBack;
        _forwardButton.enabled = _webView.canGoForward;
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (IBAction)back:(UIButton *)sender {
    [_webView goBack];
}

- (IBAction)forward:(UIButton *)sender {
    [_webView goForward];
}

- (void)dealloc {
    
    if ([self isViewLoaded]) {
        [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
        [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
        [self.webView removeObserver:self forKeyPath:@"loading"];
    }
}

@end
