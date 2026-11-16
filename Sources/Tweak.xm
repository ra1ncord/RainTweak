#import <HBPreferences.h>
#import <UIKit/UIKit.h>

%hook DiscordRichPresenceManager

- (void)updateActivity:(NSMutableDictionary *)activity {
    %orig(activity);
    
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.ra1ncord.raintweak"];
    
    // مفتاح التفعيل العام
    BOOL enabled = [prefs boolForKey:@"enabled" default:YES];
    if (!enabled) return;

    // الخيارات المرنة للتحكم
    BOOL isPlayStation = [prefs boolForKey:@"isPlayStationPlatform" default:YES];
    BOOL showDetails = [prefs boolForKey:@"showDetails" default:YES];
    BOOL showState = [prefs boolForKey:@"showState" default:YES];
    BOOL showTimestamp = [prefs boolForKey:@"showTimestamp" default:YES];

    // محاكاة منصة بلايستيشن أو الكمبيوتر
    if (isPlayStation) {
        [activity setObject:@"playstation_large_icon" forKey:@"largeImageKey"];
        [activity setObject:@"PlayStation 5" forKey:@"largeImageText"];
        [activity setObject:@"playstation_badge" forKey:@"smallImageKey"];
        [activity setObject:@"Playing on PlayStation 5" forKey:@"smallImageText"];
    } else {
        [activity setObject:@"pc_gaming_icon" forKey:@"largeImageKey"];
        [activity setObject:@"PC Gaming (Windows)" forKey:@"largeImageText"];
    }

    // تفاصيل اللعبة (اختياري تفعيلها أو إيقافها)
    if (showDetails) {
        [activity setObject:@"Playing Marvel Rivals" forKey:@"details"];
    } else {
        [activity removeObjectForKey:@"details"];
    }

    // حالة اللعب أو الـ Party (اختياري)
    if (showState) {
        [activity setObject:@"In Celestial Lobby (2/4)" forKey:@"state"];
    } else {
        [activity removeObjectForKey:@"state"];
    }

    // الطابع الزمني والوقت المنقضي (اختياري)
    if (!showTimestamp) {
        [activity removeObjectForKey:@"timestamps"];
    }
}

%end
