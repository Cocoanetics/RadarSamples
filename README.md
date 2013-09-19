Radar Samples
=============

These are the sample projects we prepared to demonstrate issues we filed bug reports with Apple for. We are collecting here because they serve as nice reminders how much more likely Apple is to fix a bug if you can provide a concise sample.

Another good reason for creating a sample app is because some of those bugs make you doubt your sanity while you are stuck in your own code. 

Making a fresh app project designed to only demonstrate the issue and nothing more can sometimes show you that indeed the problem is located in your own code. Or it gives you certainty that indeed you found a bug in Apple's APIs.

##Open Bugs

### New iOS 7 Bugs
- **CATiledLayerMemory**: [CATiledLayer Loses Visible Tiles on Memory Warning](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14942449)
- **RoundedRectArtifact**: [Rounded rect bezier path with radius 3 drawn with scale 1 produces visual artifacts](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14954549)
- **UIColorStrokeCrash**: [NSAttributeDictionary Returns Color that produces EXC_BAD_ACCESS on stroking](http://www.cocoanetics.com/2013/09/welcome-to-ios-7-issues/) (rdar://14952597)

### Previous Bugs
- **InputViewScrollViewBug**: [UIScrollView Should Not Adjust Content Inset if it is Input View](http://www.cocoanetics.com/2013/05/radar-uiscrollview-should-not-adjust-content-inset-if-it-is-input-view/) (rdar://13836932)
- **NSDictionaryCGRectParsing**: [CGRectMakeWithDictionaryRepresentation] (http://www.cocoanetics.com/2012/09/radar-cgrectmakewithdictionaryrepresentation/) (rdar://12358120)
- **RelationBug**: [NSFetchedResultsController does not get refreshed for added relationship](http://www.cocoanetics.com/2012/05/radar-nsfetchedresultscontroller-does-not-get-refreshed-for-added-relationship/) (rdar://11541277)

##Fixed Bugs

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


