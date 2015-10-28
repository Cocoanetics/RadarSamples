Radar Samples
=============

These are the sample projects we prepared to demonstrate issues we filed bug reports with Apple for. We are collecting here because they serve as nice reminders how much more likely Apple is to fix a bug if you can provide a concise sample.

Another good reason for creating a sample app is because some of those bugs make you doubt your sanity while you are stuck in your own code. 

Making a fresh app project designed to only demonstrate the issue and nothing more can sometimes show you that indeed the problem is located in your own code. Or it gives you certainty that indeed you found a bug in Apple's APIs.

##Open Bugs

### iOS 9 Bugs

- **WidgetTabCellTest** [Table View Cells lose clickability in Today Widget](https://www.cocoanetics.com/2015/10/table-view-cells-lose-clickability-in-today-widget/), rdar://23298579 

### iOS 8 Bugs
- **LocalNotification** App Delegate method didReceiveLocalNotification not being called, rdar://17976899
- **SizeClassBug** [Incorrect Horizontal Size class with “present as popover” on iPhone 6+](http://www.cocoanetics.com/2014/11/radar-incorrect-horizontal-size-class/) (rdar://18893122)
- **PickerBug** [UIImagePicker returns offset cropped image](http://www.cocoanetics.com/2014/11/radar-uiimagepicker-returns-offset-cropped-image/) (rdar://18957593)
- **ActionsBug** [tableView:didEndEditingRowAtIndexPath: not being called following cancelled swipe-to-edit](http://www.cocoanetics.com/2015/01/radar-swipe-to-edit-on-uitableview/) (rdar://19411256)
- **CompositionBug** [UIImageView in UIScrollView Compositing Flashing](http://www.cocoanetics.com/2015/01/radar-uiimageview-in-uiscrollview-compositing-flashing/) (rdar://19323748)
- **StoreKitSheetTest** [SKStoreProductViewController cancel button issue](http://www.openradar.me/radar?id=5305669536186368) (rdar://20090284)
- **StoreKitVCBug** [SKStoreProductViewController does not call loading completion block](http://www.cocoanetics.com/2015/03/implementing-an-in-app-app-store/) (rdar://20089825)
- **DataDetectorBug** [Address Detection broken for addresses with more than one slash](http://www.cocoanetics.com/2015/04/radar-nsdatadetector-bug/) (rdar://20549548)
- **CLGeoCoderBug** [CLGeoCoder mistakes supplementary numbers for street address](http://www.cocoanetics.com/2015/04/radar-clgeocoder-bug/) (rdar://20665320)
- **TextViewScrollBug** [UITextView scroll position jumps around beginning/ending editing](http://www.cocoanetics.com/2015/04/radar-uitextview-scroll-position-bug/)(rdar://20743459)
- **AutomaticHeightBug** [UITableViewAutomaticDimension](http://www.cocoanetics.com/2015/08/radar-uitableviewautomaticdimension/) (rdar://22193223)

### Xcode 5 Bugs
- **UnitTestsTest**: [Xcode 5 unable to configure inline Unit Tests for iOS and Mac in parallel](http://www.cocoanetics.com/2013/09/radar-xcode-5-unable-to-configure-inline-unit-tests-for-ios-and-mac-in-parallel/) (rdar://15085316)
- **UIFontDemo**: [Xcode 5 crashes trying to run unit test without bundle loader](http://www.cocoanetics.com/2013/10/radar-double-feature-xcode-crash-and-unit-test-with-uifont/) (rdar://15167061)

### iOS 7 Bugs
- **CATiledLayerMemory**: [CATiledLayer Loses Visible Tiles on Memory Warning](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14942449)
- **RoundedRectArtifact**: [Rounded rect bezier path with radius 3 drawn with scale 1 produces visual artifacts](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14954549)
- **UIColorStrokeCrash**: [NSAttributeDictionary Returns Color that produces EXC_BAD_ACCESS on stroking](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14952597)
- **LogTest**: [asl_search only finds messages with ReadUID set](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14670536) 
- **ScanAreaBug**: [AVCaptureMetadataOutput ignores Full-Screen rectOfInterest](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14427767)
- **UIFontDemo** [Instantiating a UIFont in Unit Test should not require a test host](http://www.cocoanetics.com/2013/10/radar-double-feature-xcode-crash-and-unit-test-with-uifont/) (rdar://15166866)

### Previous Bugs
- **NSDictionaryCGRectParsing**: [CGRectMakeWithDictionaryRepresentation] (http://www.cocoanetics.com/2012/09/radar-cgrectmakewithdictionaryrepresentation/) (rdar://12358120)
- **RelationBug**: [NSFetchedResultsController does not get refreshed for added relationship](http://www.cocoanetics.com/2012/05/radar-nsfetchedresultscontroller-does-not-get-refreshed-for-added-relationship/) (rdar://11541277)
- **DTCoreTextExceptionExample**: [Enumerating NSAttributedString Attributes on Multiple Threads causes EXC_BAD_ACCESS](http://www.cocoanetics.com/2013/10/radar-enumerating-nsattributedstring-attributes-on-multiple-threads-causes-exc_bad_access/) (rdar://rdar://15139980)

##Fixed Bugs

### iOS 9

- **TransitionTest** [Percent-driven Interactive Animation has side effect on cancel at 0%](https://www.cocoanetics.com/2015/03/4-radars-percentage-driven-modal-transitions/) (rdar://20068860)
- **ABUnknownPersionViewControllerBug** [ABUnknownPersionViewController](http://www.cocoanetics.com/2015/06/radar-abunknownpersionviewcontroller/) (rdar://21357089, rdar://21438771)

#### iOS 8.3
- **InputViewScrollViewBug**: [UIScrollView Should Not Adjust Content Inset if it is Input View](http://www.cocoanetics.com/2013/05/radar-uiscrollview-should-not-adjust-content-inset-if-it-is-input-view/) (rdar://13836932)

#### iOS 7
- **KerningTest**: [UITextView Ignores Font Kerning](http://www.cocoanetics.com/2012/12/radar-uitextview-ignores-font-kerning/)
- **MinMaxLineHeightBug**: [UITextView Ignores Minimum/Maximum Line Height in Attributed String](http://www.cocoanetics.com/2012/12/radar-uitextview-ignores-minimummaximum-line-height-in-attributed-string/) (rdar://12863734)
- **QuickLookBug**: [QLPreviewController Exception](http://www.cocoanetics.com/2013/06/radar-qlpreviewcontroller-exception/) (rdar://14216503)
- **ContainerViewDemo**: [View frame inconsistency using presentViewController + wantsFullScreenLayout Y/N](http://www.cocoanetics.com/2012/06/radar-view-frame-inconsistency-using-presentviewcontroller-wantsfullscreenlayout-yn/) (rdar://11688188)

#### iOS 6
- **CoreTextLineOrigins**: [CoreText Line Spacing Bug](http://www.cocoanetics.com/2012/02/radar-coretext-line-spacing-bug/) (rdar://10810114)

#### iOS 5
- **StatusBarBug**: [NavigationController from NIB produces sticky gray empty status bar on rotation](http://www.cocoanetics.com/2010/08/navigationcontroller-from-nib-produces-sticky-gray-empty-status-bar-on-rotation/) (rdar://8313852)


##Not Bugs

These have turned out not to be actual bugs but "works as designed".

- **ARCBugCGColor**: [ARC releases UIColor prematurely](http://www.cocoanetics.com/2012/06/radar-arc-releases-uicolor-prematurely/) (rdar://11717864)


