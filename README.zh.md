# openclaw-direct-gpt54

[English](./README.md)

让 OpenClaw 里的 GPT-5.4 回答更短、更清楚、更直接。

## 给 OpenClaw 用

可以直接使用这段 prompt：

> 安装并应用这个 skill 的最新版本：https://github.com/BlueBirdBack/openclaw-direct-gpt54 。先备份我当前的 `SOUL.md` 和 `USER.md`。合并修改，不要替换我的身份设定、安全规则或运维规则。

这个 skill 主要通过收紧这几个文件来生效：
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

它是提示文件层面的指导，不是插件，也不是运行时护栏。
如果 GPT-5.4 在应用后仍然会漏出 `If you want, I can...`，那就还需要单独的运行时修复。

## 更新这个 skill

再次使用同一段 prompt：

> 安装并应用这个 skill 的最新版本：https://github.com/BlueBirdBack/openclaw-direct-gpt54 。先备份我当前的 `SOUL.md` 和 `USER.md`。合并修改，不要替换我的身份设定、安全规则或运维规则。

## 真正重要的规则

- 先给答案
- 默认简短
- 只在确实需要时展开
- 去掉夸赞、总结复述和 prompt echo
- 主任务完成后，凡是直接 implied 的低风险内部收尾，不要再问权限；直接做完再汇报
- 如果刚创建了一个明显应该登记到索引或追踪器里的持久产物，先更新索引/追踪器，再回复
- 只有在后续动作具有破坏性、对外/公开、或确实存在歧义时才提问
- 问题解决后就停

## 目标行为示例

坏：

> 已创建 `docs/project-x.md`。如果你愿意，我可以把它加到 `Projects.md`。

好：

> 已创建 `docs/project-x.md`，并已把它链接到 `Projects.md`。

## 安全修改原则

- 合并修改，不要替换
- 保留本地更强的安全规则和运维规则
- 保留目标 agent 自己的名字、身份和语气
- 先备份，方便回滚

## 许可证

MIT
