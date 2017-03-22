### Ubuntu-Gogs

用更简单的方式部署、升级或迁移Gogs容器服务。

#### 获取容器

```
$ docker pull leafney/ubuntu-gogs
```

#### 如何运行容器

```
$ docker run --name mygogs -d -p 10080:3000 -p 10022:22 -v /home/tiger/gogsfile:/app leafney/ubuntu-gogs
```

默认挂载目录结构：

```
/app
	- gogs-repositories
	- gogs
		- custom
			- conf
				  app.ini
		- data
			  gogs.db
		- log
			  gogs.log
			  xorm.log
```

***

#### 初次启动配置注意事项

1. `Database Type` 选择 `SQLite3`  （其他数据库暂未测试）
2. `Sqlite3 Database Path` 可以使用默认相对路径：`data/gogs.db` 也可以使用绝对路径： `/app/gogs/data/gogs.db`
3. `Repository Root Path` **更改为绝对路径**： `/app/gogs-repositories`
4. `Run User` 使用默认用户： `git`
5. `Domain` 填写Docker宿主机的主机名或物理地址 如： `192.168.137.140`
6. `SSH Port` 不要勾选使用内置SSH服务器（Don't user `Use Builtin SSH Server
`） 如果你映射Docker外部端口如 `10022:22` 那么这里就填写 `10022`
7. `HTTP Port` 如果映射Docker外部端口如： `10080:3000` 这里仍然可以使用：`3000`
8. `Application URL` 使用域和公开的HTTP端口值的组合如：`http://192.168.137.140:10080`
9. `Log Path` 可以使用默认值：`/home/git/gogs/log` 也可以使用绝对路径： `/app/gogs/log`

更多可参考 [Docker for Gogs](https://github.com/gogits/gogs/blob/master/docker/README.md#settings)

当以上各项配置完成，点击 `立即安装` 按钮后页面会跳转至首页并自动登陆设置的管理员账户，如果完成这一步，说明项目配置成功。

***

#### 项目升级及迁移方法

如果需要进行项目升级或迁移，该容器和Gogs官方中介绍的升级方式一致，详见：[二进制升级 - Gogs](https://gogs.io/docs/upgrade/upgrade_from_binary)。

在启动容器后，复制原项目目录下的 `custom` 、`data` 和 `log` 目录到容器挂载目录下的 `gogs` 目录中，再将原项目中仓库数据复制到挂载目录的 `gogs-repositories` 中即可。
重启容器即生效。
