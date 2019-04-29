import com.baomidou.mybatisplus.generator.config.ConstVal;
import com.baomidou.mybatisplus.generator.config.FileOutConfig;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;

import java.io.File;
import java.util.Map;

/**
 * @program: fish-mybatisplus-generator
 * @description: ${description}
 * @author 郑仔祥
 * @since:
 **/
public class EntityQueryDTOFileOutConfig extends FileOutConfig {
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
            String file = String.format((pathInfo.get(ConstVal.SERVICE_PATH) + File.separator + "entity" + File.separator  + "%sQueryDTO.java"), entityName);
            return file;
        }
        return null;

    }

    @Override
    public String getTemplatePath() {
        return "templates/entityQueryDTO.java.ftl";
    }
}
