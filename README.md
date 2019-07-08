# course1HelloWorld
macOS开发教程第一篇，Hello World
## 前言
最近因为忽然间有一些灵感，想要做一款基于macOS的app。因为之前一直在开发iOS，感觉macOS应该也是类似，结果一上手，差点被劝退。因此决定慢慢来，将自己的心得记录下来。

## 正文

这系列文章不会从讲述Swift或Objective-c语言的语法细节。因此如果是纯小白开发，请先行自学语言。

注: 文章系列将会用Swift语言进行全部内容的开发

### 项目的创建

首先我们需要选择**macOS**，选择 **`Cocoa App`**，接下来点击 **Next**

![create](http://www.img.wdtechnology.club/201907/create.png)

#### 从storyboard创建项目

从`storyboard`创建工程应该是我最不喜欢的一种方式了，因为觉得故事版这种方式与代码对应关系很弱，而且它又同样拥有着xib修改起来费时费力的缺点。

1. **项目的创建与运行**

![input](http://www.img.wdtechnology.club/201907/input.png)

在这里我们输入工程名**HelloWorldStoryBoard**，然后选择项目存储地址后。我们的工程目录将如这个样子

![helloword_storyboard_file](http://www.img.wdtechnology.club/201907/helloword_storyboard_file.png)

我们直接按住 **`Command`** + **`R`** 运行程序，将会有一个窗口展示出来，里面什么都没有

接下来我们要试着让这个窗口中展示出一个"Hello World!"

2. **storyboard文件中添加Label**

我们点击 **Main.storyboard** 文件

![storyboard_file](http://www.img.wdtechnology.club/201907/storyboard_file.png)

现在我们来增加一个Label控件:

![storyboard_choose_label](http://www.img.wdtechnology.club/201907/storyboard_choose_label.png)

然后在随后的输入框中输入 **Label** ,拖曳第一项至ViewController的View中。

![storyboard_search](http://www.img.wdtechnology.club/201907/storyboard_search.png)

![storyboard_label](http://www.img.wdtechnology.club/201907/storyboard_label.png)

3. **给Label设置字体、约束**

接下来为这个Label增加一个水平居中和垂直居中的约束，并调大加粗字体。更换文字为`Hello World`。

注: 这里的粒度因需帮助对于iOS开发不是很熟悉的人入门，因此较为细了一点

![storyboard_label_setting](http://www.img.wdtechnology.club/201907/storyboard_label_setting.png)

修改之后的结果

![storyboard_label_setting_result](http://www.img.wdtechnology.club/201907/storyboard_label_setting_result.png)

运行下，就可以看见大大的 Hello World 展示出来了

#### 从Xib项目中初始化

Xib项目的初始化和storyboard的是类似的，只是不勾选 `Use Storyboards`

这里的步骤，就不上图片了

创建好后，文件结构如下:

![helloworld_xib_file](http://www.img.wdtechnology.club/201907/helloworld_xib_file.png)

这时候我们点击MainMenu.xib

![xib_file](http://www.img.wdtechnology.club/201907/xib_file.png)

和storyboard一样，我们直接运行，将会出现一个空窗口。

接下来，我们也是按照storyboard的步骤向xib中增加一个Hello World的label。增加的步骤也是类似这里就不多讲述了。

#### 纯代码创建项目

ps: **纯代码**创建 macOS app 费了我好长时间，最开始以为只需要删除 **MainMenu.xib** 就可以了，别的步骤就和iOS中的一样，初始化AppDelegate中的window就足够了。但是，竟然运行不起来，没有效果。

1. **项目的创建与运行**

我们还是按照xib的步骤创建一个新项目。因为我们是纯代码，因此删除对应xib文件。

![helloworld_code_file](http://www.img.wdtechnology.club/201907/helloworld_code_file.png)

接着我们运行一下程序。将会发现如下错误:

> 2019-07-06 07:35:04.623078+0800 HelloWorld[20092:864470] Unable to load nib file: MainMenu, exiting

意思就是没有找到对应的xib文件，所以程序退出了，毕竟我们已经删除了这个xib文件了。

所以接下来我们点击最上面的HelloWorld工程，并清空对应的入口文件(这里和iOS的清空方式一样)

![helloworld_code_clean_entry](http://www.img.wdtechnology.club/201907/helloworld_code_clean_entry.png)

这里的Main Interface代表着项目的可视化界面入口。因为是纯代码页面，我们并没有这些入口，所以直接清空就可以了。

再次尝试运行，会发现没有异常错误了，但是程序并没有任何窗口弹出。

按照iOS的既有操作流程，我们需要在AppDelegate的函数`func applicationDidFinishLaunching(_ aNotification: Notification)` 进行window的初始化与rootViewController的设置

不过在这之前，我们先打印

```swift
func applicationDidFinishLaunching(_ aNotification: Notification) {
    print("Hello World!")
}
```

运行会发现，控制台不输出我们的打印对象，说明方法并没有执行，问题出现在哪里了呢?

**问题解释**

这里就要说macOS App中比较坑的地方了(尤其是和Swift结合)，因为在xib和storyboard中创建应用，系统都会帮我们默认指定一个入口。

随后会执行main函数，这个main函数在iOS中的参数有4个

```ObjectiveC
/// iOS main函数启动方法
int UIApplicationMain(int argc, char * _Nullable argv[_Nonnull], NSString * _Nullable principalClassName, NSString * _Nullable delegateClassName);
```

其中后面两个参数分别是`UIApplication`类的类名与`AppDelegate`类的类名。

在iOS中，我们无需关心AppDelegate类的初始化，它会很自然的通过main函数里的方法被初始化了。

这点在Swift中尤为明显，我们在Swift中一般点击AppDelegate可以看到`@UIApplicationMain`便相当于main函数了，因此在iOS中我们如果采用同样的操作，可以发现iOS中的AppDelegate里的`func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool`，将会被调用

而在macOS的app中，main函数如下:

```ObjectiveC
APPKIT_EXTERN int NSApplicationMain(int argc, const char *__nonnull argv[__nonnull]);
```

比iOS中的对应参数少了后两个，也就是说，如果我们使用`@NSApplicationMain`的话，`AppDelegate`这个类将不会被自动初始化。这也许就是我们添加的`print`函数不执行的原因。

为了进一步确定真实原因，我们再做如下测试，重写`init()`方法

```swift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    override init() {
        super.init()
        print("执行到这了")
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
```

执行代码，发现控制台什么也没有输出。由此可以确定`@NSApplicationMain`并没有帮我们自动初始化`AppDelegate`类。因此我们需要自己初始化了。

这里引申一下，为什么Xib和Storyboard都能成功初始化AppDelegate呢?

我们看下xib工程中的MainMenu.xib文件

![helloworld_appdelegate](http://www.img.wdtechnology.club/201907/helloworld_appdelegate.png)

因为xib中的Delegate的类为`AppDelegate`，我们继续观察

![delegate_property](http://www.img.wdtechnology.club/201907/delegate_property.png)

这里我们就可以看出来了，在xib的启动环境下，系统先读取了`MainMenu.xib`,然后通过xib初始化了`NSApplication`并且初始化了`AppDelegate`。

----

我们已经知道了，`@NSApplicationMain`不会替我们初始化`AppDelegate`，那么我们便需要自己对相关参数进行处理。

所以我们在项目工程中新建`main.swift`文件

```swift
import Cocoa

/// 我们需要先初始化AppDelegate，并强引用该对象防止其释放
let delegate = AppDelegate()
/// 将delegate赋值
NSApplication.shared.delegate = delegate
/// 调用NSApplicationMain 传入外界的入参
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
```

接下来将`AppDelegate`中的`@NSApplicationMain`删除，并运行代码

我们能看见控制台打印出了我们的输出了。下一步我们就是展示出窗口了。

2. **窗口的展示**

我们替换`AppDelegate`中原有的`@IBOutlet weak var window: NSWindow!` 为 `var window: NSWindow`

并将`init()`函数更改如下:

```swift
override init() {
    /// 在swift中我们需要在调用父类的初始化方法前，先初始化好子类的相关参数
    window = NSWindow(
        contentRect: CGRect(x: 0, y: 0, width: 800, height: 500), // 展示的区域
        styleMask: [.closable, .titled], // 展示的类型，这里我们暂时选择 可以关闭 与 展示标题栏
        backing: .buffered, // 所有其他种类均被废弃了，只剩.buffered
        defer: false // 是否推迟创建window
    )
    super.init()
}
```

更改`func applicationDidFinishLaunching(_ aNotification: Notification)`函数:

```swift
func applicationDidFinishLaunching(_ aNotification: Notification) {
    window.makeKeyAndOrderFront(nil)
}
```

运行程序，我们可以看见窗口弹出来了

3. **Hello world的展示**

这里就直接贴代码了

```swift
func applicationDidFinishLaunching(_ aNotification: Notification) {
    /// 设置label需要的宽度
    let width: CGFloat = 300
    /// 设置label需要的高度
    let height: CGFloat = 30
    /// 获取window的窗口的frame
    var frame = window.frame
    /// 设置x、y、width、height
    frame.origin.x = (frame.width - width) / 2
    frame.origin.y = (frame.height - height) / 2
    frame.size = CGSize(width: width, height: height)

    /// 因为MacOS中并无一个独立的Label组件，所以我们使用TextField替代
    let label = NSTextField(frame: frame)
    /// 设置字号
    label.font = .systemFont(ofSize: 30, weight: NSFont.Weight(rawValue: 3))
    /// 设置字符
    label.stringValue = "Hello World!"
    /// 设置居中
    label.alignment = .center
    /// 下面的都是取消NSTextField的一些与显示无关属性的
    /// 取消背景的边框
    label.isBezeled = false
    /// 不可编辑
    label.isEditable = false
    /// 不可被选中
    label.isSelectable = false
    /// 不展示背景颜色
    label.drawsBackground = false
    /// 将label加入到window的contentView上
    window.contentView?.addSubview(label)
    /// 展示ContentView
    window.makeKeyAndOrderFront(nil)
}
```

运行下程序，我们可以看到一个带着Hello World的窗口展示在屏幕上了

## 结尾

[本文demo地址](https://github.com/macosappcourse/course1HelloWorld)

macOS的app和iOS的app开发上有着许多相似的地方，但是又有很多差异非常大的地方。所以很多时候，我们不能用开发iOS的经验进行macOS的开发。

本文是《macOS软件开发》系列的第一篇，有什么不足与值得改进的地方，请在评论区指出或者直接在公众号私信给我，看到一定回复

![gongzhonghao](http://www.img.wdtechnology.club/201907/gongzhonghao.jpg)
