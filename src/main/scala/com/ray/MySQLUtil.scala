package com.ray

import org.apache.spark.sql.functions.max
import org.apache.spark.sql.{DataFrame, SaveMode}

object MySQLUtil {

  val url = "jdbc:mysql://localhost:3306/spark?serverTimezone=Asia/Shanghai"
  val prop = new java.util.Properties
  prop.setProperty("user", "root")
  prop.setProperty("password", "WWESVR2012")
  prop.setProperty("driver", "com.mysql.cj.jdbc.Driver")

  def writeDevice(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write
      .option("createTableColumnTypes", "browserName VARCHAR(200), os VARCHAR(200), phoneBrand VARCHAR(200)")
      .mode(SaveMode.Overwrite)
    dfw.jdbc(url, "device", prop)
    println("成功写入device")
  }

  def writeBeahvior(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write
      .option("createTableColumnTypes", "TOADCODE VARCHAR(100), TTFACODE VARCHAR(100), " +
        "HTFACODE VARCHAR(100), CFDACODE VARCHAR(100), RFDACODE VARCHAR(100), " +
        "RFSMCODE VARCHAR(100), RFRACODE VARCHAR(100), RFSUCODE VARCHAR(100)")
      .mode(SaveMode.Overwrite)
    dfw.jdbc(url, "behavior", prop)
    println("成功写入behavior")
  }

  def writeDemographic(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, "demographic", prop)
    println("成功写入demographic")
  }

  def writePersonality(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, "personality", prop)
    println("成功写入personality")
  }

  /**
   * 读取MySQL表中的数据
   * @param tableName 数据库中的表名
   * @return dataframe对象
   */
  def readTable(tableName: String): DataFrame = {
    val df = App.spark.read.jdbc(url, tableName, prop)
    println("成功读取" + tableName)
    df
  }

  /**
   * 将dataframe写入MySQL数据库
   * @param dataFrame 要写入数据库的dataframe对象
   * @param tableName 要写入的数据库表名
   */
  def writeTable(dataFrame: DataFrame, tableName: String): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, tableName, prop)
    dataFrame.show(5)
    println("成功写入" + tableName)
  }

  /**
   * 写入第三类视图
   * @param dataFrame 第一类视图的dataframe对象
   * @param column behavior的列名
   */
  def writeTop(dataFrame: DataFrame, column: String): Unit = {
    val tableName = "v_top_" + column.toLowerCase()
    val df1 = dataFrame.groupBy("nationalityName", column + "Name")
      .count().orderBy("nationalityName")
    val df2 = df1.groupBy("nationalityName").agg(max("count"))
      .withColumnRenamed("max(count)", "count")
      .join(df1, Seq("nationalityName", "count"))
    val df3 = dataFrame.groupBy("nationalityName").count()
      .withColumnRenamed("count", "sum")
    val df4 = df2.join(df3,Seq("nationalityName"))
      .selectExpr("nationalityName", column + "Name", "count", "round(count/sum*100, 2)")
    val df5 = df4.withColumnRenamed(df4.columns(3), "percent")
      .orderBy("nationalityName")
    writeTable(df5, tableName)
  }

}
