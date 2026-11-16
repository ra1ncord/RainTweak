#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <HBPreferences.h>

@interface RainTweakListController : PSListController {
    HBPreferences *_preferences;
}
@end

@implementation RainTweakListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        NSMutableArray *specifiers = [NSMutableArray array];

        // Group 1: General Tweak Control
        [specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"General Settings"
                                                              target:nil
                                                                 set:nil
                                                                 get:nil
                                                               detail:Nil
                                                           cell:PSGroupCell
                                                           edit:Nil]];

        PSSpecifier *enabledSpec = [PSSpecifier preferenceSpecifierNamed:@"Enable Rich Presence"
                                                                  target:self
                                                                     set:@selector(setPreferenceValue:specifier:)
                                                                     get:@selector(readPreferenceValue:)
                                                                  detail:Nil
                                                                  cell:PSSwitchCell
                                                                  edit:Nil];
        [enabledSpec setProperty:@"enabled" forKey:@"key"];
        [enabledSpec setProperty:@"com.ra1ncord.raintweak" forKey:@"defaults"];
        [specifiers addObject:enabledSpec];

        // Group 2: Platform Simulation
        [specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"Platform & Console Emulation"
                                                              target:nil
                                                                 set:nil
                                                                 get:nil
                                                               detail:Nil
                                                           cell:PSGroupCell
                                                           edit:Nil]];

        PSSpecifier *psSpec = [PSSpecifier preferenceSpecifierNamed:@"Emulate PlayStation (PS5/PS4)"
                                                             target:self
                                                                set:@selector(setPreferenceValue:specifier:)
                                                                get:@selector(readPreferenceValue:)
                                                             detail:Nil
                                                             cell:PSSwitchCell
                                                             edit:Nil];
        [psSpec setProperty:@"isPlayStationPlatform" forKey:@"key"];
        [psSpec setProperty:@"com.ra1ncord.raintweak" forKey:@"defaults"];
        [specifiers addObject:psSpec];

        // Group 3: Activity Fields Customization
        [specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"Activity Fields & Details"
                                                              target:nil
                                                                 set:nil
                                                                 get:nil
                                                               detail:Nil
                                                           cell:PSGroupCell
                                                           edit:Nil]];

        PSSpecifier *detailsSpec = [PSSpecifier preferenceSpecifierNamed:@"Show Game Details"
                                                                  target:self
                                                                     set:@selector(setPreferenceValue:specifier:)
                                                                     get:@selector(readPreferenceValue:)
                                                                  detail:Nil
                                                                  cell:PSSwitchCell
                                                                  edit:Nil];
        [detailsSpec setProperty:@"showDetails" forKey:@"key"];
        [detailsSpec setProperty:@"com.ra1ncord.raintweak" forKey:@"defaults"];
        [specifiers addObject:detailsSpec];

        PSSpecifier *stateSpec = [PSSpecifier preferenceSpecifierNamed:@"Show Party / State"
                                                                target:self
                                                                   set:@selector(setPreferenceValue:specifier:)
                                                                   get:@selector(readPreferenceValue:)
                                                                detail:Nil
                                                                cell:PSSwitchCell
                                                                edit:Nil];
        [stateSpec setProperty:@"showState" forKey:@"key"];
        [stateSpec setProperty:@"com.ra1ncord.raintweak" forKey:@"defaults"];
        [specifiers addObject:stateSpec];

        // Group 4: Time & Timestamps
        [specifiers addObject:[PSSpecifier preferenceSpecifierNamed:@"Time & Duration"
                                                              target:nil
                                                                 set:nil
                                                                 get:nil
                                                               detail:Nil
                                                           cell:PSGroupCell
                                                           edit:Nil]];

        PSSpecifier *timeSpec = [PSSpecifier preferenceSpecifierNamed:@"Show Elapsed Time"
                                                               target:self
                                                                  set:@selector(setPreferenceValue:specifier:)
                                                                  get:@selector(readPreferenceValue:)
                                                               detail:Nil
                                                               cell:PSSwitchCell
                                                               edit:Nil];
        [timeSpec setProperty:@"showTimestamp" forKey:@"key"];
        [timeSpec setProperty:@"com.ra1ncord.raintweak" forKey:@"defaults"];
        [specifiers addObject:timeSpec];

        _specifiers = [specifiers copy];
    }
    return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.ra1ncord.raintweak"];
    [prefs setObject:value forKey:[specifier propertyForKey:@"key"]];
}

- (id)readPreferenceValue:(PSSpecifier *)specifier {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.ra1ncord.raintweak"];
    id val = [prefs objectForKey:[specifier propertyForKey:@"key"]];
    if (!val) {
        if ([[specifier propertyForKey:@"key"] isEqualToString:@"enabled"] ||
            [[specifier propertyForKey:@"key"] isEqualToString:@"isPlayStationPlatform"] ||
            [[specifier propertyForKey:@"key"] isEqualToString:@"showDetails"] ||
            [[specifier propertyForKey:@"key"] isEqualToString:@"showState"] ||
            [[specifier propertyForKey:@"key"] isEqualToString:@"showTimestamp"]) {
            return @YES;
        }
    }
    return val;
}

@end
