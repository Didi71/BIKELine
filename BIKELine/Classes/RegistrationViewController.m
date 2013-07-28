//
//  RegistrationViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "RegistrationViewController.h"
#import "BBApi.h"
#import "ActivationViewController.h"

static inline UIImage *ContextCreateRoundedMask(CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br) {
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return NULL;
    }
    
    // cerate mask
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGContextBeginPath(context);
    CGContextSetGrayFillColor(context, 1.0, 0.0);
    CGContextAddRect(context, rect);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetGrayFillColor(context, 1.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius_bl);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius_br);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius_tr);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius_tl);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    // Create CGImageRef of the main view bitmap content, and then release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can release the original
    CGImageRelease(bitmapContext);
    
    return theImage;
}


@implementation RegistrationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"registerViewTitle", @"");
        
        bikerInfo = BLStandardUserDefaults.biker;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    // Set text
    [teaserLabel setText:NSLocalizedString(@"registerViewTeaserText", @"")];
    [cameraLabel setText:NSLocalizedString(@"registerViewProfilePictureText", @"")];
    [firstNameTextField setPlaceholder:NSLocalizedString(@"placeholderFirstNameTitle", @"")];
    [lastNameTextField setPlaceholder:NSLocalizedString(@"placeholderLastNameTitle", @"")];
    [streetTextField setPlaceholder:NSLocalizedString(@"placeholderStreetTitle", @"")];
    [postalCodeTextField setPlaceholder:NSLocalizedString(@"placeholderPostalCodeTitle", @"")];
    [cityTextField setPlaceholder:NSLocalizedString(@"placeholderCityTitle", @"")];
    [eMailTextField setPlaceholder:NSLocalizedString(@"placeholderEMailTitle", @"")];
    [sexMaleButton setTitle:NSLocalizedString(@"buttonMaleTitle", @"") forState:UIControlStateNormal];
    [sexFemaleButton setTitle:NSLocalizedString(@"buttonFemaleTitle", @"") forState:UIControlStateNormal];
    [registerButton setTitle:NSLocalizedString(@"buttonRegisterTitle", @"") forState:UIControlStateNormal];
    
    // Layout avatar view
    UIImage *mask = ContextCreateRoundedMask(self.view.bounds, 5.0, 0.0, 0.0, 0.0);
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = self.view.bounds;
    layerMask.contents = (id)mask.CGImage;
    avatarImageView.layer.mask = layerMask;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ActivationViewController *nextView = [segue destinationViewController];
    nextView.bikerInfo = bikerInfo;
}


#pragma mark
#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    float keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x,
                                    scrollView.frame.origin.y,
                                    scrollView.frame.size.width,
                                    self.view.frame.size.height - keyboardHeight)];
    
    [UIView commitAnimations];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, registerButton.frame.origin.y + registerButton.frame.size.height + 10.0)];
    [scrollView setScrollEnabled:YES];
    [scrollView flashScrollIndicators];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x,
                                    scrollView.frame.origin.y,
                                    scrollView.frame.size.width,
                                    self.view.frame.size.height)];
    
    [scrollView setScrollEnabled:NO];
}


#pragma mark
#pragma mark - Actions

- (IBAction)cameraButtonPressed:(id)sender {
    [self.view endEditing:YES];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [sheet addButtonWithTitle:NSLocalizedString(@"buttonOpenPhotoLibraryTitle", @"")];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:NSLocalizedString(@"buttonTakeNewPhotoButtonTitle", @"")];
    }
    
    if (avatarImageView.image != nil) {
        [sheet addButtonWithTitle:NSLocalizedString(@"buttonRemoveAvatarTitle", @"")];
    }
    
    [sheet addButtonWithTitle:NSLocalizedString(@"buttonCancelTitle", @"")];
    [sheet setCancelButtonIndex:sheet.numberOfButtons - 1];
    
    [sheet showInView:self.view];
}

