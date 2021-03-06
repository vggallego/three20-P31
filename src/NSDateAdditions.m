#import "Three20/TTGlobal.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NSDate (TTCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (NSDate*)dateWithToday {
  NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
  formatter.dateFormat = @"yyyy-d-M";
  
  NSString* time = [formatter stringFromDate:[NSDate date]];
  NSDate* date = [formatter dateFromString:time];
  return date;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (NSDate*)dateAtMidnight {
  NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
  formatter.dateFormat = @"yyyy-d-M";
  
  NSString* time = [formatter stringFromDate:self];
  NSDate* date = [formatter dateFromString:time];
  return date;
}

- (NSString*)formatTime {
  static NSDateFormatter* formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = TTLocalizedString(@"h:mm a", @"Date format: 1:05 pm");
    formatter.locale = TTCurrentLocale();
  }
  return [formatter stringFromDate:self];
}

- (NSString*)formatDate {
  static NSDateFormatter* formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =
      TTLocalizedString(@"EEEE, LLLL d, YYYY", @"Date format: Monday, July 27, 2009");
    formatter.locale = TTCurrentLocale();
  }
  return [formatter stringFromDate:self];
}

- (NSString*)formatShortTime {
  NSTimeInterval diff = abs([self timeIntervalSinceNow]);
  if (diff < TT_DAY) {
    return [self formatTime];
  } else if (diff < TT_WEEK) {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
      formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = TTLocalizedString(@"EEEE", @"Date format: Monday");
      formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
  } else {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
      formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = TTLocalizedString(@"M/d/yy", @"Date format: 7/27/09");
      formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
  }
}

- (NSString*)formatDateTime {
  NSTimeInterval diff = abs([self timeIntervalSinceNow]);
  if (diff < TT_DAY) {
    return [self formatTime];
  } else if (diff < TT_WEEK) {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
      formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = TTLocalizedString(@"EEE h:mm a", @"Date format: Mon 1:05 pm");
      formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
  } else {
    static NSDateFormatter* formatter = nil;
    if (!formatter) {
      formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = TTLocalizedString(@"MMM d h:mm a", @"Date format: Jul 27 1:05 pm");
      formatter.locale = TTCurrentLocale();
    }
    return [formatter stringFromDate:self];
  }
}

- (NSString*)formatRelativeTime {
  NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
  if (elapsed <= 1) {
    return TTLocalizedString(@"just a moment ago", @"");
  } else if (elapsed < TT_MINUTE) {
    int seconds = (int)(elapsed);
    return [NSString stringWithFormat:TTLocalizedString(@"%d seconds ago", @""), seconds];
  } else if (elapsed < 2*TT_MINUTE) {
    return TTLocalizedString(@"about a minute ago", @"");
  } else if (elapsed < TT_HOUR) {
    int mins = (int)(elapsed/TT_MINUTE);
    return [NSString stringWithFormat:TTLocalizedString(@"%d minutes ago", @""), mins];
  } else if (elapsed < TT_HOUR*1.5) {
    return TTLocalizedString(@"about an hour ago", @"");
  } else if (elapsed < TT_DAY) {
    int hours = (int)((elapsed+TT_HOUR/2)/TT_HOUR);
    return [NSString stringWithFormat:TTLocalizedString(@"%d hours ago", @""), hours];
  } else {
    return [self formatDateTime];
  }
}

- (NSString*)formatShortRelativeTime
{
	NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
	if( elapsed <= TT_MINUTE )
	{
		return @"<1m";
	}
	else if( elapsed < TT_HOUR )
	{
		int mins = (int)( elapsed / TT_MINUTE );
		return [NSString stringWithFormat:@"%dm", mins];
	}
	else if( elapsed < TT_DAY )
	{
		int hours = (int)( ( elapsed + TT_HOUR / 2 ) / TT_HOUR );
		return [NSString stringWithFormat:@"%dh", hours];
	}
	else if( elapsed < TT_WEEK )
	{
		int day = (int)( ( elapsed + TT_DAY / 2 ) / TT_DAY );
		return [NSString stringWithFormat:@"%dd", day];
	}
	else
	{
		return [self formatShortTime];
	}
}

- (NSString*)formatDay:(NSDateComponents*)today yesterday:(NSDateComponents*)yesterday {
  static NSDateFormatter* formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = TTLocalizedString(@"MMMM d", @"Date format: July 27");
    formatter.locale = TTCurrentLocale();
  }

  NSCalendar* cal = [NSCalendar currentCalendar];
  NSDateComponents* day = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                               fromDate:self];

  if (day.day == today.day && day.month == today.month && day.year == today.year) {
    return TTLocalizedString(@"Today", @"");
  } else if (day.day == yesterday.day && day.month == yesterday.month
             && day.year == yesterday.year) {
    return TTLocalizedString(@"Yesterday", @"");
  } else {
    return [formatter stringFromDate:self];
  }
}

- (NSString*)formatMonth {
  static NSDateFormatter* formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = TTLocalizedString(@"MMMM", @"Date format: July");
    formatter.locale = TTCurrentLocale();
  }
  return [formatter stringFromDate:self];
}

- (NSString*)formatYear {
  static NSDateFormatter* formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = TTLocalizedString(@"yyyy", @"Date format: 2009");
    formatter.locale = TTCurrentLocale();
  }
  return [formatter stringFromDate:self];
}

@end
