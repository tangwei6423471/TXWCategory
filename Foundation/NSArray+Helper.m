//
//  NSArray+Helper.m
//
//  Created by alvin on 15-7-28.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "NSArray+Helper.h"
#import "NSString+ObjectiveSugar.h"

@implementation NSArray (Helper)
- (id)firstObject {
    if (self.count)
        return self[0];
    return nil;
}

- (id)randomObject {
	if (self.count) {
	    return self[arc4random_uniform((int)self.count)];
	}
    return nil;
}

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

- (id)first {
    if (self.count > 0)
        return self[0];
    
    return nil;
}

- (id)last {
    return [self lastObject];
}

- (id)sample {
    if (self.count == 0) return nil;
    
    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    
    return self[index];
}

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
    NSRange range;
    if ([(id)key isKindOfClass:[NSString class]]) {
        NSString *keyString = (NSString *)key;
        range = NSRangeFromString(keyString);
        if ([keyString containsString:@"..."]) {
            range = NSMakeRange(range.location, range.length - range.location);
        } else if ([keyString containsString:@".."]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
    } else if ([(id)key isKindOfClass:[NSValue class]]) {
        range = [((NSValue *)key) rangeValue];
    } else {
        [NSException raise:NSInvalidArgumentException format:@"expected NSString or NSValue argument, got %@ instead", [(id)key class]];
    }
    
    return [self subarrayWithRange:range];
}


- (void)each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithIndex:(void (^)(id object, NSUInteger  index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (BOOL)includes:(id)object {
    return [self containsObject:object];
}

- (NSArray *)take:(NSUInteger)numberOfElements {
    numberOfElements = MIN(numberOfElements, [self count]);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [array addObject:self[i]];
    }
    
    return array;
}

- (NSArray *)takeWhile:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id arrayObject in self) {
        if (block(arrayObject))
            [array addObject:arrayObject];
        
        else break;
    }
    
    return array;
}

- (NSArray *)map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        id newObject = block(object);
        if (newObject) {
            [array addObject:newObject];
        }
    }
    
    return array;
}

- (NSArray *)select:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (id)detect:(BOOL (^)(id object))block {
    
    for (id object in self) {
        if (block(object))
            return object;
    }
    
    return nil;
}

- (id)find:(BOOL (^)(id object))block {
    return [self detect:block];
}

- (NSArray *)reject:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object) == NO) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSArray *)flatten {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in self) {
        if ([object isKindOfClass:NSArray.class]) {
            [array concat:[object flatten]];
        } else {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSString *)join {
    return [self componentsJoinedByString:@""];
}

- (NSString *)join:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

- (NSArray *)sort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)sortBy:(NSString*)key; {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *)reverse {
    return self.reverseObjectEnumerator.allObjects;
}

#pragma mark - Set operations

- (NSArray *)intersectionWithArray:(NSArray *)array {
    NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    return [self filteredArrayUsingPredicate:intersectPredicate];
}

- (NSArray *)unionWithArray:(NSArray *)array {
    NSArray *complement = [self relativeComplement:array];
    return [complement arrayByAddingObjectsFromArray:array];
}

- (NSArray *)relativeComplement:(NSArray *)array {
    NSPredicate *relativeComplementPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:relativeComplementPredicate];
}

- (NSArray *)symmetricDifference:(NSArray *)array {
    NSArray *aSubtractB = [self relativeComplement:array];
    NSArray *bSubtractA = [array relativeComplement:self];
    return [aSubtractB unionWithArray:bSubtractA];
}


@end


@implementation NSMutableArray (Helper)

- (void)addObjectOrNil:(id)anObject{
    if (anObject) {
        [self addObject:anObject];
    }
}


- (void)removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)reverse {
    int count = (int)self.count;
    int mid = floor(count / 2.0);
    for (int i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1) withObjectAtIndex:arc4random_uniform((int)i)];
    }
}

- (void)push:(id)object {
    [self addObject:object];
}

- (id)pop {
    id object = [self lastObject];
    [self removeLastObject];
    
    return object;
}

- (NSArray *)pop:(NSUInteger)numberOfElements {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++)
        [array insertObject:[self pop] atIndex:0];
    
    return array;
}

- (void)concat:(NSArray *)array {
    [self addObjectsFromArray:array];
}

- (id)shift {
    NSArray *result = [self shift:1];
    return [result first];
}

- (NSArray *)shift:(NSUInteger)numberOfElements {
    NSUInteger shiftLength = MIN(numberOfElements, [self count]);
    
    NSRange range = NSMakeRange(0, shiftLength);
    NSArray *result = [self subarrayWithRange:range];
    [self removeObjectsInRange:range];
    
    return result;
}

- (NSArray *)keepIf:(BOOL (^)(id object))block {
    for (NSUInteger i = 0; i < self.count; i++) {
        id object = self[i];
        if (block(object) == NO) {
            [self removeObject:object];
        }
    }
    
    return self;
}

@end
