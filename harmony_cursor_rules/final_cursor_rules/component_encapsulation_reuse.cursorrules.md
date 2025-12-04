# HarmonyOS 组件封装与复用 - Cursor Rules

你正在为HarmonyOS应用开发相关功能。以下是你需要遵循的开发规则。

## 核心原则

1.  **性能优先，按需加载**: 利用动态创建与组件复用机制，减少资源消耗，提升用户体验和帧率。
2.  **组件化与高内聚**: 封装通用组件，统一界面风格，提高代码复用性与可维护性。
3.  **遵循ArkUI范式**: 充分利用 `@Reusable`、`attributeModifier`、`FrameNode` 等框架特性。
4.  **精细化数据管理**: 优化数据传递方式，避免不必要的深拷贝和重复渲染。

## 推荐做法

### 代码结构

-   **通用组件封装**: 使用 `attributeModifier` 扩展系统组件，保持链式调用风格，避免冗长入参，增强可维护性。
-   **弹窗组件封装**: 统一通过 `UIContext` 的 `PromptAction` 管理自定义弹窗的显示与隐藏，确保生命周期正确。
-   **组件工厂**: 对于多种类似组件，可使用工厂类统一管理和按需获取，提高组件管理的集中性和灵活性。

### 最佳实践

-   **动态组件创建**: 对于复杂动态布局或高性能场景（如列表流广告），优先使用 `FrameNode` 结合 `NodeController` 和 `NodeContainer` 实现组件的动态创建与卸载，以显著减少开销，加速更新。
-   **组件复用**:
    -   使用 `@Reusable` 装饰器修饰可复用组件。
    -   在 `aboutToReuse()` 回调中根据新数据刷新组件UI，而非在构造函数中执行所有初始化逻辑。
    -   通过 `reuseId` 属性对不同结构或用途的组件进行精细化分组，提高缓存命中率。
-   **性能优化**:
    -   在应用空闲时间（如 `onIdle()` 回调）预创建和缓存组件实例。
    -   对于复杂对象或数组，优先使用 `@Link` 或 `@ObjectLink` 装饰器传递引用，而非 `@Prop`，以减少深拷贝和内存开销。

## 禁止做法

-   **过度依赖声明式范式处理复杂动态布局**: 在组件树深度大、变化频繁时，声明式 `diff` 开销过大，影响性能和帧率。
-   **通过重新渲染整个组件树操作局部组件**: 为了移动或修改子组件，不应重新渲染整个父组件，造成不必要的性能浪费。
-   **传统封装方式导致入参冗长**: 自定义组件入参列表过长，且使用方式与系统组件不一致，降低可读性和维护性。
-   **将函数直接作为 `@Reusable` 组件的入参**: 可能导致组件无法有效复用或引起不必要的渲染更新。
-   **在 `@Reusable` 组件中，使用 `@Prop` 传递复杂对象或数组**: 会导致深拷贝，增加内存和垃圾回收开销。

## 代码示例

### 推荐写法

```arkts
// 1. 使用 attributeModifier 封装通用组件
class MyButtonModifier implements AttributeModifier<Button> {
  applyNormalAttribute(instance: Button): void {
    instance.fontSize(16).fontColor(Color.Blue);
  }
}

@Component
struct MyCustomButton {
  @Prop text: string = 'Click Me';
  build() {
    Button(this.text)
      .attributeModifier(new MyButtonModifier()); // 链式调用风格
  }
}

// 2. 使用 @Reusable 优化列表项
@Reusable
@Component
struct ReusableListItem {
  @ObjectLink itemData: MyDataType; // 推荐使用 @ObjectLink 传递引用

  aboutToReuse(params: { itemData: MyDataType }) {
    this.itemData = params.itemData; // 在复用时刷新数据
  }

  build() {
    Row() {
      Text(this.itemData.name)
      Text(this.itemData.description)
    }
  }
}
```

### 避免写法

```arkts
// 传统公用组件封装 (入参过大，使用方式不一致)
@Component
struct BadCustomButton {
  @Prop text: string = '';
  @Prop fontSize: number = 12; // 需要穷举Button所有属性
  @Prop fontColor: Color = Color.Black;
  // ... 更多属性

  build() {
    Button(this.text)
      .fontSize(this.fontSize)
      .fontColor(this.fontColor);
      // ... 更多属性
  }
}

// 在 @Reusable 组件中使用 @Prop 传递复杂对象（导致深拷贝）
@Reusable
@Component
struct AvoidPropListItem {
  @Prop itemData: MyDataType; // 避免在 @Reusable 组件中对复杂对象使用 @Prop

  build() {
    Row() {
      Text(this.itemData.name) // 每次复用都会深拷贝 itemData
    }
  }
}
```

## 注意事项

-   **`FrameNode` 的优势**: `FrameNode` 可以避免创建自定义组件对象和状态变量对象，无需进行依赖收集，从而显著提升组件创建速度和更新效率。
-   **`NodeController` 的作用**: `NodeController` 是管理动态节点的创建、显示和更新操作的关键，确保动态组件的生命周期管理。
-   **`aboutToReuse()` 的职责**: 此回调专注于根据新数据刷新UI，不应在此处执行复杂的初始化逻辑或创建新的状态变量。
-   **`reuseId` 的重要性**: 合理设置 `reuseId` 对于不同结构或用途的组件分组至关重要，它能帮助系统在缓存池中找到最匹配的组件实例，提高复用效率。
