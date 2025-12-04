# HarmonyOS 主题与样式 - Cursor Rules

你正在为HarmonyOS应用开发相关功能。以下是你需要遵循的开发规则。

## 核心原则

-   **优先使用系统机制**：充分利用HarmonyOS提供的资源管理和系统API进行主题和亮度适配。
-   **以用户体验为中心**：确保UI在不同模式下保持易读、舒适和一致，提供灵活的用户偏好设置。
-   **模块化与可维护性**：通过资源文件统一管理样式，避免硬编码，提高代码的可维护性和扩展性。
-   **性能与功耗优化**：合理管理屏幕亮度与常亮状态，减少不必要的电量消耗。

## 推荐做法

### 代码结构
-   **资源目录分层**：在`src/main/resources`下创建`base`（浅色模式默认）和`dark`（深色模式）目录，并在这两个目录中定义**同名**的资源文件（如`element/color.json`, `media/your_image.png`）。
-   **统一资源引用**：所有颜色、尺寸、字符串等资源应通过`$('app.color.your_color_name')`等方式引用，而非硬编码。

### 最佳实践
-   **深色模式适配**：
    *   **颜色与媒体**：在`base/element/color.json`和`dark/element/color.json`中分别定义深浅模式下的颜色值。对于SVG图标，优先使用`fillColor()`属性使其颜色随主题自适应；非SVG图片则在`base/media`和`dark/media`下放置同名图片资源。
    *   **状态栏**：确保状态栏背景色和内容字体颜色（如时间、信号）能与应用当前深浅模式保持协调一致。
    *   **跟随系统主题**：通过`applicationContext.setColorMode(ColorMode.COLOR_MODE_NOT_SET)`使应用跟随系统深浅色模式切换。
-   **页面亮度管理**：
    *   **页面级亮度**：针对特定功能页面（如视频播放、付款码），使用`window.setWindowBrightness()`动态设置其专属亮度。利用`uiObserver.on('navDestinationUpdate')`监听页面跳转，在进入时应用特定亮度，离开时恢复系统或前页亮度。
    *   **屏幕常亮**：在沉浸式场景（如视频播放）中，通过`window.setWindowKeepScreenOn(true)`保持屏幕常亮。务必在操作结束后（如暂停、退出）及时调用`window.setWindowKeepScreenOn(false)`关闭常亮。
    *   **用户亮度调节**：为用户提供`Slider`组件，绑定`window.setWindowBrightness()`，允许用户在特定页面手动调节屏幕亮度。

## 禁止做法

-   **硬编码样式**：禁止在代码中直接硬编码颜色值、字体大小、图片路径等，这会严重阻碍主题适配和维护。
-   **未经管理的屏幕常亮**：避免在非必要情况下长时间开启屏幕常亮，导致设备发热和电量快速消耗。
-   **主题切换不一致**：深色模式下UI元素对比度过低、文字不可读，或部分区域未适配导致视觉割裂。
-   **页面亮度未恢复**：在页面跳转或应用退出时，未将动态设置的亮度恢复到系统或用户预期状态。

## 代码示例

### 推荐写法
```arkts
// 颜色资源引用与深色模式适配
Text('Hello HarmonyOS')
  .fontColor($r('app.color.text_color')); // text_color在base/dark的color.json中定义

// 页面亮度设置
aboutToAppear() {
  // 进入页面时设置特定亮度 (例如，付款码页面高亮)
  window.setWindowBrightness(1.0, (err) => { // 亮度范围0.01-1.0
    if (err) console.error('Failed to set brightness:', JSON.stringify(err));
  });
}

// 屏幕常亮控制 (例如，视频播放)
@State isVideoPlaying: boolean = false;
Video({ src: 'video.mp4' })
  .onStart(() => {
    this.isVideoPlaying = true;
    window.setWindowKeepScreenOn(true);
  })
  .onPause(() => {
    this.isVideoPlaying = false;
    window.setWindowKeepScreenOn(false);
  });
```

### 避免写法
```arkts
// 硬编码颜色，不适配深色模式
Text('Hello HarmonyOS')
  .fontColor(Color.Black); // 在深色模式下可能不可见或不协调

// 忘记关闭屏幕常亮
aboutToAppear() {
  window.setWindowKeepScreenOn(true); // 没有对应的关闭逻辑，可能导致电量消耗
}
```

## 注意事项

-   **Web内容适配**：如果应用内嵌Web页面，需要前端配合Web内容自身支持CSS媒体查询`prefers-color-scheme`进行深色模式适配。
-   **亮度作用域**：`window.setWindowBrightness`和`window.setWindowKeepScreenOn`仅在当前应用内生效，应用退出或被销毁后系统会自动恢复默认状态。
-   **用户设置优先级**：始终尊重用户在系统设置中对深色模式或亮度的偏好。