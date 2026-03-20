#import <Foundation/Foundation.h>

#define LOG_PREFIX         @"[Rain]"
#define BunnyLog(fmt, ...) NSLog((LOG_PREFIX @" " fmt), ##__VA_ARGS__)