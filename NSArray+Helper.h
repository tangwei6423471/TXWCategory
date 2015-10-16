//
//  NSArray+Helper.h
//
//  Created by alvin on 15-7-28.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helper)

- (id)firstObject;

// 随机返回一个
- (id)randomObject;

/**
 *  返回指定位置的对象，如果数组越界则返回 nil
 *
 *  @param index
 *
 *  @return object or nil
 */
- (id)objectOrNilAtIndex:(NSUInteger)index;


/**
 The first item in the array, or nil.
 
 @return  The first item in the array, or nil.
 */

- (id)first;

/**
 The last item in the array, or nil.
 
 @return  The last item in the array, or nil.
 */

- (id)last;


/**
 A random element in the array, or nil.
 
 @return  A random element in the array, or nil.
 */

- (id)sample;


/**
 Allow subscripting to fetch elements within the specified range
 
 @param An NSValue wrapping an NSRange struct or an NSString with valid range components. If it is an NSString, it will be parsed to an NSRange. eg. @"1..3" specifying the range from 1 to 3. @"1...3" specifying the range from 1 to 2 (exclude the end value 3). Other strinig which contains two int values (@"1,3") will be parsed as range's location and length.
 
 @return An array with all the elements within the specified range
 */
- (id)objectForKeyedSubscript:(id <NSCopying>)key;


/**
 A simpler alias for `enumerateObjectsUsingBlock`
 
 @param A block with the object in its arguments.
 */

- (void)each:(void (^)(id object))block;

/**
 A simpler alias for `enumerateObjectsUsingBlock` which also passes in an index
 
 @param A block with the object in its arguments.
 */

- (void)eachWithIndex:(void (^)(id object, NSUInteger index))block;

/**
 An alias for `containsObject`
 
 @param An object that the array may or may not contain.
 */

- (BOOL)includes:(id)object;

/**
 Take the first `numberOfElements` out of the array, or the maximum amount of
 elements if it is less.
 
 @param Number of elements to take from array
 @return An array of elements
 */

- (NSArray *)take:(NSUInteger)numberOfElements;

/**
 Passes elements to the `block` until the block returns NO,
 then stops iterating and returns an array of all prior elements.
 
 @param A block that returns YES/NO
 @return An array of elements
 */
- (NSArray *)takeWhile:(BOOL (^)(id object))block;

/**
 Iterate through the current array running the block on each object and
 returning an array of the changed objects.
 
 @param A block that passes in each object and returns a modified object
 @return An array of modified elements
 */

- (NSArray *)map:(id (^)(id object))block;

/**
 Iterate through current array asking whether to keep each element.
 
 @param A block that returns YES/NO for whether the object should stay
 @return An array of elements selected
 */

- (NSArray *)select:(BOOL (^)(id object))block;

/**
 Iterate through current array returning the first element meeting a criteria.
 
 @param A block that returns YES/NO
 @return The first matching element
 */

- (id)detect:(BOOL (^)(id object))block;


/**
 Alias for `detect`. Iterate through current array returning the first element
 meeting a criteria.
 
 @param A block that returns YES/NO
 @return The first matching element
 */

- (id)find:(BOOL (^)(id object))block;

/**
 Iterate through current array asking whether to remove each element.
 
 @param A block that returns YES/NO for whether the object should be removed
 @return An array of elements not rejected
 */

- (NSArray *)reject:(BOOL (^)(id object))block;

/**
 Recurse through self checking for NSArrays and extract all elements into one single array
 
 @return An array of all held arrays merged
 */

- (NSArray *)flatten;

/**
 Alias for `componentsJoinedByString` with a default of no seperator
 
 @return A string of all objects joined with an empty string
 */

- (NSString *)join;

/**
 Alias for `componentsJoinedByString`
 
 @return A string of all objects joined with the `seperator` string
 */

- (NSString *)join:(NSString *)separator;

/**
 Run the default comparator on each object in the array
 
 @return A sorted copy of the array
 */
- (NSArray *)sort;

/**
 Sorts the array using the the default comparator on the given key
 
 @return A sorted copy of the array
 */
- (NSArray *)sortBy:(NSString*)key;

/**
 Alias for reverseObjectEnumerator.allObjects
 
 Returns a reversed array
 */
- (NSArray *)reverse;

/**
 Return all the objects that are in both self and `array`.
 Alias for Ruby's & operator
 
 @return An array of objects common to both arrays
 */

- (NSArray *)intersectionWithArray:(NSArray *)array;

/**
 Return all the objects that in both self and `array` combined.
 Alias for Ruby's | operator
 
 @return An array of the two arrays combined
 */

- (NSArray *)unionWithArray:(NSArray *)array;

/**
 Return all the objects in self that are not in `array`.
 Alias for Ruby's - operator
 
 @return An array of the self without objects in `array`
 */

- (NSArray *)relativeComplement:(NSArray *)array;

/**
 Return all the objects that are unique to each array individually
 Alias for Ruby's ^ operator. Equivalent of a - b | b - a
 
 @return An array of elements which are in either of the arrays and not in their intersection.
 */

- (NSArray *)symmetricDifference:(NSArray *)array;

@end


@interface NSMutableArray (Helper)

/**
*  插入一条数据，如果是 nil 在不会插入
*
*  @param anObject object or nil
*/
- (void)addObjectOrNil:(id)anObject;

- (void)removeFirstObject;

/**
 *  反序数组，@[ @1, @2, @3 ] -> @[ @3, @2, @1 ]
 */
- (void)reverse;

/**
 * 打乱数组顺序
 */
- (void)shuffle;

- (void)push:(id)object;
- (id)pop;
- (NSArray *)pop:(NSUInteger)numberOfElements;
- (void)concat:(NSArray *)array;

/**
 method removes the first item of an array, and returns that item
 Note: This method changes the length of an array!
 
 @return First array item or nil.
 */
- (id)shift;


/**
 method removes N first items of an array, and returns that items
 Note: This method changes the length of an array!
 
 @return Array of first N items or empty array.
 */
- (NSArray *)shift:(NSUInteger)numberOfElements;

/**
 Deletes every element of the array for which the given block evaluates to NO.
 
 @param A block that returns YES/NO
 @return An array of elements
 */

- (NSArray *)keepIf:(BOOL (^)(id object))block;


@end