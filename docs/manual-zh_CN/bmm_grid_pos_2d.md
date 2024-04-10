# BmmGridPos2D 使用手册

`BmmGridPos2D` 是一个用于在 Godot 游戏引擎中监听和获取 `Rect2` 在网格中位置的节点。它通过接收一个 `CollisionShape2D` 节点来定义网格，并允许用户监听特定 `Rect2` 的位置变化。

## 属性

- `grid_node: CollisionShape2D`: 网格节点，用于定义网格的大小和位置。
- `grid_x: int`: X 轴方向的网格数量。
- `grid_y: int`: Y 轴方向的网格数量。
- `listen_rect: Rect2`: 需要监听的 `Rect2`。

## 信号

- `listen_pos_changed(x: int, y: int)`: 当监听的 `Rect2` 在网格中的位置改变时发出。如果 `x = -1` 和 `y = -1`，表示 `Rect2` 不在网格内。

## 方法

- `_enter_tree()`: 当节点进入场景树时调用，用于初始化网格。
- `update_grid_rect()`: 更新网格的 `Rect2`。
- `get_listen_rect()`: 获取当前监听的 `Rect2`。
- `set_listen_rect(value: Rect2)`: 设置新的监听 `Rect2`。如果新值与当前值不同，将更新监听位置并发出 `listen_pos_changed` 信号。
- `get_grid_pos_center(x: int, y: int) -> Vector2`: 获取网格中指定位置 `(x, y)` 的中心点坐标。这个方法返回一个 `Vector2` 对象，表示网格中特定单元格的中心点在场景中的坐标。

## 使用说明

1. 将 `BmmGridPos2D` 节点添加到您的场景中。
2. 设置 `grid_node` 为您的 `CollisionShape2D` 节点。
3. 设置 `grid_x` 和 `grid_y` 来定义网格的尺寸。
4. 使用 `listen_rect` 来设置或获取需要监听的 `Rect2`。
5. 通过连接 `listen_pos_changed` 信号来监听位置变化。
6. 使用 `get_grid_pos_center(x: int, y: int)` 来获取网格中特定位置的中心点坐标。

## 注意事项

- 确保网格节点的 `Shape2D` 是一个矩形。
- 监听的 `Rect2` 必须完全位于网格内才能正确检测位置。
