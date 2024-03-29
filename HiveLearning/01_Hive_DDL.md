可以使用sublime、VSCode等编辑器进行HQL编写

可以使用idea连接hive进行HQL的编写

### DDL（Data Definition Language 数据定义语言）作用

![image-20230427012331085](img/image-20230427012331085.png)

![image-20230427012357640](img/image-20230427012357640.png)

### 建表语法

[ ]表示可选语法， |表示选其一，顺序需按如下语法树

```hive
CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.]table_name  [(col_name data_type [COMMENT col_comment], ... ]  [COMMENT table_comment]  [PARTITIONED BY (col_name data_type [COMMENT col_comment], ...)]  [CLUSTERED BY (col_name, col_name, ...) [SORTED BY (col_name [ASC|DESC], ...)] INTO num_buckets BUCKETS]  [ROW FORMAT DELIMITED|SERDE serde_name WITH SERDEPROPERTIES (property_name=property_value,...)]  [STORED AS file_format]  [LOCATION hdfs_path]  [TBLPROPERTIES (property_name=property_value, ...)];
```

```hive
```

### Hive数据类型

分原生数据类型和复杂数据类型

![image-20230427013331849](img/image-20230427013331849.png)

![image-20230427013237893](img/image-20230427013237893.png)

原生数据类型

![image-20230427013538699](img/image-20230427013538699.png)

复杂数据类型

![image-20230427013710168](img/image-20230427013710168.png)

![image-20230427013749790](img/image-20230427013749790.png)

数据类型的隐式转换 原生类型从窄到宽![image-20230427013929282](img/image-20230427013929282.png)

显示转换 使用 CAST函数

```hive
CAST('内容' as 目标数据类型)，转换失败则返回 NULL
```

### Hive读写文件机制

- SerDe是Serializer、Deserializer的简称，目的是用于序列化和反序列化。
- **序列化是对象转化为字节码的过程**；而反**序列化是字节码转换为对象的过程。**
- Hive使用SerDe（包括FileFormat）读取和写入表行对象。需要注意的是，“key”部分在读取时会被忽略，而在写入时key始终是常数。基本上行**对象存储在value**中。

![image-20230427014621881](img/image-20230427014621881.png)

 Read：

HDFS Files --> InputFileFormat --> <key,value> --> Deserializer --> Row Object

Write:

Row Object --> Serializer --> <key,value> --> OutputFileFormat --> HDFS Files

SerDe相关语法

ROW FORMAT这一行所代表的是跟读写文件、序列化SerDe相关的语法，功能有二：

- 使用哪个SerDe类进行序列化；
- 如何指定分隔符。

```hive
ROW FORMAT DELIMITED| SERDE serde_name WITH SERDEPROPERTIES (property_name=property_value,...)
```

![image-20230428234024171](img/image-20230428234024171.png)

![image-20230428234043038](img/image-20230428234043038.png)

![image-20230428234122699](img/image-20230428234122699.png)

如果没写ROW FORMAT，默认分隔符为 '\001'0

![image-20230428234457785](img/image-20230428234457785.png)

![image-20230428234527963](img/image-20230428234527963.png)

### Hive 指定存储路径

默认路径由${HIVE_HOME}/conof/hive-site.xml文件中的hive.metastore.warehouse.dir属性指定，默认值是：/user/hive/warehouse

语法为 ：LOCATION '<hdfs_location>'

### DDL建表练习

#### 原生数据类型

```hive
use test02;
create table t_archer(
    id int comment "ID",
    name string comment "英雄名称",
    hp_max int comment "最大生命",
    mp_max int comment "最大法力",
    attack_max int comment "最高物攻",
    defense_max int comment "最大物防",
    attack_range string comment "攻击范围",
    role_main string comment "主要定位",
    role_assist string comment "次要定位"
) comment "王者荣耀射手信息"
    row format delimited
        fields terminated by "\t";

show tables;

-- 建表之后表数据为空，将数据文件上传到Hive路径后刷新得到内容 
```

```shell
hadoop fs -put /data/dataset/archer.txt /user/hive/warehouse/test02.db/t_archer
```

![image-20230429102936419](img/image-20230429102936419.png)

#### 复杂数据类型

![image-20230429111605661](img/image-20230429111605661.png)

如上可以看到map映射的kv键值对，需要注意字段间的分隔符、集合元素间的分割符、map kv之间的分隔符；

```hive
use test02;
create table t_archer(
    id int comment "ID",
    name string comment "英雄名称",
    hp_max int comment "最大生命",
    mp_max int comment "最大法力",
    attack_max int comment "最高物攻",
    defense_max int comment "最大物防",
    attack_range string comment "攻击范围",
    role_main string comment "主要定位",
    role_assist string comment "次要定位"
) comment "王者荣耀射手信息"
    row format delimited
        fields terminated by "\t";

show tables;

select * from t_archer;

create table t_hot_hero_skin_price(
    id int,
    name string,
    win_rate int,
    skin_price map<string,int>
) row format delimited
fields terminated by ',' --指定字段之间的分隔符
collection items terminated by '-' --指定集合元素之间的分隔符
map keys terminated by ':';  --指定m kv之间的分隔符

select * from t_hot_hero_skin_price
```

