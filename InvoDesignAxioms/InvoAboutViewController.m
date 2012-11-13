//
//  InvoAboutViewController.m
//  InvoDesignAxioms
//
//  Created by Dhaval Karwa on 10/30/12.


//  Copyright 2012 Involution Studios

//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#import "InvoAboutViewController.h"

#import "ImageFromRect.h"
#import "Constants.h"

@interface InvoAboutViewController ()
{
    UIButton *logoButton;
    UIButton *invo;
    UITextView *aboutView;
    UILabel *footer;
}

@property (nonatomic, strong) UIButton *deckView;

@end

@implementation InvoAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.view setBackgroundColor:[UIColor colorWithRed:0.17f green:0.09f blue:0.15f alpha:1.00f]];
        
        [self addFooter];
        [self addLogoButton];
        [self addAboutText];
        [self addFeedback];
        [self addDeckImage];
        [self addWebLink];
        
        UIPinchGestureRecognizer *pinchReco = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
        pinchReco.delegate = self;
        [self.view addGestureRecognizer:pinchReco];
        
        UITapGestureRecognizer *doubleTapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTapReco.numberOfTouchesRequired = 1;
        doubleTapReco.numberOfTapsRequired = 2;
        doubleTapReco.delegate = self;
        [self.view addGestureRecognizer:doubleTapReco];
    }
    return self;
}

