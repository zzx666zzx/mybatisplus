package ${package.Service};

import cn.winner.iwin.core.base.Pagination;
import ${package.Entity}.${entity};
import ${package.Service}.entity.${entity}QueryDTO;
import ${package.Service}.entity.${entity}SaveDTO;
import ${package.Service}.entity.${entity}UpdateDTO;
import ${package.Service}.entity.${entity}VO;
import java.util.List;
/**
 * <p>
 * ${table.comment} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} {
    /**
     * 保存 ${table.comment}
     * @param bean ${table.comment} 对象
     * @return db主键
     */
    Long save(${entity}SaveDTO bean);

    /**
     * 更新 ${table.comment}
     * @param bean ${table.comment}对象
     * @return 更新对象的唯一键
     */
    Long edit(${entity}UpdateDTO bean);

    /**
     * 批量删除 ${table.comment}
     * @param ids 事件ID集合
     * @return
     */
    Boolean remove(List<Long> ids);

    /**
     * 查询${table.comment}对象
     * @param bean 查询对象
     * @return 返回分页对象
     */
    Pagination<${entity}VO> query(${entity}QueryDTO bean);

   /**
     * 获取${table.comment}对象
     * @param id 唯一键
     * @return 返回对象
     */
    ${entity}VO get(Long id);
}
</#if>
