package com.ray

import java.util.Date

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._

object App {

  val spark: SparkSession = SparkSession
    .builder()
    .master("local[8]")
    .appName("App")
    //    .enableHiveSupport()
    .getOrCreate()

  def main(args: Array[String]): Unit = {
    //    writeDatabase()
    //    createNationalityView()
    //    createAnalysisView()

    val startTime = new Date().getTime


    //读取csv文件
    val data = spark.read.format("csv").option("header", "true")
      .load(args(0))
    //更改列名(df包含所有列)
    val df = data.withColumnRenamed(data.columns(0), "pid")
      .withColumnRenamed("Q1_1_TEXT", "browserName")
      .withColumnRenamed("Q1_3_TEXT", "os")
      .withColumnRenamed("Q3_1_TEXT", "phoneBrand")
      .withColumnRenamed("Q5", "FOVASCode")
      .withColumnRenamed("Q15", "TOADCode")
      .withColumnRenamed("Q6", "ADPMCode")
      .withColumnRenamed("Q7", "TTFACode")
      .withColumnRenamed("Q8", "HTFACode")
      .withColumnRenamed("Q9", "CFDACode")
      .withColumnRenamed("Q10", "RFDACode")
      .withColumnRenamed("Q11", "RFSMCode")
      .withColumnRenamed("Q13", "RFRACode")
      .withColumnRenamed("Q14", "RFSUCode")
      .withColumnRenamed("Q16", "genderCode")
      .withColumnRenamed("Q17", "ageCode")
      .withColumnRenamed("Q19", "nationalityCode")
      .withColumnRenamed("Q23", "LOECode")
      .withColumnRenamed("Q27", "occupationCode")
      .withColumnRenamed("Q29", "LOHICode")
//    df.show(10)

    //device表
    var device = df.select(df.col("pid").cast(IntegerType), df.col("browserName"),
      df.col("os"), df.col("phoneBrand"))

    //behavior表
    var behavior = df.select(df.col("pid").cast(IntegerType), df.col("FOVASCode").cast(IntegerType),
      df.col("TOADCode"), df.col("ADPMCode").cast(IntegerType), df.col("TTFACode"),
      df.col("HTFACode"), df.col("CFDACode"), df.col("RFDACode"), df.col("RFSMCode"),
      df.col("RFRACode"), df.col("RFSUCode"))

    //demographic表
    var demographic = df.select(df.col("pid").cast(IntegerType), df.col("genderCode").cast(IntegerType),
      df.col("ageCode").cast(IntegerType), df.col("nationalityCode").cast(IntegerType),
      df.col("LOECode").cast(IntegerType), df.col("occupationCode").cast(IntegerType),
      df.col("LOHICode").cast(IntegerType))

    //personality表
    var df_personality = df.select(df.col("pid").cast(IntegerType), df.col("BigFiveE").cast(IntegerType),
      df.col("BigFiveN").cast(IntegerType), df.col("BigFiveA").cast(IntegerType),
      df.col("BigFiveO").cast(IntegerType), df.col("BigFiveC").cast(IntegerType))

    //删除空值
    device = device.filter("phoneBrand <> ' '")
    behavior = behavior.filter("FOVASCode is not null")
    demographic = demographic.filter("genderCode is not null")
    df_personality = df_personality.filter("BigFiveE is not null")

    //读取整体数据(v_overall中只有需要的列)
    val v_overall = device.join(behavior, Seq("pid")).join(demographic, Seq("pid"))
    val t_dim_nationality = MySQLUtil.readTable("t_dim_nationality")

    //v_device_nationality
    val v_device_nationality = v_overall.join(t_dim_nationality, Seq("nationalityCode")).
      select("pid", "browserName", "phoneBrand", "nationalityName").orderBy("pid")

    //读取behavior相关维表
    val t_dim_fovas = MySQLUtil.readTable("t_dim_fovas")
    val t_dim_cfda = MySQLUtil.readTable("t_dim_cfda")
    val t_dim_htfa = MySQLUtil.readTable("t_dim_htfa")
    val t_dim_rfda = MySQLUtil.readTable("t_dim_rfda")
    val t_dim_rfra = MySQLUtil.readTable("t_dim_rfra")
    val t_dim_rfsm = MySQLUtil.readTable("t_dim_rfsm")
    val t_dim_rfsu = MySQLUtil.readTable("t_dim_rfsu")
    val t_dim_toad = MySQLUtil.readTable("t_dim_toad")
    val t_dim_ttfa = MySQLUtil.readTable("t_dim_ttfa")

    //创建视图
    //v_fovas_nationality
    val v_overall_fovas = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("FOVASCode", explode(split(v_overall.col("FOVASCode"), "[,]")))
      .join(t_dim_fovas, Seq("FOVASCode"))
    val v_fovas_nationality = v_overall_fovas
      .select(v_overall_fovas.col("pid"), v_overall_fovas.col("FOVASCode").cast(IntegerType),
        v_overall_fovas.col("FOVASName"), v_overall_fovas.col("nationalityName"))
      .orderBy("pid", "FOVASCode")

    //v_cfda_nationality
    val v_overall_cfda = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("CFDACode", explode(split(v_overall.col("CFDACode"), "[,]")))
      .join(t_dim_cfda, Seq("CFDACode"))
    val v_cfda_nationality = v_overall_cfda
      .select(v_overall_cfda.col("pid"), v_overall_cfda.col("CFDACode").cast(IntegerType),
        v_overall_cfda.col("CFDAName"), v_overall_cfda.col("nationalityName"))
      .orderBy("pid", "CFDACode")

    //v_htfa_nationality
    val v_overall_htfa = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("HTFACode", explode(split(v_overall.col("HTFACode"), "[,]")))
      .join(t_dim_htfa, Seq("HTFACode"))
    val v_htfa_nationality = v_overall_htfa
      .select(v_overall_htfa.col("pid"), v_overall_htfa.col("HTFACode").cast(IntegerType),
        v_overall_htfa.col("HTFAName"), v_overall_htfa.col("nationalityName"))
      .orderBy("pid", "HTFACode")

    //v_rfda_nationality
    val v_overall_rfda = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("RFDACode", explode(split(v_overall.col("RFDACode"), "[,]")))
      .join(t_dim_rfda, Seq("RFDACode"))
    val v_rfda_nationality = v_overall_rfda
      .select(v_overall_rfda.col("pid"), v_overall_rfda.col("RFDACode").cast(IntegerType),
        v_overall_rfda.col("RFDAName"), v_overall_rfda.col("nationalityName"))
      .orderBy("pid", "RFDACode")

    //v_rfra_nationality
    val v_overall_rfra = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("RFRACode", explode(split(v_overall.col("RFRACode"), "[,]")))
      .join(t_dim_rfra, Seq("RFRACode"))
    val v_rfra_nationality = v_overall_rfra
      .select(v_overall_rfra.col("pid"), v_overall_rfra.col("RFRACode").cast(IntegerType),
        v_overall_rfra.col("RFRAName"), v_overall_rfra.col("nationalityName"))
      .orderBy("pid", "RFRACode")

    //v_rfsm_nationality
    val v_overall_rfsm = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("RFSMCode", explode(split(v_overall.col("RFSMCode"), "[,]")))
      .join(t_dim_rfsm, Seq("RFSMCode"))
    val v_rfsm_nationality = v_overall_rfsm
      .select(v_overall_rfsm.col("pid"), v_overall_rfsm.col("RFSMCode").cast(IntegerType),
        v_overall_rfsm.col("RFSMName"), v_overall_rfsm.col("nationalityName"))
      .orderBy("pid", "RFSMCode")

    //v_rfsu_nationality
    val v_overall_rfsu = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("RFSUCode", explode(split(v_overall.col("RFSUCode"), "[,]")))
      .join(t_dim_rfsu, Seq("RFSUCode"))
    val v_rfsu_nationality = v_overall_rfsu
      .select(v_overall_rfsu.col("pid"), v_overall_rfsu.col("RFSUCode").cast(IntegerType),
        v_overall_rfsu.col("RFSUName"), v_overall_rfsu.col("nationalityName"))
      .orderBy("pid", "RFSUCode")

    //v_toad_nationality
    val v_overall_toad = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("TOADCode", explode(split(v_overall.col("TOADCode"), "[,]")))
      .join(t_dim_toad, Seq("TOADCode"))
    val v_toad_nationality = v_overall_toad
      .select(v_overall_toad.col("pid"), v_overall_toad.col("TOADCode").cast(IntegerType),
        v_overall_toad.col("TOADName"), v_overall_toad.col("nationalityName"))
      .orderBy("pid", "TOADCode")

    //v_ttfa_nationality
    val v_overall_ttfa = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
      .withColumn("TTFACode", explode(split(v_overall.col("TTFACode"), "[,]")))
      .join(t_dim_ttfa, Seq("TTFACode"))
    val v_ttfa_nationality = v_overall_ttfa
      .select(v_overall_ttfa.col("pid"), v_overall_ttfa.col("TTFACode").cast(IntegerType),
        v_overall_ttfa.col("TTFAName"), v_overall_ttfa.col("nationalityName"))
      .orderBy("pid", "TTFACode")


    //读取demographic相关维表
    val t_dim_gender = MySQLUtil.readTable("t_dim_gender")
    val t_dim_age = MySQLUtil.readTable("t_dim_age")
    val t_dim_loe = MySQLUtil.readTable("t_dim_loe")
    val t_dim_occupation = MySQLUtil.readTable("t_dim_occupation")

    //v_analysis_ttfa
    val v_analysis_ttfa = demographic.join(v_ttfa_nationality, Seq("pid"))
      .join(t_dim_gender, Seq("genderCode"))
      .join(t_dim_age, Seq("ageCode"))
      .join(t_dim_loe, Seq("LOECode"))
      .join(t_dim_occupation, Seq("occupationCode"))
      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "TTFAName")
      .orderBy("pid")