-(void)doubleTap:(UITapGestureRecognizer *)tapReco{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addFooter{

    CGRect footerRect = CGRectZero;
    float fontSize = 8.0f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
     footerRect = CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH -20))*0.5 , SCREEN_HEIGHT - 60, SCREEN_WIDTH -20, 30);
        fontSize = 10.0f;
    }
    else{
        footerRect = CGRectMake((SCREEN_WIDTH - (SCREEN_WIDTH -20))*0.5 , SCREEN_HEIGHT - 50, SCREEN_WIDTH -20, 30);
    }
    
    footer = [[UILabel alloc]initWithFrame:footerRect];
    [footer setTextAlignment:NSTextAlignmentCenter];
    [footer setBackgroundColor:[UIColor clearColor]];
    [footer setTextColor:[UIColor colorWithRed:0.83f green:0.71f blue:0.57f alpha:1.00f]];
    [footer setNumberOfLines:2];
    NSString *distStr = @"SHARE, REMIX, REUSE \n Licensed under Creative Commons Attribution 3.0";
    [footer setText:[distStr uppercaseString]];
    [footer setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize]];
    [footer setUserInteractionEnabled:NO];
    [self.view addSubview:footer];

}
#pragma mark Logo
-(void)addLogoButton{
    
    logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *logoImg = [UIImage imageNamed:@"involution_studios_logo.png"];

    float fontSize = 16.0f;
    UIImage *iconImg ;
    CGRect invoRect = CGRectZero;
    CGRect logoRect = CGRectZero;
    
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad) {
        
        fontSize = 20.0f;
        iconImg = [UIImage imageNamed:@"LogoTiny.png"];
        logoRect = CGRectMake((SCREEN_WIDTH - iconImg.size.width)*0.5, 20, iconImg.size.width, iconImg.size.height);
        invoRect = CGRectMake((SCREEN_WIDTH - logoImg.size.width)*0.5, footer.frame.origin.y - logoImg.size.height - 10 , logoImg.size.width, logoImg.size.height);
    }
    else{
        iconImg = [UIImage imageNamed:@"LogoTiny_iPhone.png"];
        logoRect = CGRectMake((SCREEN_WIDTH - iconImg.size.width)*0.5, 10, iconImg.size.width, iconImg.size.height);
        invoRect = CGRectMake((SCREEN_WIDTH - logoImg.size.width)*0.5, footer.frame.origin.y - logoImg.size.height - 5 , logoImg.size.width, logoImg.size.height);
    }
    
    [logoButton setImage:iconImg forState:UIControlStateNormal];
    [logoButton setFrame:logoRect];
    [self.view addSubview:logoButton];
    [logoButton addTarget:self action:@selector(logoTapped:) forControlEvents:UIControlEventTouchUpInside];
        
    invo = [UIButton buttonWithType:UIButtonTypeCustom];
      [invo setImage:logoImg forState:UIControlStateNormal];
    [invo setFrame:invoRect];
    [self.view addSubview:invo];
    [invo addTarget:self action:@selector(invoTapped:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)addDeckImage{
    
    CGRect deckRect = CGRectZero;
    UIImage *deckImg;
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad) {
    
        deckImg= [UIImage imageNamed:@"Order.png"];
        deckRect = CGRectMake((SCREEN_WIDTH - deckImg.size.width)*0.5, aboutView.frame.origin.y +aboutView.frame.size.height +10 , deckImg.size.width, deckImg.size.height);
    }
    else{
    
        deckImg= [UIImage imageNamed:@"Order_iPhone.png"];
        deckRect = CGRectMake((SCREEN_WIDTH - 231)*0.5, aboutView.frame.origin.y +aboutView.frame.size.height -10 , 231, 108);
        if (SCREEN_HEIGHT >480) {
            deckRect = CGRectMake((SCREEN_WIDTH - 231)*0.5, aboutView.frame.origin.y +aboutView.frame.size.height +5 , 231, 108);
        }
    }

    self.deckView = [[UIButton alloc]initWithFrame:deckRect];
    
    [self.deckView setBackgroundImage:deckImg forState:UIControlStateNormal];
    
    [self.view addSubview:self.deckView];
    
    [self.deckView  addTarget:self action:@selector(buytap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)webTap:(id)sender{
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.designaxioms.com"]];
}

-(void)buytap:(id)sender{

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.amazon.com/Design-Axioms-Cards-Software-Principles/dp/B006GGHQ3G/ref=sr_1_1?s=books&ie=UTF8&qid=1343676157&sr=1-1&keywords=design+axioms+juhan"]];
}

-(void)logoTapped:(id)sender{

     [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

-(void)invoTapped:(id)sender{

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.goinvo.com"]];
}

#pragma mark AboutText
-(void)addAboutText{
    
    float fontSize = 12.0f;
    CGRect headRect = CGRectZero;
    CGRect abtRect = CGRectZero;
    NSString *abtString ;
    float padding = 50.0;
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad) {
        fontSize = 18.0f;
        padding = 70.0f;
        headRect = CGRectMake(10, logoButton.frame.origin.y + logoButton.frame.size.height +10, SCREEN_WIDTH-20,CREDIT_HEAD_IPAD_HEIGHT);
        
        abtString  = @"There is a mismatch between the digital design community and company cultures on the skills and practices required to design usable, useful, and elegant interfaces.\n\nThese design axioms therefore give designers, engineers, product managers, and anyone else who influences the creation of software design, a simple-but-essential core set of rules that will help you contribute to building a world of effective interfaces. A handful of great design minds have provided personal quotes to bring the Design Axioms home.";
    }
    else{
        
        
        if (SCREEN_HEIGHT >480) {
            abtString = @"21 cards on the art and science of software design.";
            headRect = CGRectMake(10, logoButton.frame.origin.y + logoButton.frame.size.height +10, SCREEN_WIDTH-20,CREDIT_HEAD_IPHONE_HEIGHT);
        }
        else{
            abtString = @"";
            headRect = CGRectMake(10, logoButton.frame.origin.y + logoButton.frame.size.height +6, SCREEN_WIDTH-20,CREDIT_HEAD_IPHONE_HEIGHT);
        }
    }
    
    UITextView *headText = [[UITextView alloc]initWithFrame:headRect];
    [headText setBackgroundColor:[UIColor clearColor]];
    [headText setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize]];
    [headText setTextColor:[UIColor colorWithRed:0.83f green:0.71f blue:0.57f alpha:1.00f]];
    [headText setUserInteractionEnabled:NO];
    [headText setTextAlignment:NSTextAlignmentCenter];
    
    NSString *byString  = @"by Juhan Sonin and Dirk Knemeyer \n Illustrated by Sarah Kaiser \n App by Dhaval Karwa \n\n Special Contributions from\n Andrei Herasimchuk and Luke Wroblewski";
    [headText setText:byString];
    [headText setEditable:NO];
    [headText setScrollEnabled:NO];
    [self.view addSubview:headText];
    
    CGSize abtSize = [abtString sizeWithFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize] constrainedToSize:CGSizeMake(SCREEN_WIDTH - padding, 100000) lineBreakMode:UILineBreakModeWordWrap];
    
   abtRect = CGRectMake(padding*0.5, headText.frame.origin.y + headText.frame.size.height+fontSize, abtSize.width, abtSize.height + fontSize);
    
    aboutView = [[UITextView alloc]initWithFrame:abtRect];
    [aboutView setBackgroundColor:[UIColor clearColor]];
    [aboutView setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize]];
    [aboutView setTextColor:[UIColor colorWithRed:0.83f green:0.71f blue:0.57f alpha:1.00f]];
    [aboutView setUserInteractionEnabled:NO];
    [aboutView setTextAlignment:NSTextAlignmentCenter];
    
    [aboutView setText:abtString];
    [aboutView setEditable:NO];
    [aboutView setScrollEnabled:YES];
    [self.view addSubview:aboutView];

}

