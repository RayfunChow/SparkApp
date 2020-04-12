package com.ray

import java.sql.DriverManager

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
    println("成功写入device表")
  }

  def writeBeahvior(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write
      .option("createTableColumnTypes", "TOADCODE VARCHAR(200), TTFACODE VARCHAR(200), HTFACODE VARCHAR(200), " +
        "CFDACODE VARCHAR(200), RFDACODE VARCHAR(200), RFSMCODE VARCHAR(200), RFRACODE VARCHAR(200), RFSUCODE VARCHAR(200)")
      .mode(SaveMode.Overwrite)
    dfw.jdbc(url, "behavior", prop)
    println("成功写入behavior表")
  }

  def writeDemographic(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, "demographic", prop)
    println("成功写入demographic表")
  }

  def writePersonality(dataFrame: DataFrame): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, "personality", prop)
    println("成功写入personality表")
  }

  def readTable(tableName: String): DataFrame = {
    val df = App.spark.read.jdbc(url, tableName, prop)
    df
  }

  def writeTable(dataFrame: DataFrame, tableName: String): Unit = {
    val dfw = dataFrame.write.mode(SaveMode.Overwrite)
    dfw.jdbc(url, tableName, prop)
    println("成功写入" + tableName + "表")
  }

}