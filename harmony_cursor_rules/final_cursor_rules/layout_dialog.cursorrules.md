# HarmonyOS 布局与弹窗 - Cursor Rules

你正在为HarmonyOS应用开发相关功能。以下是你需要遵循的开发规则。

## 核心原则

-   **性能优先**: 优化UI节点数量，合理利用布局边界和懒加载，确保界面流畅。
-   **模块化设计**: 封装可复用组件（如自定义指示器、列表项），提升代码可维护性。
-   **用户体验**: 确保弹窗、列表和交互手势符合用户预期，提供平滑的动画和清晰的反馈。
-   **组件优选**: 熟悉并合理选择HarmonyOS ArkUI提供的原生组件和高级能力（如 `DialogHub`、`LazyForEach`）。

## 推荐做法

### 代码结构
-   将复杂UI功能（如图文轮播的指示器、评论弹窗）拆分为独立的自定义组件，提高复用性和可维护性。
-   针对多类型列表项，定义清晰的数据模型和对应的 `ListItem` 模板。

### 最佳实践
-   **布局优化**:
    -   **精简UI节点**: 避免深层嵌套，使用扁平化布局。对于条件显示，优先使用 `if/else` 减少组件树节点。
    -   **布局边界**: 为容器组件设置固定宽高 (`width`, `height`)，限制布局计算范围。
    -   **长列表**: 使用 `LazyForEach` 构建长列表，配合 `List` 组件的 `onReachEnd` 实现上滑加载更多，`Refresh` 实现下拉刷新。当 `List` 嵌套在 `Scroll` 中时，务必为 `List` 设置明确的宽高。
    -   **组件选择**: 优先使用 `Column`/`Row` 进行线性布局，`Stack` 进行层叠，`Flex` 进行弹性布局。
-   **弹窗管理**:
    -   **复杂弹窗**: 优先选用 `Navigation Dialog` 或更统一的 `DialogHub` 来实现评论回复等复杂弹窗，以获得更好的软键盘/表情面板适配和动画控制。
    -   **交互控制**: 精细控制弹窗的关闭行为（侧滑、点击外部），并自定义进出场动画。
    -   **键盘避让**: 确保弹窗能自动避让软键盘，避免内容被遮挡，且不抢占焦点。
-   **轮播与拖拽**:
    -   **自定义轮播指示器**: 使用 `Swiper` 组件关闭自带指示器 (`indicator(false)`)，并自定义进度条等指示器组件。
    -   **网格拖拽**: `Grid` 容器启用 `editMode(true)` 和 `supportAnimation(true)`，结合 `LongPressGesture` 和 `PanGesture` 实现 `GridItem` 的拖拽交换。
-   **高级交互**:
    -   **图片预览**: 利用 `matrix4` 实现精确缩放的“跟手”效果，`translate` 实现平移。
    -   **文本展开**: 使用 `measureTextSize()` 准确测量文本高度，实现文本的展开折叠功能，并考虑“...展开”按钮的宽度。

## 禁止做法

-   **弹窗陷阱**: 避免将 `CustomDialog` 作为复杂评论回复弹窗的主体，因为它在软键盘避让和动画控制方面存在限制。
-   **长列表性能**: 禁止使用 `ForEach` 来渲染大量数据或无限滚动的列表，这将导致性能瓶颈。
-   **过度依赖默认**: 当需要自定义样式或复杂交互时，避免直接依赖 `Swiper` 组件自带的指示器。
-   **布局冗余**: 避免不必要的布局嵌套，导致UI树过于复杂，增加渲染开销。

## 代码示例

### 推荐写法
```arkts
// Swiper 禁用默认指示器，并使用 LazyForEach 优化长列表
Swiper(this.swiperController) {
  LazyForEach(this.imageData, (item: ImageItem) => {
    Image(item.src)
      .width('100%')
      .height('100%')
  }, (item: ImageItem) => item.id.toString())
}
.loop(true)
.autoPlay(true)
.interval(3000)
.indicator(false) // 禁用默认指示器

// 列表流上滑加载更多
List() {
  // ... ListItem 渲染
}
.onReachEnd(() => {
  // 触发加载更多数据
  this.loadMoreData();
})
```

### 避免写法
```arkts
// 避免使用 ForEach 渲染可能包含大量数据的列表
List() {
  ForEach(this.allData, (item: ListItemData) => { // ❌ 避免 ForEach 渲染长列表
    ListItem() {
      Text(item.content)
    }
  })
}

// 避免使用 CustomDialog 且不处理键盘避让
// CustomDialog 默认完全避让键盘且不可配置，可能导致弹窗抖动
// CustomDialogController.open({ builder: CustomCommentDialog() }) ❌
```

## 注意事项

-   在开发过程中，始终使用HarmonyOS DevEco Studio的性能分析工具监控UI渲染和布局计算，及时发现并解决性能瓶颈。
-   充分测试弹窗在不同输入法、折叠屏展开/折叠状态下的行为，确保适配性。
-   对于带有复杂手势的组件（如图片预览器），确保手势识别的准确性、灵敏度和“跟手”效果的流畅性。
-   在实现数据加载（刷新、加载更多）时，提供清晰的加载状态反馈，并处理网络异常情况。