    //v_analysis_toad
    val v_analysis_toad = demographic.join(v_toad_nationality, Seq("pid"))
      .join(t_dim_gender, Seq("genderCode"))
      .join(t_dim_age, Seq("ageCode"))
      .join(t_dim_loe, Seq("LOECode"))
      .join(t_dim_occupation, Seq("occupationCode"))
      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "TOADName")
      .orderBy("pid")

    //v_analysis_cfda
    val v_analysis_cfda = demographic.join(v_cfda_nationality, Seq("pid"))
      .join(t_dim_gender, Seq("genderCode"))
      .join(t_dim_age, Seq("ageCode"))
      .join(t_dim_loe, Seq("LOECode"))
      .join(t_dim_occupation, Seq("occupationCode"))
      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "CFDAName")
      .orderBy("pid")

    //v_analysis_rfda
    val v_analysis_rfda = demographic.join(v_rfda_nationality, Seq("pid"))
      .join(t_dim_gender, Seq("genderCode"))
      .join(t_dim_age, Seq("ageCode"))
      .join(t_dim_loe, Seq("LOECode"))
      .join(t_dim_occupation, Seq("occupationCode"))
      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "RFDAName")
      .orderBy("pid")

    //v_analysis_rfsu
    val v_analysis_rfsu = demographic.join(v_rfsu_nationality, Seq("pid"))
      .join(t_dim_gender, Seq("genderCode"))
      .join(t_dim_age, Seq("ageCode"))
      .join(t_dim_loe, Seq("LOECode"))
      .join(t_dim_occupation, Seq("occupationCode"))
      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "RFSUName")
      .orderBy("pid")

    val t_dim_lohi = MySQLUtil.readTable("t_dim_lohi")
    val t_dim_adpm = MySQLUtil.readTable("t_dim_adpm")

    val v_analysis_lohi = device.join(demographic, Seq("pid"))
      .join(v_rfsm_nationality, Seq("pid"))
      .join(t_dim_lohi, Seq("LOHICode"))
      .orderBy("LOHICode")
      .select("pid", "phoneBrand", "LOHICode", "LOHIName", "RFSMName")


    val v_fovas_adpm = behavior.join(t_dim_fovas, Seq("FOVASCode"))
      .join(t_dim_adpm, Seq("ADPMCode"))
      .select("pid", "FOVASCode", "FOVASName", "ADPMCode", "ADPMName")
      .orderBy("pid")


    //处理完成后一并写入数据库
    /*MySQLUtil.writeDevice(device)
    MySQLUtil.writeBeahvior(behavior)
    MySQLUtil.writeDemographic(demographic)
    MySQLUtil.writePersonality(df_personality)

    MySQLUtil.writeTable(v_fovas_nationality, "v_fovas_nationality")
    MySQLUtil.writeTable(v_device_nationality, "v_device_nationality")
    MySQLUtil.writeTable(v_cfda_nationality, "v_cfda_nationality")
    MySQLUtil.writeTable(v_htfa_nationality, "v_htfa_nationality")
    MySQLUtil.writeTable(v_rfda_nationality, "v_rfda_nationality")
    MySQLUtil.writeTable(v_rfra_nationality, "v_rfra_nationality")
    MySQLUtil.writeTable(v_rfsm_nationality, "v_rfsm_nationality")
    MySQLUtil.writeTable(v_rfsu_nationality, "v_rfsu_nationality")
    MySQLUtil.writeTable(v_toad_nationality, "v_toad_nationality")
    MySQLUtil.writeTable(v_ttfa_nationality, "v_ttfa_nationality")

    MySQLUtil.writeTable(v_analysis_ttfa, "v_analysis_ttfa")
    MySQLUtil.writeTable(v_analysis_toad, "v_analysis_toad")
    MySQLUtil.writeTable(v_analysis_cfda, "v_analysis_cfda")
    MySQLUtil.writeTable(v_analysis_rfda, "v_analysis_rfda")
    MySQLUtil.writeTable(v_analysis_rfsu, "v_analysis_rfsu")

    MySQLUtil.writeTable(v_analysis_lohi, "v_analysis_lohi")
    MySQLUtil.writeTable(v_fovas_adpm, "v_fovas_adpm")*/

    MySQLUtil.writeConclusion(v_fovas_nationality,"FOVAS")
    MySQLUtil.writeConclusion(v_cfda_nationality,"CFDA")
    MySQLUtil.writeConclusion(v_htfa_nationality,"HTFA")
    MySQLUtil.writeConclusion(v_rfda_nationality,"RFDA")
    MySQLUtil.writeConclusion(v_rfra_nationality,"RFRA")
    MySQLUtil.writeConclusion(v_rfsm_nationality,"RFSM")
    MySQLUtil.writeConclusion(v_rfsu_nationality,"RFSU")
    MySQLUtil.writeConclusion(v_toad_nationality,"TOAD")
    MySQLUtil.writeConclusion(v_ttfa_nationality,"TTFA")


