## Docker 网络模式

* Docker采用插件化的网络模式，默认提供bridge、host、none、overlay、maclan和Network plugins这几种网络模式，运行容器时可以通过–network参数设置具体使用那一种模式。
#### bridge
* bridge是Docker默认的网络驱动，此模式会为每一个容器分配Network Namespace和设置IP等，并将容器连接到一个虚拟网桥上。如果未指定网络驱动，这默认使用此驱动。
#### host
* 直接使用宿主机网络
#### none
* 不构成网络环境，采用了none 网络驱动，那么就只能使用loopback网络设备，容器只能使用127.0.0.1的本机网络。
#### overlay
* 可以使多个Docker daemons连接在一起，并能够使用swarm服务之间进行通讯。也可以使用overlay网络进行swarm服务和容器之间、容器之间进行通讯
#### macvlan
* 允许为容器指定一个MAC地址，允许容器作为网络中的物理设备，这样Docker daemon就可以通过MAC地址进行访问的路由。对于希望直接连接网络网络的遗留应用，这种网络驱动有时可能是最好的选择
#### Network plugins
* 可以安装和使用第三方的网络插件。可以在Docker Store或第三方供应商处获取这些插件:flannel等。
### bridge网络构建过程
* 安装docker时会创建一个docker0的虚拟网桥
![imges](https://github.com/cuiziwenn/imgesfile/blob/master/docker0%E7%BD%91%E7%BB%9C.png)
* docker network inspect bridge查看网桥的网络范围和网关
![imges](https://github.com/cuiziwenn/imgesfile/blob/master/docker-bridge%E7%BD%91%E7%BB%9C.png)
* 运行容器时，在宿主机上创建虚拟网卡veth pair设备，veth pair设备是成对出现的，从而组成一个数据通道，数据从一个设备进入，就会从另一个设备出来
#### 外网访问
* bridge是虚拟出来的网桥，因此无法被外部的网络访问，所有可以添加-p、-P参数对端口映射 -P将容器的端口映射到宿主机的制定端口，-p将容器的端口映射到宿主机的随机端口
![imges](https://github.com/cuiziwenn/imgesfile/blob/master/docker%E7%AB%AF%E5%8F%A3%E6%98%A0%E5%B0%84.png)
![imges](https://github.com/cuiziwenn/imgesfile/blob/master/docker%E6%8C%87%E5%AE%9A%E7%AB%AF%E5%8F%A3%E6%98%A0%E5%B0%84.png)

### 修改docker的默认网段
* 删除默认配置
```
    service docker stop
    ip link set dev docker0 down
    brctl delbr docker0
    iptables -t nat -F POSTROUTING
```
* 创建新的网桥
```
    brctl addbr docker0
    ip addr add 172.17.10.1/24 dev docker0
    ip link set dev docker0 up
```
*  配置Docker文件
```
    vim /etc/docker/daemon.json
    {"registry-mirrors": ["http://224ac393.m.daocloud.io"],
                "bip": "172.17.10.1/24"
    }
    systemctl  restart  docker
```
