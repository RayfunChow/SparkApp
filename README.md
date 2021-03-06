### 使用Spark DataFrame创建MySQL数据表

*   列数：df.columns.length
*   行数：df.count
*   更改列名：df.withColumnRenamed("_1", "x1")
*   删除缺失值：df.na.drop
*   选择空值、空字符串：
    *   df.filter("id is null").select("id").show() 
    *   df.filter(df("id").isNull).select("id").show()
    *   data1.filter("gender is not null").select("gender").limit(10).show  
    *   data1.filter("gender<>''").select("gender").limit(10).show
    *   df.where("BigFiveE == ' '").count() 
*   写数据库时指定字段类型(Spark 2.1.0不支持)：  
    df.write.option("createTableColumnTypes", "columnName VARCHAR(200)")      
*   Spark SQL中列类型为String的在MySQL中对应为Text类型     
*   Spark 2.1 不支持 createTableColumnTypes
*   创建临时视图：df.createOrReplaceTempView("temp_view")
*   写入数据库：df.write.mode(savemode).jdbc(url,table,prop)
*   读取数据库：val df = spark.read.jdbc(url,table,prop)
*   Spark SQL列重命名：  
    *   df = createOrReplaceTempView(view)  
        df.selectExpr("id as ID").show
    *   spark.sql("select * from view").show
*   取前n条结果：df.limit(n)  df.head(n)  
*   降序排序：  
    import org.apache.spark.sql.functions._  
    df.orderBy(desc("column"))  
*   列类型转换：df.col("column").cast(IntegerType)
*   一行转多行：df.withColumn("column", explode(split($"genre", "[|]"))).show
*   MySQL的jdbc不支持同时执行多条sql语句，用批处理：
    *   ps.addBatch()
    *   ps.executeBatch()
*   删除表视图还存在，但是不能用了     
*   删除重复值：dropDuplicates(colName)

*   spark-submit命令：  
`./spark-submit --class "com.ray.App" ~/IdeaProjects/SparkApp/out/artifacts/SparkApp_jar/SparkApp.jar /user/ray/input/data6.csv
`
*   hdfs路径(Ubuntu)：hdfs://localhost:9000/user/ray/input/data6.csv
*   本地路径(Ubuntu)：file:///home/ray/文档/data6.csv
*   本地路径(Windows)：C:\Users\a6481\Documents\Courseware\GraduationDesign\data\data6.csv