//
//  CLTagVeiw.m
//  CLTagVeiw
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 Apple. All rights reserved.
//


#import "CLTagView.h"
#import "CLTagVeiwCell.h"
#import "CLTagUICongfig.h"

@interface CLTagViewFlowLayout ()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CLTagViewType selectType;

@end

@implementation CLTagViewFlowLayout

- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;     //
    
    self.itemAttributes = [NSMutableArray array];
}


- (void)prepareLayout {
    [super prepareLayout];
    
    [self.itemAttributes removeAllObjects];
    
    self.contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;      //
    CGFloat originY = self.sectionInset.top;       //
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    
    //   这里是布局算法
    for (NSInteger index = 0; index < itemCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        //   为什么这里的 width 不是 100  ？？？   why
        CGSize itemSize = [self itemSizeWithIndexPath:indexPath];
        
        if ((originX + itemSize.width + self.minimumInteritemSpacing + self.sectionInset.right) > self.collectionView.frame.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    self.contentHeight += self.sectionInset.bottom;
}


- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

- (id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (!_delegate) {
        _delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}


//  获取 indexPath 所在位置的 item 的大小
- (CGSize)itemSizeWithIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    return self.itemSize;
}


@end






@interface CLTagView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
//
@property (nonatomic, strong) CLTagUICongfig *congfig;


// 处理事件的block
@property (nonatomic, copy) CLSelectItemHandler handler;

@end


static NSString * const reuseIdentifier = @"CLTagView";


@implementation CLTagView



- (instancetype)initWithFrame:(CGRect)frame tagsArray:(NSArray *)tags config:(CLTagUICongfig *)config  didSelectItemHandler:(CLSelectItemHandler)handler
{
    if (self = [super initWithFrame:frame]) {
        _congfig = config;
        _handler = handler;
        _tags = tags;
        [self setup];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {

    _selectTags = [NSMutableArray array];
    
    
    CLTagViewFlowLayout *layout = [[CLTagViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(self.congfig.topMargin, self.congfig.leftMargin, self.congfig.bottomMargin, self.congfig.rightMargin);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView registerClass:[CLTagVeiwCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];

    
    
    [self addSubview:self.collectionView];
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_collectionView)];
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_collectionView)];
    
    [self addConstraints:constraint_H];
    [self addConstraints:constraint_V];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLTagVeiwCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = self.congfig.tagBackGroundColor;
    cell.layer.borderColor = self.congfig.tagBorderColor.CGColor;
    cell.layer.cornerRadius = self.congfig.tagCornerRadius;
    
    
    [cell.titleLabel setFont:[UIFont systemFontOfSize:self.congfig.textSize]];
    
    if ([_selectTags containsObject:self.tags[indexPath.row]]) {
        cell.layer.borderColor = self.congfig.tagSelectBorderColor.CGColor;
        [cell.titleLabel setTextColor:self.congfig.tagSelectColor];
    } else {
        cell.layer.borderColor = self.congfig.tagBorderColor.CGColor;
        [cell.titleLabel setTextColor:self.congfig.tagColor];
    }
    
    [cell.titleLabel setText:self.tags[indexPath.row]];
    
    return cell;
}




// 这里可以使用一个协议来进一步封装
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CLTagVeiwCell *selectCell = (CLTagVeiwCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    switch (self.congfig.selectType) {
        case 0:
        {
            if (_selectTags.count) {
                [_selectTags removeAllObjects];
            }
            
            [_selectTags addObject:self.tags[indexPath.row]];
            
            if (self.handler) {
                self.handler(_selectTags);
            }
        }
            break;
        case 1:
        {
            if ([_selectTags containsObject:self.tags[indexPath.row]]) {
                selectCell.layer.borderColor = self.congfig.tagBorderColor.CGColor;
                [selectCell.titleLabel setTextColor:self.congfig.tagColor];
                [_selectTags removeObject:self.tags[indexPath.row]];
            } else {
                selectCell.layer.borderColor = self.congfig.tagSelectBorderColor.CGColor;
                [selectCell.titleLabel setTextColor:self.congfig.tagSelectColor];
                [_selectTags addObject:self.tags[indexPath.row]];
            }
            
            if (self.handler) {
                self.handler(_selectTags);
            }

        }
            break;
            
        default:
            break;
    }
  
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLTagViewFlowLayout *layout = (CLTagViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = [self.tags[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.congfig.textSize]} context:nil];
    
    return CGSizeMake(frame.size.width + self.congfig.textSpace, self.congfig.everyTagContentHeight);
}



#pragma mark - setter getter

- (CLTagUICongfig *)congfig
{
    if (_congfig == nil) {
        _congfig = [[CLTagUICongfig alloc] init];
    }
    return _congfig;
}



@end
