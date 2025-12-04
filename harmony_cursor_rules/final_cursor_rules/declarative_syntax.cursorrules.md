# HarmonyOS 声明式语法 - Cursor Rules

你正在为HarmonyOS应用开发相关功能。以下是你需要遵循的开发规则。

## 核心原则

-   **UI是状态的函数**: 深入理解状态变量与UI刷新机制，确保UI始终反映最新状态。
-   **避免冗余刷新**: 精准控制UI刷新范围，优化应用性能。
-   **状态与UI解耦**: 采用清晰的状态管理模式，提高代码可维护性和扩展性。
-   **遵循单向数据流**: 确保状态变更可预测，便于调试和管理。

## 推荐做法

### 代码结构
-   **全局状态管理**: 对于全局或多组件共享的状态，优先采用`StateStore`库进行集中管理，将状态数据与UI组件逻辑分离。
-   **Reducer封装**: 将所有状态更新逻辑封装在独立的`Reducer`纯函数中，确保状态变更的单一职责和可预测性。

### 最佳实践
-   **审慎使用状态装饰器**: 仅当变量改变需要触发UI更新时，才使用`@State`, `@Prop`, `@Link`等状态装饰器对其进行标记。
-   **可观测数据定义**: 所有需要被`StateStore`管理并能触发UI更新的业务数据，必须使用`@Observed`或`@ObservedV2`装饰器进行修饰。
-   **`@Link`的权衡**: 审慎使用`@Link`实现双向绑定；若仅需单向传递数据，优先考虑`@Prop`或普通参数，以减少不必要的子组件刷新范围。

### 性能优化建议
-   **工具定位**: 利用`hidumper`等HarmonyOS诊断工具定位并分析组件的冗余刷新问题。
-   **Linter检查**: 定期使用`Code Linter`工具（特别是`@performance/hp-arkui-remove-redundant-state-var`规则）检查并移除冗余或不必要的状态变量。

## 禁止做法

-   **副作用引入**: 严禁在组件的`build`方法或其直接调用的函数中修改非状态变量或引入其他副作用，这会导致UI行为不可预测和性能问题。
-   **冗余状态变量**: 禁止将未关联任何UI组件或仅被读取而从未修改的变量定义为状态变量。
-   **违背单向数据流**: 禁止不遵循`StateStore`的`View-Action-Reducer-Store`单向数据流原则，直接在UI层修改状态。

## 代码示例

### 推荐写法
```arkts
@Component
struct MyComponent {
  @State count: number = 0; // count用于UI显示并会修改，需@State
  private message: string = 'Hello HarmonyOS'; // message仅读取，不需@State

  build() {
    Column() {
      Text(`Count: ${this.count}`)
        .onClick(() => this.count++); // count改变触发Text刷新
      Text(this.message); // message仅读取，不触发UI刷新
    }
  }
}
```

### 避免写法
```arkts
// 避免写法1：变量未关联UI或仅读取却被定义为状态变量
@Observed class DataModel { translateX: number = 20; }
@Component struct MyComponentA {
  @State data: DataModel = new DataModel(); // 未在UI中使用，不应是状态变量
  @State label: string = 'Button'; // 仅读取，未修改，不应是状态变量
  build() { Button(this.label); /* data未在UI中使用 */ }
}

// 避免写法2：在build方法中引入副作用
@Component struct MyComponentB {
  private currentOpacity: number = 0; // 非状态变量
  calculateOpacity(): number {
    // 错误：在build调用中修改非状态变量，每次刷新都累加
    this.currentOpacity = (this.currentOpacity + 1) % 100; 
    return this.currentOpacity;
  }
  build() {
    Image('icon.png').opacity(this.calculateOpacity()); // 每次刷新都会调用并修改currentOpacity
  }
}
```

## 注意事项

-   状态变量的管理会带来额外的系统开销，过度或不合理使用可能导致性能下降。
-   `StateStore`本身不直接驱动UI刷新，其UI刷新能力依赖于ArkUI系统侧的`@Observed`或`@ObservedV2`对数据的观测能力。
-   持续使用开发工具进行性能分析和代码审查，是保证应用质量和性能的关键。