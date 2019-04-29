package ${package.Mapper};

import ${package.Entity}.${entity};
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * ${table.comment} Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {
    /**
     * 获取${table.comment}
     * @param id 主键
     * @return  ${table.comment}
     */
    ${entity} get(@Param("id") Long id);

    /**
     * 查询 ${table.comment}
     * @param bean 查询条件
     * @return 集合结果
     */
    List<${entity}> query(@Param("bean") ${entity} bean);

    /**
     * 保存${table.comment}
     * @param bean 字典对象
     */
    void insert(${entity} bean);

    /**
     * 更新${table.comment}
     * @param bean 更新对象
     */
    void update(@Param("bean") ${entity} bean);

    /**
     * 单个删除${table.comment}
     * @param id id
     */
    void delete(@Param("id") Long id);

    /**
     * 批量删除${table.comment}
     * @param ids id 集合
     */
    void remove(@Param("ids") List<Long> ids);
}
</#if>
