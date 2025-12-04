# HarmonyOS 手势与导航 - Cursor Rules

你正在为HarmonyOS应用开发相关功能。以下是你需要遵循的开发规则。

## 核心原则

-   **事件精准控制**: 理解触摸事件冒泡机制和响应链，通过精确控制确保手势交互符合预期。
-   **路由统一管理**: 利用HMRouter提供的注解和API，简化页面跳转，统一管理页面栈和参数传递。
-   **导航体验至上**: 选择合适的导航样式（如底部导航），并注重图标、文字和点击区域的用户体验。
-   **优先框架能力**: 优先使用HarmonyOS提供的`Tabs`、`HMRouter`等官方组件和框架能力。

## 推荐做法

### 代码结构
-   **页面路由注册**: 使用`@HMRouter`注解清晰地为每个可跳转页面定义唯一路由标识 (`pageUrl`)。
-   **Tab内容封装**: 将`TabContent`及其`tabBar`的构建逻辑封装为独立的`@Builder`方法，提高复用性和可维护性。
-   **手势逻辑内聚**: 将组件的手势处理逻辑（如`onTouch`、`onPan`等）直接绑定在组件内部，避免过度依赖父组件处理。

### 最佳实践
-   **手势事件处理**:
    -   明确区分`onTouch`（基础触摸事件）与高级手势事件（如`onClick`、`onPan`）。
    -   利用`hitTestBehavior`属性（`Default`、`Transparent`、`Block`）精准控制组件的触摸测试行为，影响事件响应链构建。
    -   在特定场景下，使用`event.stopPropagation()`立即阻止触摸事件向上冒泡，防止父组件响应。
-   **页面跳转与传参**:
    -   使用`HMRouterMgr.push()`或`replace()`进行页面跳转，并通过`param`参数传递数据。
    -   在目标页面的`aboutToAppear`生命周期中，通过`HMRouterMgr.getCurrentParam()`获取跳转参数。
    -   通过`push/replace`方法的`onResult`回调接收返回数据，并根据`srcPageInfo.name`判断返回源。
    -   在多`HMNavigation`组件场景中，务必为`HMRouterMgr`方法指定正确的`navigationId`。
-   **底部导航实现**:
    -   使用`Tabs`组件作为底部导航容器，设置`barPosition: BarPosition.End`。
    -   在`TabContent`的`tabBar`属性中，使用`Image`和`Text`组合定义页签样式，并区分选中/未选中状态。
    -   合理设置`barHeight`、`backgroundColor`和`barMode: Fixed`，确保视觉和交互体验。

## 禁止做法

-   **盲目阻塞事件**: 在不完全理解组件树和事件分发机制的情况下，滥用`hitTestBehavior.Block`或`stopPropagation()`，可能导致用户交互失效。
-   **多导航未识别**: 在有多个`HMNavigation`组件的应用中，不指定`navigationId`进行页面跳转，可能导致路由混乱或跳转失败。
-   **导航样式不清晰**: 底部导航的图标或文字模糊不清、点击区域过小，或选中/未选中状态区分不明显，影响用户识别和操作。

## 代码示例

### 推荐写法
```arkts
// 手势冲突解决：独占触摸事件
Column() {
  Text('我独占触摸事件')
    .width(100).height(100).backgroundColor(Color.Red)
    .hitTestBehavior(HitTestMode.Block) // 独占触摸事件
    .onClick(() => console.log('红色区域被点击'))
}
.onClick(() => console.log('父级区域被点击')); // 红色区域点击时，父级不会响应

// HMRouter页面跳转与参数传递
// 页面注册 (在目标页面顶部):
@HMRouter({ pageUrl: 'pages/DetailPage' })
struct DetailPage { /* ... */ }

// 跳转并接收返回结果:
HMRouterMgr.push('pages/DetailPage', {
  param: { id: 123, name: 'Test' },
  onResult: (info: HMPopInfo) => {
    if (info.srcPageInfo.name === 'pages/SomePage') {
      console.log(`从SomePage返回，结果: ${JSON.stringify(info.result)}`);
    }
  }
});

// 底部导航:
Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
  TabContent() { Text('消息页面').fontSize(20) }
    .tabBar($r('app.string.message'), this.currentIndex === 0 ? $r('app.media.activeMessage') : $r('app.media.message'))
  TabContent() { Text('我的页面').fontSize(20) }
    .tabBar($r('app.string.mine'), this.currentIndex === 1 ? $r('app.media.activeMine') : $r('app.media.mine'))
}
.barHeight(56)
.barMode(BarMode.Fixed)
.backgroundColor(Color.White);

// Builder for tabBar (optional, for cleaner code)
@Builder
tabBar(text: Resource, icon: Resource) {
  Column() {
    Image(icon).width(24).height(24)
    Text(text).fontSize(10).fontColor(Color.Black)
  }
}
```

### 避免写法
```arkts
// 手势冲突：未处理嵌套点击冲突
Column() {
  Text('内部按钮')
    .width(100).height(100).backgroundColor(Color.Red)
    .onClick(() => console.log('内部按钮被点击'))
}
.onClick(() => console.log('外部区域被点击'));
// 点击红色区域时，外部区域也可能响应，导致意外行为。

// HMRouter：不处理多NavigationId
// 假设存在多个HMNavigation组件，但跳转时未指定navigationId
HMRouterMgr.push('pages/DetailPage', { param: { id: 123 } });
// 可能跳转到错误的Navigation栈中。
```

## 注意事项

-   `hitTestBehavior`和`stopPropagation()`是强大的手势冲突解决工具，但需谨慎使用，避免过度阻塞导致用户交互失效。
-   `HMRouterMgr.onResult`回调会在任何页面pop回当前页面时触发，务必通过`HMPopInfo.srcPageInfo.name`判断返回源，进行精确处理。
-   HMRouter还支持路由拦截、单例页面、Dialog页面等高级功能，建议查阅官方文档以实现更复杂的导航需求。
-   在设计底部导航时，考虑不同设备屏幕尺寸，确保图标和文字在视觉上清晰，且点击区域足够大，易于操作。