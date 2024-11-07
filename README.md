# VPSMan

VPSMan是一个简单而强大的VPS(虚拟专用服务器)管理工具，帮助用户更轻松地管理他们的VPS服务器。

## 功能特性

- 服务器状态监控
- 系统资源使用统计
- 一键部署常用服务
- 安全配置管理
- 备份和恢复功能

## 安装

### 使用pip安装

  ```bash
  pip install vpsman
  ```

## 使用方法

直接运行:

  ```bash
  vpsman
  ```

这将显示一个交互式菜单，包含以下选项:
1. 查看系统用户列表
2. 安装 Docker (即将推出)
3. 添加用户 (即将推出)

## 系统要求

- Python 3.6+
- Linux 操作系统

## 开发

要参与此项目的开发:

  ```bash
  # 克隆仓库
  git clone https://github.com/mason-webmaster/vpsman.git
  cd vpsman

  # 创建虚拟环境
  python3 -m venv venv
  source venv/bin/activate  # Linux/Mac
  # 或
  venv\Scripts\activate     # Windows

  # 开发模式安装
  pip install -e .
  ```

## 项目结构

  ```
  vpsman/
  ├── setup.py           # 包配置
  ├── README.md         # 本文件
  ├── LICENSE           # MIT许可证
  └��─ vpsman/          # 源代码
      ├── __init__.py   # 包初始化
      ├── cli.py        # 命令行界面
      └── core/         # 核心功能
          ├── __init__.py
          └── users.py  # 用户管理
  ```

## 版本历史

- 0.1.2: 修复包结构并提高稳定性
- 0.1.1: 初始发布，包含基本功能
- 0.1.0: 项目设置和结构

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 作者

mason_dev

## 贡献

欢迎提交 Pull Request 来贡献代码！

1. Fork 本项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m '添加一些很棒的特性'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 支持

如果你有任何问题或需要帮助，请在 GitHub 上开一个 issue。
