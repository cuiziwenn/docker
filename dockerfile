Dockerfile

** FROM 指定基础镜像，可以是任何有效的基础镜像

FROM 必须 是 Dockerfile 中第一条非注释命令
在一个 Dockerfile 文件中创建多个镜像时，FROM 可以多次出现。只需在每个新命令 FROM 之前，记录提交上次的镜像 ID。
tag 或 digest 是可选的，如果不使用这两个值时，会使用 latest 版本的基础镜像

FROM 指令用于指定其后构建新镜像所使用的基础镜像。FROM 指令必是 Dockerfile 文件中的首条命令，启动构建流程后，Docker 将会基于该镜像构建新镜像，FROM 后的命令也会基于这个基础镜像.

FROM语法格式:

FROM <image>或者FROM <image>:<tag>或FROM <image>:<digest>

RUN 在镜像的构建过程中执行特定的命令，并生成一个中间镜像

RUN语法格式：

RUN <command>

RUN 命令将在当前 image 中执行任意合法命令并提交执行结果。命令执行提交后，就会自动执行 Dockerfile 中的下一个指令。
层级 RUN 指令和生成提交是符合 Docker 核心理念的做法。它允许像版本控制那样，在任意一个点，对 image 镜像进行定制化构建。
RUN 指令创建的中间镜像会被缓存，并会在下次构建中使用。如果不想使用这些缓存镜像，可以在构建时指定 --no-cache 参数，如：docker build --no-cache。

COPY 复制文件
