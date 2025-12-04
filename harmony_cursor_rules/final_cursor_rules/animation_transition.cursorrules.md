# HarmonyOS 动画与转场 - Cursor Rules

你正在为HarmonyOS应用开发动画与转场功能。以下是你需要遵循的开发规则，以确保应用具备卓越的用户体验和高性能表现。

## 核心原则

-   **用户体验优先**: 动画应提升用户感知流畅度，符合用户心理预期和物理规律，有效引导用户操作。
-   **性能至上**: 动画运行必须流畅，避免卡顿，优化资源使用，减少不必要的重绘和布局计算。
-   **善用原生能力**: 优先使用HarmonyOS系统提供的动画与转场API，它们经过底层优化，性能更佳。
-   **避免布局变动**: 动画应尽量避免频繁改变布局属性，减少UI树的重布局开销。

## 推荐做法

### 代码结构
-   **优先使用声明式动画API**: 充分利用HarmonyOS声明式UI提供的 `animateTo`、`transition`、`geometryTransition` 等高级动画接口。
-   **模块化动画逻辑**: 将复杂的动画逻辑封装在独立的函数或组件中，提高代码可读性和复用性。

### 最佳实践
-   **提升动画感知流畅度**:
    *   **即时手势反馈**: 对于点击、滑动等手势，动画反馈应在按下瞬间即响应，避免无反馈状态。
    *   **符合物理规律**: 动画的运动曲线、速度和弹性应模拟真实世界，增强沉浸感。
    *   **品牌特征**: 利用开场、加载等特征动效，打造独特的品牌调性。
-   **提升动画运行流畅度**:
    *   **优先图形变换属性**: 动画应优先改变 `transform` (位移、旋转、缩放) 和 `opacity` (不透明度) 等不影响布局的属性，这些通常在GPU上进行合成，性能更高。
    *   **复用 `animateTo`**: 当多个动画使用相同参数时，尽量在同一个 `animateTo` 块中进行状态更新，减少开销。
    *   **统一状态变量**: 在短时间内触发多次 `animateTo` 时，统一管理和更新状态变量，避免动画冲突或不必要的重绘。
    *   **合理使用 `renderGroup`**: 对于包含复杂子组件的动画，将需要动画的组件设置为 `renderGroup(true)`，可以将其作为一个整体进行渲染，减少渲染批次。
-   **页面与元素转场**:
    *   **根据场景选择转场类型**:
        *   **列表展开**：推荐使用**左右位移遮罩动效**。
        *   **单体独立卡片/图表展开**、**非固定搜索区域**：推荐使用**一镜到底动效**。
        *   **固定搜索区域**：可使用**淡入淡出动效**让搜索框渐变进入。
    *   **通用页面转场**: 优先采用**左右位移**的运动方式，转场曲线优先使用**弹簧曲线**。
    *   **共享元素转场**: 优先使用 `geometryTransition` 接口，实现元素在不同页面间的平滑过渡。
    *   **共享容器转场**: 对于卡片、列表等复杂容器，可结合 `Navigation` 组件的自定义动画能力。

## 禁止做法

-   **频繁改变布局属性**: 在动画过程中，严禁频繁改变组件的 `width`、`height`、`padding`、`margin` 等布局属性，这会导致UI树的重新布局和重绘，严重影响动画性能。
-   **无反馈手势**: 用户进行点击、滑动等操作时，界面长时间无任何动画反馈。
-   **滥用复杂转场**: 不在必要场景下滥用如“一镜到底”等复杂转场动效，导致视觉混乱或性能下降。

## 代码示例

### 推荐写法
```arkts
// 推荐：优先使用transform和opacity，并利用renderGroup优化动画性能
@Entry
@Component
struct AnimationBestPracticeDemo {
  @State isMoved: boolean = false;

  build() {
    Column() {
      Button('Toggle Animation')
        .onClick(() => {
          animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
            this.isMoved = !this.isMoved;
          });
        })
        .margin(20);

      Row() { // 假设这是一个包含复杂内容的组件，需要动画
        Image($r("app.media.icon"))
          .width(50).height(50)
          .offset({ x: this.isMoved ? 100 : 0, y: 0 }) // 优先使用offset (transform)
          .opacity(this.isMoved ? 1.0 : 0.5) // 优先使用opacity
          .scale(this.isMoved ? 1.2 : 1.0); // 优先使用scale
      }
      .renderGroup(true) // 将复杂子组件设为渲染组，减少渲染批次
      .geometryTransition('sharedItem') // 示例：共享元素转场
    }
  }
}
```

### 避免写法
```arkts
// 避免：在动画中直接且频繁地改变布局尺寸，导致重布局，影响性能
@Entry
@Component
struct AnimationAvoidanceDemo {
  @State currentSize: number = 50;

  build() {
    Column() {
      Button('Toggle Layout Animation')
        .onClick(() => {
          // 这种直接动画width/height的方式性能较差，易引发UI重布局
          // 应该优先考虑使用scale、transform或opacity
          animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
            this.currentSize = (this.currentSize === 50) ? 100 : 50;
          });
        })
        .margin(20);

      Image($r("app.media.icon"))
        .width(this.currentSize) // 避免在动画中直接改变width
        .height(this.currentSize); // 避免在动画中直接改变height
    }
  }
}
```

## 注意事项

-   **内存管理**: 及时释放不再需要的动画资源，防止内存泄漏。
-   **充分调试**: 动画效果应在不同设备上进行充分调试和性能测试，确保在各种场景下都能保持流畅。
-   **API边界**: 理解不同动画和转场API的适用场景和能力边界，选择最合适的实现方式。
