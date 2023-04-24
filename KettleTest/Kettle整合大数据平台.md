## Kettle整合大数据平台

1. 确保Hadoop的环境变量设置好HADOOP_USER_NAME为root

```shell
vi /etc/profile

HADOOP_USER_NAME=root
```

2. 从hadoop下载核心配置文件

   /software/hadoop/etc/hadoop/目录下的

   hdfs-site.xml和core-site.xml

3. 把hadoop核心配置文件(hdfs-site.xml和core-site.xml)放入kettle目录

```shell
data-integration\plugins\pentaho-big-data-plugin\hadoop-configurations\cdh514
```

4. 修改 `data-integration\plugins\pentaho-big-data-plugin\plugin.properties`文件

- 修改plugin.properties

```shell
active.hadoop.configuration=cdh514
```

plugin.propeties

```properties
active.hadoop.configuration=cdh514
```

