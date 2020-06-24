%hook SBLockScreenManager
%property (nonatomic,assign) BOOL showAuroreModal;
%property (nonatomic,retain) auroreModal *auroreModal;

- (id)init {
  // check if you need to show modal here
  self.showAuroreModal = ...
  return %orig;
}
- (void)lockScreenViewControllerDidDismiss {
	if (self.showAuroreModal) {
		NSArray *listTitles = @[@"Settings", @"Clock", @"Music"];
		NSArray *listContents = @[@"The alarm layout can be adjusted in the settings app. The device password must be setup there prior to use.", @"Each alarm can be individually be configured to your liking. Enabling Aurore within the editing pane will reveal further options.", @"Aurore currently supports the following links:\n- Apple Music playlist\n- Spotify playlist"];
    		[self aurorePresentModal:@"Welcome to Aurore" subTitle:nil listTitles:listTitles listContents:listContents listImages:nil];
	}
}

%new
- (void)aurorePresentModal:(NSString *)title subTitle:(NSString *)subTitle listTitles:(NSArray *)listTitles listContents:(NSArray *)listContents listImages:(NSArray *)listImages {
	self.auroreModal = [[auroreModal alloc] initWithTitle:title detailText:subTitle];
	
	for (int x = 0; x < [listTitles count]; x++) {
		[self.auroreModal addBulletedListItemWithTitle:listTitles[x] description:listContents[x] image:nil]; //replace images with the array if you have images or you could use [UIImage systemImageNamed:...] on ios13
	}

	OBBoldTrayButton *button = [self.auroreModal createButton];
  	[button addTarget:self action:@selector(auroreDismissModal) forControlEvents:UIControlEventTouchUpInside];

	[self.auroreModal presentModal];
}

%new
- (void)auroreDismissModal {
	[self.auroreModal dismissModal];
	self.auroreModal = nil;
	// opens your app preferences in sesttings
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-prefs:Aurore"] options:@{} completionHandler:nil];
}

%end

