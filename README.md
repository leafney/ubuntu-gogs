### Ubuntu-Gogs


#### 获取容器

```
$ docker pull leafney/ubuntu-gogs
```

#### 如何运行容器

```
$ docker run --name mygogs -d -p 10080:3000 -p 10022:22 -v /home/tiger/gogsfile:/app leafney/ubuntu-gogs
```

默认挂载目录：

```
/app
	gogs-repositories
	gogs
		conf
			app.ini
		data
			gogs.db
		log
			gogs.log
			xorm.log
		ssh
```

#### 初次启动配置注意事项

1. `Database Type` 选择 `SQLite3`  （其他数据库暂未测试）
2. `Sqlite3 Database Path` 使用固定路径 `/app/gogs/data/gogs.db`
3. `Repository Root Path` 使用固定路径 `/app/gogs-repositories`
4. `Run User` 使用默认用户 `git`
5. `Domain` 填写Docker宿主机的主机名或物理地址 如 `192.168.137.140`
6. `SSH Port` 不要勾选使用内置SSH服务器（Don't user `Use Builtin SSH Server
`） 如果你映射Docker外部端口如 `10022:22` 那么这里就填写 `10022`
7. `HTTP Port` 如果映射Docker外部端口如 `10080:3000` 这里仍然可以使用 `3000`
8. `Application URL` 使用域和公开的HTTP端口值的组合 如 `http://192.168.137.140:10080`
9. `Log Path` 使用固定路径 `/app/gogs/log`

更多可参考 [Docker for Gogs](https://github.com/gogits/gogs/blob/master/docker/README.md#settings)


**注意：**

1. 当以上各项配置完成，点击按钮后页面会自动跳转至首页并自动登陆设置的管理员账户，如果完成这一步，说明项目配置完成。
2. 当上面步骤操作完成后，务必重启当前容器 `docker restart <CONTAINERNAME>` 。容器重启后可在映射目录下 `/gogs/conf` 中看到 `app.ini` 自定义配置文件。更改该配置文件中的项并再次重启容器后自定义配置即生效。
