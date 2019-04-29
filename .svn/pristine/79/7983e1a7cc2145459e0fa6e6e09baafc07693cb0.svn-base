import com.baomidou.mybatisplus.generator.config.ConstVal;
import com.baomidou.mybatisplus.generator.config.FileOutConfig;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * @program: fish-mybatisplus-generator
 * @description: ${description}
 * @author 郑仔祥
 * @since:
 **/
public class H5IndexJSFileOutConfig extends FileOutConfig {

    /**
     * 输出文件
     *
     * @param pathInfo
     * @param tableInfo
     */
    @Override
    public String outputFile(Map<String, String> pathInfo, TableInfo tableInfo) {
        String entityName = tableInfo.getEntityName();
        if (null != pathInfo.get(ConstVal.SERVICE_PATH)) {
            String servicePath = pathInfo.get(ConstVal.SERVICE_PATH);
            String file = String.format(h5Path(servicePath) + "%s.js", StringUtils.uncapitalize(entityName));
            return file;
        }
        return null;
    }

    @Override
    public String getTemplatePath() {
        return "templates/api.js.ftl";
    }


    private String h5Path(String path){
        return StringUtils.substringBefore(path,"cn");
    }
}
