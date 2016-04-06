# iOS容器类安全保护
## 原因
在实际的项目中，经常会遇到这样的错误  
![1](https://raw.githubusercontent.com/decemberLi/WQContainerSafe/master/1.png)  

![2](https://raw.githubusercontent.com/decemberLi/WQContainerSafe/master/2.png)  

![3](https://raw.githubusercontent.com/decemberLi/WQContainerSafe/master/3.png)  

他们分别是因为添加nil到NSDictionary，添加nil到NSArray，数组越界。为了防止这些因为代码疏忽而造成的崩溃，所以写了WQContainerSafe这个类。
## 类介绍
这文件一定要在工程中弄成mrc的。不然会有这样一个bug   在弹出键盘后home出程序就会crash，并且最后报`[UIKeyboardLayoutStar release]`这样一个错误

WQContainerSafe这个类只有`WQContainerSafe.m`这一个文件。它并不会要求在其他代码的地方引用，调用它，只需要把该文件加到工程里面即可。  
```Objective-C
+(void) load {
  //code
}
```
`load`函数是在一个类第一次初始化的时候调用的。
* 一个类的+load方法在其父类的+load方法后调用
* 一个Category的+load方法在被其扩展的类的自有+load方法后调用

所以在`WQContainerSafe.m`文件里面我们实现了NSArray和NSMutableDictionary的load方法。然后利用`runtime`中`method_exchangeImplementations`方法来替换原有的`objectAtIndex`、`insertObject:atIndex:`、`setObject:forKey:`方法。在新的方法里面写上越界保护，nil保护。

## 遇到的坑
1. 用方法交换做NSArray的越界保护，要交换3个类的objectAtIndex:方法： `__NSArrayM (可变数组)` `__NSArrayI (一般数组)` `__NSArray0 (一般的空数组)` ,而且不能用NSArrayI的objectiveAtIndex方法替换NSArrayM的。
2. NSArray的`addObject`方法最终会走到`insertObject:atIndex:`这个方法，所以只用替换后者就可以了。

## TODO
1. 现在只支持了`NSArray`和`NSDictionary`，以后会添加其他容器的支持
