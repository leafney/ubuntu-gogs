### Ubuntu-Gogs

用更简单的方式部署、升级或迁移Gogs服务。

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
  gogs-repositories
  gogs
    custom
      conf
        app.ini
    data
      gogs.db
    log
      gogs.log
      xorm.log
```

***

#### 初次启动配置

1. `数据库类型(Database Type)`： 选择 `SQLite3` 
2. `数据库文件路径(Database Path)`： Sqlite3使用绝对路径 `/app/gogs/data/gogs.db` 或者也可以使用默认相对路径 `data/gogs.db`
3. `仓库根目录(Repository Root Path)`： **更改为绝对路径**  `/app/gogs-repositories`
4. `运行系统用户(Run User)`：  使用默认用户  `git`
5. `域名(Domain)`： 填写Docker宿主机的主机名或物理地址或要使用的域名(不带http/https) 如  `192.168.137.140`
6. `SSH 端口号(SSH Port)`： 如果你映射Docker外部端口如 `10022:22` 那么这里就填写 `10022` ；不要勾选“使用内置SSH服务器”（Don't tick Use Builtin SSH Server）
7. `HTTP 端口号(HTTP Port)`： 如果映射Docker外部端口如 `10080:3000` 这里要使用容器端口：`3000`
8. `应用 URL(Application URL)`： 使用域名和公开的HTTP端口值的组合(带http/https) 如 `http://192.168.137.140:10080`
9. `日志路径(Log Path)`： 使用路径 `/app/gogs/log`(推荐) 或默认值 `/home/git/gogs/log`


更多数据库(`MySQL`、`PostgreSQL`、`SQLite3`、`MSSQL`)配置详见：[Docker-Ubuntu-Gogs数据库及初始化配置](http://www.itfanr.cc/2017/09/07/docker-ubuntu-gogs-initialization/)

更多注意事项详见：[Docker for Gogs](https://github.com/gogits/gogs/blob/master/docker/README.md#settings)

当以上各项配置完成，点击 `立即安装` 按钮后页面会跳转至首页并自动登陆设置的管理员账户，如果完成这一步，说明项目配置成功。

***

#### 项目升级及迁移方法

如果需要进行项目升级或迁移，该容器和Gogs官方中介绍的升级方式一致，详见：[二进制升级 - Gogs](https://gogs.io/docs/upgrade/upgrade_from_binary)。

##### 从原有实机部署迁移

1. 在启动容器后，复制原项目目录下的 `custom` 、`data` 和 `log` 三个目录到容器挂载目录下的 `gogs` 目录中，再将原项目中仓库数据复制到挂载目录的 `gogs-repositories` 中。
2. 重启容器即可。

##### 从Docker Gogs旧版本升级

1. 获取新版本Docker Gogs容器，启动容器时指定挂载目录为原旧版本容器挂载目录 `-v /home/tiger/gogsfile:/app` 或将原旧版本容器挂载目录下的 `gogs` 和 `gogs-repositories` 两个目录拷贝并覆盖到新挂载目录下。
2. 重启容器即可。

#### 相关文章

* [Docker-Ubuntu-Gogs部署gogs容器过程记录](http://www.itfanr.cc/2017/03/23/docker-ubuntu-gogs-deploy/)
* [Docker-Ubuntu-Gogs部署及配置时遇到的问题](http://www.itfanr.cc/2017/03/24/docker-ubuntu-gogs-problems/)
* [Docker-Ubuntu-Gogs个性化设置](http://www.itfanr.cc/2017/03/27/docker-ubuntu-gogs-custom/)
* [Docker-Ubuntu-Gogs关于使用SSH](http://www.itfanr.cc/2017/07/21/docker-ubuntu-gogs-ssh/)
* [Docker-Ubuntu-Gogs数据库及初始化配置](http://www.itfanr.cc/2017/09/07/docker-ubuntu-gogs-initialization/)
