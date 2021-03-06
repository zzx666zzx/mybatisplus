import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.rules.DbType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.ArrayList;

/**
 * @program: fish-mybatisplus-generator
 * @description: 代码生成
 * @author 郑仔祥
 * @since:
 **/
public class CodeGenerator {
	
	//保存在本地路径名文件夹名称
	private static final String dir="E:\\test\\";
	//默认包名
    private static final String basePackage = "zzx";
    //数据库类型
    private static final DbType daType=DbType.MYSQL;
    //数据库连接URL
    private static final String dbUrl="jdbc:mysql://47.98.187.113:3306/student?characterEncoding=utf-8";
    //用户名
    private static final String username="root";
    //密码
    private static final String password="123456";
    //驱动名
    private static final String driverName="com.mysql.jdbc.Driver";
    
    //注释作者名
    private static final String author="zhengzixiang";
    
    public static void main(String[] args) {
    	String[] str=new String[]{"sys_professional","sys_department","sys_class"};
        generateByTables(true,basePackage, "",str);
    }

    /**
               * 通过表生成实体类
     * @param serviceNameStartWithI service接口的名称是否I开头起名 
     * @param packageName			包名
     * @param model					model的包名
     * @param tableNames			表名
     */
    private static void generateByTables(boolean serviceNameStartWithI, String packageName, String model,String... tableNames) {
        
        //1.数据源配置
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        dataSourceConfig.setDbType(daType)
                .setUrl(dbUrl)
                .setUsername(username)
                .setPassword(password)
                .setDriverName(driverName);
        
        //2. 策略配置globalConfiguration中
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig
                .setCapitalMode(true)//全局大写命名
                .setEntityLombokModel(false)// 【实体】是否为lombok模型（默认 false）
                .setDbColumnUnderline(true)// 指定表名 字段名是否使用下划线
                .setNaming(NamingStrategy.underline_to_camel)//数据库表映射到实体的命名策略
                .setRestControllerStyle(true).setSuperMapperClass("zzx.dao.BaseDAO")
//                .setSuperControllerClass("cn.winner.iwin.web.core.bean.BaseController")// 自定义 controller 父类
                .setRestControllerStyle(true)
                .setControllerMappingHyphenStyle(true)
//                .setTablePrefix("ias_", "t_")// 此处可以修改为您的表前缀，表示生成时去掉表的前缀
                .setInclude(tableNames);// 生成的表
        
        //3.全局配置
        GlobalConfig config = new GlobalConfig();
        config.setActiveRecord(false)// 是否支持AR模式
                // XML 二级缓存
        .setEnableCache(false)
        .setBaseResultMap(true)//生成基本的resultMap
        .setBaseColumnList(true)//生成基本的SQL片段 
                .setAuthor(author) // 作者
                .setOutputDir(dir)// 生成路径
                .setFileOverride(true);// 文件覆盖
        if (!serviceNameStartWithI) {
            config.setServiceName("%sService");// 设置生成的service接口的名字的首字母是否为I
        }
        InjectionConfig injectionConfig = new InjectionConfig() {
            @Override
            public void initMap() {

            }
        };
        //自定义模板
        injectionConfig.setFileOutConfigList(new ArrayList<FileOutConfig>(){{
            add(new EntitySaveDTOFileOutConfig());
            add(new EntityQueryDTOFileOutConfig());
            add(new EntityUpdateDTOFileOutConfig());
            add(new EntityVOFileOutConfig());
            add(new H5IndexVueFileOutConfig());
            add(new H5IndexJSFileOutConfig());
        }});
        //5. 整合配置
        new AutoGenerator().setGlobalConfig(config)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setCfg(injectionConfig)
                .setPackageInfo(
                        new PackageConfig()
                                .setModuleName(model)
                                .setParent(packageName)// 自定义包路径
                                .setController("controller")// 这里是控制器包名，默认 web
                                .setEntity("entity")
                                .setMapper("dao")
                                .setService("service")
                                .setServiceImpl("service.impl")
                                .setXml("mapper")
                ).setTemplateEngine(new FreemarkerTemplateEngine()).execute();
    }

}