- (IBAction)sexButtonPressed:(id)sender {
    if ([sender isEqual:sexMaleButton]) {
        [sexFemaleButton setSelected:NO];
        [sexFemaleButton setUserInteractionEnabled:YES];
        [sexMaleButton setSelected:YES];
        [sexMaleButton setUserInteractionEnabled:NO];
    } else {
        [sexMaleButton setSelected:NO];
        [sexMaleButton setUserInteractionEnabled:YES];
        [sexFemaleButton setSelected:YES];
        [sexFemaleButton setUserInteractionEnabled:NO];
    }
}

- (IBAction)registrationButtonPressed:(id)sender {
    if (firstNameTextField.text.length == 0) {
        [firstNameTextField becomeFirstResponder];
        return;
    }
    
    if (lastNameTextField.text.length == 0) {
        [lastNameTextField becomeFirstResponder];
        return;
    }
    
    if (streetTextField.text.length == 0) {
        [streetTextField becomeFirstResponder];
        return;
    }
    
    if (postalCodeTextField.text.length == 0) {
        [postalCodeTextField becomeFirstResponder];
        return;
    }
    
    if (cityTextField.text.length == 0) {
        [cityTextField becomeFirstResponder];
        return;
    }
    
    if (eMailTextField.text.length == 0) {
        [eMailTextField becomeFirstResponder];
        return;
    }
    
    if (!sexMaleButton.isSelected && !sexFemaleButton.isSelected) {
        return;
    }
    

    // Set values to biker info
    bikerInfo.firstName = firstNameTextField.text;
    bikerInfo.lastName = lastNameTextField.text;
    bikerInfo.street = streetTextField.text;
    bikerInfo.postalcode = [NSNumber numberWithDouble:[postalCodeTextField.text doubleValue]];
    bikerInfo.city = cityTextField.text;
    bikerInfo.eMail = eMailTextField.text;
    bikerInfo.sex = [NSNumber numberWithInt:(sexMaleButton.isSelected == YES ? kBikerSexMale : kBikerSexFemale)];
    
    
    // Display progressHUD
    [self.view endEditing:YES];
    
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressRegistrationText", @"")
                   andSuccessMessage: NSLocalizedString(@"successRegistrationText", @"")];
    
    
    // Call API
    BBApiRegistrationOperation *op = [SharedAPI registerBikerWithInfo:bikerInfo];
    __weak BBApiRegistrationOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:YES];
                [SharedAPI displayError:wop.response.errorCode];
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            bikerInfo.userId = wop.response.userId;
            bikerInfo.pin = wop.response.pin;
            
            [self hideHUD:NO];
            [self performSegueWithIdentifier:@"RegisterToActivateSegue" sender:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


#pragma mark
#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:firstNameTextField]) {
        [lastNameTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:lastNameTextField]) {
        [streetTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:streetTextField]) {
        [postalCodeTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:postalCodeTextField]) {
        [cityTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:cityTextField]) {
        [eMailTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:eMailTextField]) {
        [eMailTextField resignFirstResponder];
    }

    return YES;
}


#pragma mark
#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 0 || actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"buttonOpenPhotoLibraryTitle", @"")]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:cameraPicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"buttonTakeNewPhotoButtonTitle", @"")]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:cameraPicker animated:YES completion:nil];
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:NSLocalizedString(@"buttonRemoveAvatarTitle", @"")]) {
        [avatarImageView setImage:nil];
        [avatarImageView setHidden:YES];
        [cameraImageView setHidden:NO];
        [cameraLabel setHidden:NO];
    }
}


#pragma mark
#pragma mark - UIImagePickerController delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *resizedImage = bikerInfo.avatar = [BLUtils resizeImage:selectedImage toSize:CGSizeMake(240.0, 360.0) withCompression:0.85];
    
    [avatarImageView setImage:resizedImage];
    [avatarImageView setHidden:NO];
    [cameraImageView setHidden:YES];
    [cameraLabel setHidden:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

