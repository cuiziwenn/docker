# docker

* docker是一个开源的应用容器引擎，基于go语言开发并遵循了apache2.0协议开源。docker可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的linux服务器，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口（类iphone的app），并且容器开销极其低。

## docker的架构
![imges](https://github.com/cuiziwenn/imgesfile/blob/master/docker%E6%9E%B6%E6%9E%84.jpg)

* distribution 负责与docker registry交互，上传洗澡镜像以及v2 registry 有关的源数据

* registry负责docker registry有关的身份认证、镜像查找、镜像验证以及管理registry mirror等交互操作

* image 负责与镜像源数据有关的存储、查找，镜像层的索引、查找以及镜像tar包有关的导入、导出操作

* reference负责存储本地所有镜像的repository和tag名，并维护与镜像id之间的映射关系

* layer模块负责与镜像层和容器层源数据有关的增删改查，并负责将镜像层的增删改查映射到实际存储镜像层文件的graphdriver模块

* graghdriver是所有与容器镜像相关操作的执行者

## docker 的优势
* 灵活：即使是最复杂的应用也可以集装箱化。
* 轻量级：容器利用并共享主机内核。
* 可互换：您可以即时部署更新和升级。
* 便携式：您可以在本地构建，部署到云，并在任何地方运行。
* 可扩展：您可以增加并自动分发容器副本。
* 可堆叠：您可以垂直和即时堆叠服务。

### 镜像和容器

通过镜像启动一个容器，一个镜像是一个可执行的包，其中包括运行应用程序所需要的所有内容包含代码，运行时间，库、环境变量、和配置文件。容器是镜像的运行实例，当被运行时有镜像状态和用户进程，可以使用docker ps 查看。

### 容器和虚拟机

容器时在linux上本机运行，并与其他容器共享主机的内核，它运行的一个独立的进程，不占用其他任何可执行文件的内存，非常轻量。

## Docker和Openstack对比

![imges](https://github.com/cuiziwenn/imgesfile/blob/master/dockerVSopenstack.jpg)

## docker三大概念
* image镜像
** docker镜像就是一个只读模板，比如，一个镜像可以包含一个完整的centos，里面仅安装apache或用户的其他应用，镜像可以用来创建docker容器，另外docker提供了一个很简单的机制来创建镜像或者更新现有的镜像，用户甚至可以直接从其他人那里下周一个已经做好的镜像来直接使用
* container容器
** docker利用容器来运行应用，容器是从镜像创建的运行实例，它可以被启动，开始、停止、删除、每个容器都是互相隔离的，保证安全的平台，可以吧容器看做是要给简易版的linux环境（包括root用户权限、镜像空间、用户空间和网络空间等）和运行再其中的应用程序3）repostory仓库
* 仓库
** 仓库是集中存储镜像文件的沧桑，registry是仓库主从服务器，实际上参考注册服务器上存放着多个仓库，每个仓库中又包含了多个镜像，每个镜像有不同的标签（tag）
** 仓库分为两种，公有参考，和私有仓库，最大的公开仓库是docker Hub，存放了数量庞大的镜像供用户下周，国内的docker pool，这里仓库的概念与Git类似，registry可以理解为github这样的托管服务。

## docker的使用
### docker安装

    yum install docker -y 
    systemctl enable docker
    systemctl start docker 

### 设置镜像源

    vim /usr/lib/systemd/system/docker.service

### docker版本查询
    docker version
### 搜索下载镜像
    docker pull alpine　　　　　　　　　　#下载镜像
    docker search nginx　　　　　　　　　 #查看镜像
    docker pull nginx

### 查看下载的镜像
    docker images
### 导出镜像
    docker  save nginx >/tmp/nginx.tar.gz  #举个栗子
### 删除镜像
    docker rmi -f nginx
### 导入镜像
    docker load </tmp/nginx.tar.gz
### 运行一个容器
     docker run -it alpine sh   #运行并进入alpine  -d后台运行
### 进入容器
        docker exec -it ID bash #-d：分离模式，即在后台运行命令   -i：交互模式  -t：分配一个 tty  -u：指定用户和用户组，格式：<name|uid>[:<group|gid>]
### 查看容器
    docker ps       #查看删除容器
    docker ps -a    #查看所有容器包括未运行的
### 查看日志
    docker logs -f mynginx