//    val v_fovas_nationality = MySQLUtil.readTable("v_fovas_nationality")

    //等价于select nationalityName, FOVASName, count(*) y from v_fovas_nationality group by nationalityName, FOVASName order by nationalityName, y desc
//    val df1 = v_fovas_nationality.groupBy("nationalityName", "FOVASName").count().orderBy("nationalityName")
//    df1.show
//    val df2 = df1.groupBy("nationalityName").agg(max("count")).withColumnRenamed("max(count)", "count")
//    df2.show
//    df2.join(df1, Seq("nationalityName", "count")).orderBy("nationalityName").show()
    //    v_fovas_nationality.groupBy("nationalityName","FOVASName")
    //    v_fovas_nationality.show()
    //    spark.sql("select nationalityName, first(FOVASName), max(y) from (select nationalityName, FOVASName, count(*) y from v_fovas_nationality " +
    //      "group by nationalityName, FOVASName order by nationalityName, y desc) a group by nationalityName order by nationalityName").show

    println("全部结束")

    val endTime = new Date().getTime
    println("耗时：" + (endTime - startTime) / 1000.0 + "s")

  }

  /**
   * 将数据集写入数据库（三张表）
   */
  //  def writeDatabase(): Unit = {
  //    //读取csv文件
  //    val data = spark.read.format("csv").option("header", "true")
  //      .load("C:\\Users\\a6481\\Documents\\Courseware\\GraduationDesign\\data\\data6.csv")
  //    //更改列名
  //    val df = data.withColumnRenamed(data.columns(0), "pid")
  //      .withColumnRenamed("Q1_1_TEXT", "browserName")
  //      .withColumnRenamed("Q1_3_TEXT", "os")
  //      .withColumnRenamed("Q3_1_TEXT", "phoneBrand")
  //      .withColumnRenamed("Q5", "FOVASCode")
  //      .withColumnRenamed("Q15", "TOADCode")
  //      .withColumnRenamed("Q6", "ADPMCode")
  //      .withColumnRenamed("Q7", "TTFACode")
  //      .withColumnRenamed("Q8", "HTFACode")
  //      .withColumnRenamed("Q9", "CFDACode")
  //      .withColumnRenamed("Q10", "RFDACode")
  //      .withColumnRenamed("Q11", "RFSMCode")
  //      .withColumnRenamed("Q13", "RFRACode")
  //      .withColumnRenamed("Q14", "RFSUCode")
  //      .withColumnRenamed("Q16", "genderCode")
  //      .withColumnRenamed("Q17", "ageCode")
  //      .withColumnRenamed("Q19", "nationalityCode")
  //      .withColumnRenamed("Q23", "LOECode")
  //      .withColumnRenamed("Q27", "occupationCode")
  //      .withColumnRenamed("Q29", "LOHICode")
  //    df.show(10)
  //
  //    //device表
  //    var device = df.select(df.col("pid").cast(IntegerType), df.col("browserName"),
  //      df.col("os"), df.col("phoneBrand"))
  //
  //    //behavior表
  //    var behavior = df.select(df.col("pid").cast(IntegerType), df.col("FOVASCode").cast(IntegerType),
  //      df.col("TOADCode"), df.col("ADPMCode").cast(IntegerType), df.col("TTFACode"),
  //      df.col("HTFACode"), df.col("CFDACode"), df.col("RFDACode"), df.col("RFSMCode"),
  //      df.col("RFRACode"), df.col("RFSUCode"))
  //
  //    //demographic表
  //    var demographic = df.select(df.col("pid").cast(IntegerType), df.col("genderCode").cast(IntegerType),
  //      df.col("ageCode").cast(IntegerType), df.col("nationalityCode").cast(IntegerType),
  //      df.col("LOECode").cast(IntegerType), df.col("occupationCode").cast(IntegerType),
  //      df.col("LOHICode").cast(IntegerType))
  //
  //    //personality表
  //    var df_personality = df.select(df.col("pid").cast(IntegerType), df.col("BigFiveE").cast(IntegerType),
  //      df.col("BigFiveN").cast(IntegerType), df.col("BigFiveA").cast(IntegerType),
  //      df.col("BigFiveO").cast(IntegerType), df.col("BigFiveC").cast(IntegerType))
  //
  //    //删除空值
  //    device = device.filter("phoneBrand <> ' '")
  //    behavior = behavior.filter("FOVASCode is not null")
  //    demographic = demographic.filter("genderCode is not null")
  //    df_personality = df_personality.filter("BigFiveE is not null")
  //
  //    //    device.selectExpr("*","if(browserName=' ','Other',browserName)")
  //    MySQLUtil.writeDevice(device)
  //    MySQLUtil.writeBeahvior(behavior)
  //    MySQLUtil.writeDemographic(demographic)
  //    MySQLUtil.writePersonality(df_personality)
  //  }

  /**
   * 创建视图（实际上是创建表）
   */
  //  def createNationalityView(): Unit = {
  //
  //    //读取三张原始表
  //    val device = MySQLUtil.readTable("device")
  //    val behavior = MySQLUtil.readTable("behavior")
  //    val demographic = MySQLUtil.readTable("demographic")
  ////    device.createOrReplaceTempView("device")
  ////    behavior.createOrReplaceTempView("behavior")
  ////    demographic.createOrReplaceTempView("demographic")
  //
  //    //读取整体数据
  //    val v_overall = device.join(behavior, Seq("pid")).join(demographic, Seq("pid"))
  //    val t_dim_nationality = MySQLUtil.readTable("t_dim_nationality")
  //
  //    //v_device_nationality
  //    val v_device_nationality = v_overall.join(t_dim_nationality, Seq("nationalityCode")).
  //      select("pid", "browserName", "phoneBrand", "nationalityName").orderBy("pid")
  //
  //    //读取behavior相关维表
  //    val t_dim_fovas = MySQLUtil.readTable("t_dim_fovas")
  //    val t_dim_cfda = MySQLUtil.readTable("t_dim_cfda")
  //    val t_dim_htfa = MySQLUtil.readTable("t_dim_htfa")
  //    val t_dim_rfda = MySQLUtil.readTable("t_dim_rfda")
  //    val t_dim_rfra = MySQLUtil.readTable("t_dim_rfra")
  //    val t_dim_rfsm = MySQLUtil.readTable("t_dim_rfsm")
  //    val t_dim_rfsu = MySQLUtil.readTable("t_dim_rfsu")
  //    val t_dim_toad = MySQLUtil.readTable("t_dim_toad")
  //    val t_dim_ttfa = MySQLUtil.readTable("t_dim_ttfa")
  //
  //
  //    //v_fovas_nationality
  //    val v_overall_fovas = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("FOVASCode", explode(split(v_overall.col("FOVASCode"), "[,]")))
  //      .join(t_dim_fovas, Seq("FOVASCode"))
  //    val v_fovas_nationality = v_overall_fovas
  //      .select(v_overall_fovas.col("pid"), v_overall_fovas.col("FOVASCode").cast(IntegerType),
  //        v_overall_fovas.col("FOVASName"), v_overall_fovas.col("nationalityName"))
  //      .orderBy("pid", "FOVASCode")
  //
  //    //v_cfda_nationality
  //    val v_overall_cfda = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("CFDACode", explode(split(v_overall.col("CFDACode"), "[,]")))
  //      .join(t_dim_cfda, Seq("CFDACode"))
  //    val v_cfda_nationality = v_overall_cfda
  //      .select(v_overall_cfda.col("pid"), v_overall_cfda.col("CFDACode").cast(IntegerType),
  //        v_overall_cfda.col("CFDAName"), v_overall_cfda.col("nationalityName"))
  //      .orderBy("pid", "CFDACode")
  //
  //    //v_htfa_nationality
  //    val v_overall_htfa = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("HTFACode", explode(split(v_overall.col("HTFACode"), "[,]")))
  //      .join(t_dim_htfa, Seq("HTFACode"))
  //    val v_htfa_nationality = v_overall_htfa
  //      .select(v_overall_htfa.col("pid"), v_overall_htfa.col("HTFACode").cast(IntegerType),
  //        v_overall_htfa.col("HTFAName"), v_overall_htfa.col("nationalityName"))
  //      .orderBy("pid", "HTFACode")
  //
  //    //v_rfda_nationality
  //    val v_overall_rfda = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("RFDACode", explode(split(v_overall.col("RFDACode"), "[,]")))
  //      .join(t_dim_rfda, Seq("RFDACode"))
  //    val v_rfda_nationality = v_overall_rfda
  //      .select(v_overall_rfda.col("pid"), v_overall_rfda.col("RFDACode").cast(IntegerType),
  //        v_overall_rfda.col("RFDAName"), v_overall_rfda.col("nationalityName"))
  //      .orderBy("pid", "RFDACode")
  //
  //    //v_rfra_nationality
  //    val v_overall_rfra = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("RFRACode", explode(split(v_overall.col("RFRACode"), "[,]")))
  //      .join(t_dim_rfra, Seq("RFRACode"))
  //    val v_rfra_nationality = v_overall_rfra
  //      .select(v_overall_rfra.col("pid"), v_overall_rfra.col("RFRACode").cast(IntegerType),
  //        v_overall_rfra.col("RFRAName"), v_overall_rfra.col("nationalityName"))
  //      .orderBy("pid", "RFRACode")
  //
  //    //v_rfsm_nationality
  //    val v_overall_rfsm = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("RFSMCode", explode(split(v_overall.col("RFSMCode"), "[,]")))
  //      .join(t_dim_rfsm, Seq("RFSMCode"))
  //    val v_rfsm_nationality = v_overall_rfsm
  //      .select(v_overall_rfsm.col("pid"), v_overall_rfsm.col("RFSMCode").cast(IntegerType),
  //        v_overall_rfsm.col("RFSMName"), v_overall_rfsm.col("nationalityName"))
  //      .orderBy("pid", "RFSMCode")
  //
  //    //v_rfsu_nationality
  //    val v_overall_rfsu = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("RFSUCode", explode(split(v_overall.col("RFSUCode"), "[,]")))
  //      .join(t_dim_rfsu, Seq("RFSUCode"))
  //    val v_rfsu_nationality = v_overall_rfsu
  //      .select(v_overall_rfsu.col("pid"), v_overall_rfsu.col("RFSUCode").cast(IntegerType),
  //        v_overall_rfsu.col("RFSUName"), v_overall_rfsu.col("nationalityName"))
  //      .orderBy("pid", "RFSUCode")
  //
  //    //v_toad_nationality
  //    val v_overall_toad = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("TOADCode", explode(split(v_overall.col("TOADCode"), "[,]")))
  //      .join(t_dim_toad, Seq("TOADCode"))
  //    val v_toad_nationality = v_overall_toad
  //      .select(v_overall_toad.col("pid"), v_overall_toad.col("TOADCode").cast(IntegerType),
  //        v_overall_toad.col("TOADName"), v_overall_toad.col("nationalityName"))
  //      .orderBy("pid", "TOADCode")
  //
  //    //v_ttfa_nationality
  //    val v_overall_ttfa = v_overall.join(t_dim_nationality, Seq("nationalityCode"))
  //      .withColumn("TTFACode", explode(split(v_overall.col("TTFACode"), "[,]")))
  //      .join(t_dim_ttfa, Seq("TTFACode"))
  //    val v_ttfa_nationality = v_overall_ttfa
  //      .select(v_overall_ttfa.col("pid"), v_overall_ttfa.col("TTFACode").cast(IntegerType),
  //        v_overall_ttfa.col("TTFAName"), v_overall_ttfa.col("nationalityName"))
  //      .orderBy("pid", "TTFACode")
  //
  //    //    MySQLUtil.writeTable(v_overall, "v_overall")
  //    MySQLUtil.writeTable(v_fovas_nationality, "v_fovas_nationality")
  //    MySQLUtil.writeTable(v_device_nationality, "v_device_nationality")
  //    MySQLUtil.writeTable(v_cfda_nationality, "v_cfda_nationality")
  //    MySQLUtil.writeTable(v_htfa_nationality, "v_htfa_nationality")
  //    MySQLUtil.writeTable(v_rfda_nationality, "v_rfda_nationality")
  //    MySQLUtil.writeTable(v_rfra_nationality, "v_rfra_nationality")
  //    MySQLUtil.writeTable(v_rfsm_nationality, "v_rfsm_nationality")
  //    MySQLUtil.writeTable(v_rfsu_nationality, "v_rfsu_nationality")
  //    MySQLUtil.writeTable(v_toad_nationality, "v_toad_nationality")
  //    MySQLUtil.writeTable(v_ttfa_nationality, "v_ttfa_nationality")
  //
  //  }

  /**
   * 创建视图（实际上是创建表）
   */
  //  def createAnalysisView(): Unit = {
  //
  //    //读取demographic相关维表
  //    val t_dim_gender = MySQLUtil.readTable("t_dim_gender")
  //    val t_dim_age = MySQLUtil.readTable("t_dim_age")
  //    val t_dim_loe = MySQLUtil.readTable("t_dim_loe")
  //    val t_dim_occupation = MySQLUtil.readTable("t_dim_occupation")
  //
  //    val demographic = MySQLUtil.readTable("demographic")
  //    val v_ttfa_nationality = MySQLUtil.readTable("v_ttfa_nationality")
  //    val v_toad_nationality = MySQLUtil.readTable("v_toad_nationality")
  //    val v_cfda_nationality = MySQLUtil.readTable("v_cfda_nationality")
  //    val v_rfda_nationality = MySQLUtil.readTable("v_rfda_nationality")
  //    val v_rfsu_nationality = MySQLUtil.readTable("v_rfsu_nationality")
  //
  //    //    val v_analysis = demographic.join(v_ttfa_nationality, Seq("pid"))
  //    //      .join(v_toad_nationality, Seq("pid"))
  //    //      .join(v_cfda_nationality, Seq("pid"))
  //    //      .join(v_rfda_nationality, Seq("pid"))
  //    //      .join(v_rfsu_nationality, Seq("pid"))
  //    //      .join(t_dim_gender, Seq("genderCode"))
  //    //      .join(t_dim_age, Seq("ageCode"))
  //    //      .join(t_dim_loe, Seq("LOECode"))
  //    //      .join(t_dim_occupation, Seq("occupationCode"))
  //
  //    //v_analysis_ttfa
  //    //    val v_analysis_ttfa = v_analysis.select("pid", "genderName", "ageName", "LOEName", "occupationName", "TTFAName")
  //    //      .orderBy("pid")
  //    val v_analysis_ttfa = demographic.join(v_ttfa_nationality, Seq("pid"))
  //      .join(t_dim_gender, Seq("genderCode"))
  //      .join(t_dim_age, Seq("ageCode"))
  //      .join(t_dim_loe, Seq("LOECode"))
  //      .join(t_dim_occupation, Seq("occupationCode"))
  //      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "TTFAName")
  //      .orderBy("pid")
  //
  //    //v_analysis_toad
  //    val v_analysis_toad = demographic.join(v_toad_nationality, Seq("pid"))
  //      .join(t_dim_gender, Seq("genderCode"))
  //      .join(t_dim_age, Seq("ageCode"))
  //      .join(t_dim_loe, Seq("LOECode"))
  //      .join(t_dim_occupation, Seq("occupationCode"))
  //      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "TOADName")
  //      .orderBy("pid")
  //
  //    //v_analysis_cfda
  //    val v_analysis_cfda = demographic.join(v_cfda_nationality, Seq("pid"))
  //      .join(t_dim_gender, Seq("genderCode"))
  //      .join(t_dim_age, Seq("ageCode"))
  //      .join(t_dim_loe, Seq("LOECode"))
  //      .join(t_dim_occupation, Seq("occupationCode"))
  //      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "CFDAName")
  //      .orderBy("pid")
  //
  //    //v_analysis_rfda
  //    val v_analysis_rfda = demographic.join(v_rfda_nationality, Seq("pid"))
  //      .join(t_dim_gender, Seq("genderCode"))
  //      .join(t_dim_age, Seq("ageCode"))
  //      .join(t_dim_loe, Seq("LOECode"))
  //      .join(t_dim_occupation, Seq("occupationCode"))
  //      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "RFDAName")
  //      .orderBy("pid")
  //
  //    //v_analysis_rfsu
  //    val v_analysis_rfsu = demographic.join(v_rfsu_nationality, Seq("pid"))
  //      .join(t_dim_gender, Seq("genderCode"))
  //      .join(t_dim_age, Seq("ageCode"))
  //      .join(t_dim_loe, Seq("LOECode"))
  //      .join(t_dim_occupation, Seq("occupationCode"))
  //      .select("pid", "genderCode", "genderName", "ageCode", "ageName", "LOECode", "LOEName", "occupationName", "RFSUName")
  //      .orderBy("pid")
  //
  //
  //    MySQLUtil.writeTable(v_analysis_ttfa, "v_analysis_ttfa")
  //    MySQLUtil.writeTable(v_analysis_toad, "v_analysis_toad")
  //    MySQLUtil.writeTable(v_analysis_cfda, "v_analysis_cfda")
  //    MySQLUtil.writeTable(v_analysis_rfda, "v_analysis_rfda")
  //    MySQLUtil.writeTable(v_analysis_rfsu, "v_analysis_rfsu")
  //
  //  }

  /**
   * 将上一步创建的表转换为视图（舍弃）
   */
  //  def tableToView(): Unit = {
  //    val url = "jdbc:mysql://localhost:3306/spark?serverTimezone=Asia/Shanghai"
  //    val prop = new java.util.Properties
  //    prop.setProperty("user", "root")
  //    prop.setProperty("password", "WWESVR2012")
  //    prop.setProperty("driver", "com.mysql.cj.jdbc.Driver")
  //    val conn = DriverManager.getConnection(url, prop);
  //    val ps = conn.createStatement()
  //    ps.addBatch("create or replace view v_cfda_nationality as select * from t_toad_nationality;")
  //    ps.addBatch("create or replace view v_htfa_nationality as select * from t_htfa_nationality;")
  //    ps.addBatch("create or replace view v_rfda_nationality as select * from t_rfda_nationality;")
  //    ps.addBatch("create or replace view v_rfra_nationality as select * from t_rfra_nationality;")
  //    ps.addBatch("create or replace view v_rfsm_nationality as select * from t_rfsm_nationality;")
  //    ps.addBatch("create or replace view v_rfsu_nationality as select * from t_rfsu_nationality;")
  //    ps.addBatch("create or replace view v_toad_nationality as select * from t_toad_nationality;")
  //    ps.addBatch("create or replace view v_device_nationality as select * from t_device_nationality;")
  //    ps.addBatch("drop table t_toad_nationality;")
  //    ps.addBatch("drop table t_htfa_nationality;")
  //    ps.addBatch("drop table t_rfda_nationality;")
  //    ps.addBatch("drop table t_rfra_nationality;")
  //    ps.addBatch("drop table t_rfsm_nationality;")
  //    ps.addBatch("drop table t_rfsu_nationality;")
  //    ps.addBatch("drop table t_toad_nationality;")
  //    ps.addBatch("drop table t_device_nationality;")
  //    ps.executeBatch()
  //    if (ps != null)
  //      ps.close()
  //    if (conn != null)
  //      conn.close()
  //  }

}