#pragma mark Feedback + Mail Client

-(void)addFeedback{

    float fontSize = 14.0f;
    CGSize btnSize = CGSizeZero;
    CGRect feedbackRect = CGRectZero;
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad) {
        
        fontSize = 18.0f;
        btnSize = CGSizeMake(FDB_IPAD_WIDTH, FDB_IPAD_HEIGHT);
        feedbackRect = CGRectMake((SCREEN_WIDTH -btnSize.width)*0.5, invo.frame.origin.y - btnSize.height -10, btnSize.width, btnSize.height);
    }
    else  {
        btnSize = CGSizeMake(FDB_IPHONE_WIDTH, FDB_IPHONE_HEIGHT);
        feedbackRect = CGRectMake((SCREEN_WIDTH -btnSize.width)*0.5, invo.frame.origin.y - btnSize.height , btnSize.width, btnSize.height);
    }

    UIButton *feedback = [[UIButton alloc]initWithFrame:feedbackRect];
    
        [feedback.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize]];
    [feedback setTitle:@"Feedback" forState:UIControlStateNormal];

    [self.view addSubview:feedback];
    
    [feedback addTarget:self action:@selector(feedBacktap:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)addWebLink{

    float fontSize = 14.0f;
    CGSize btnSize = CGSizeZero;
    float padding = 10.0f;
    if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad) {
        
        fontSize = 18.0f;
        btnSize = CGSizeMake(250, 22);
        padding = 30.0f;
    }
    else btnSize = CGSizeMake(200, 22);
    
    UIButton *webLink = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -btnSize.width)*0.5, self.deckView.frame.origin.y +self.deckView.frame.size.height+ btnSize.height-10 , btnSize.width, btnSize.height)];
    
    [webLink.titleLabel setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:fontSize]];
    [webLink setTitle:@"www.DesignAxioms.com" forState:UIControlStateNormal];
    
    [self.view addSubview:webLink];
    
    [webLink addTarget:self action:@selector(webTap:) forControlEvents:UIControlEventTouchUpInside];
}
 

-(void)feedBacktap:(id)sender{

    if (![MFMailComposeViewController canSendMail]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:NSLocalizedString(@"Your device is not able to send mail.", @"") delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    MFMailComposeViewController *mailComp = [[MFMailComposeViewController alloc] init];
    [mailComp setSubject:@"Feedback for DesignAxioms App"];
    [mailComp setToRecipients:[NSArray arrayWithObject:@"info@goinvo.com"]];
    mailComp.mailComposeDelegate = self;
    [self presentModalViewController:mailComp animated:YES ];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark handling pinch Gesture

-(void)handlePinch:(UIPinchGestureRecognizer *)pinch{
    
    if (pinch.state ==UIGestureRecognizerStateChanged) {
        
        if (pinch.scale >=0.0 && pinch.scale <=1.0) {
            [self.view  setTransform:CGAffineTransformMakeScale(pinch.scale, pinch.scale)];
        }
        else{
            [self.view  setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }
    }
    
    if (pinch.state == UIGestureRecognizerStateEnded) {
        
        if (pinch.scale <=0.8) {
            
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            
            [UIView animateWithDuration:0.3f animations:^(){
                
                [self.view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            }];
        }
    }
}
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


@end
