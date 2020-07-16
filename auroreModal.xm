#import "auroreModal.h"


@implementation auroreModal

- (id)initWithTitle:(id)arg1 detailText:(id)arg2 {
    //change icon from nil to uiimage
    self = [super initWithTitle:arg1 detailText:arg2 icon:nil];
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    self.modalInPresentation = YES;
    // self.view.tintColor = [UIColor systemGreenColor]; this colors the button if you want
    return self;
}
- (OBBoldTrayButton *)createButton {
    OBBoldTrayButton *button = [OBBoldTrayButton buttonWithType:1];
    [button setClipsToBounds:YES];
    [button.layer setCornerRadius:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Continue" forState:UIControlStateNormal];
    [self.buttonTray addButton:button];
    return button;
}
- (void)presentModal {
    UIWindow *foundWindow = nil;
    for (UIWindow *window in [[UIApplication sharedApplication]windows]) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    if ([foundWindow class] == [%c(SBHomeScreenWindow) class]) {
        self.homeWindowTemp = (SBHomeScreenWindow*)foundWindow;
        self.origWindowLevel = foundWindow.windowLevel;
        foundWindow.windowLevel = 26; //Place it above floatingdockplus13
    }
    [foundWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

- (void)dismissModal {
  [self dismissViewControllerAnimated:YES completion:nil];
	if (self.homeWindowTemp) {
    self.homeWindowTemp.windowLevel = self.origWindowLevel;
    self.homeWindowTemp = nil;
    self.origWindowLevel = nil;
	}
}

- (void)viewDidDisappear:(BOOL)arg1 {
    [self dismissModal];
    [super viewDidDisappear:arg1];
}

@end
