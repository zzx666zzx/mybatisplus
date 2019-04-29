package ${package.ServiceImpl};

import cn.winner.iwin.core.base.Pagination;
import cn.winner.iwin.core.exception.ExceptionBuilder;
import cn.winner.iwin.core.orika.OrikaBeanMapper;
import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${package.Service}.entity.${entity}QueryDTO;
import ${package.Service}.entity.${entity}SaveDTO;
import ${package.Service}.entity.${entity}UpdateDTO;
import ${package.Service}.entity.${entity}VO;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Calendar;
import java.util.List;

/**
 * <p>
 * ${table.comment} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

}
<#else>
public class ${table.serviceImplName}  implements ${table.serviceName} {

    @Autowired
    private  ${table.mapperName} ${table.mapperName?uncap_first};

    @Autowired
    private OrikaBeanMapper beanMapper;

    /**
     * 保存 ${table.comment}
     * @param bean ${table.comment} 对象
     * @return db主键
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long save(${entity}SaveDTO bean) {
       ${entity} ${entity?uncap_first} = beanMapper.map(bean,${entity}.class);
       ${entity?uncap_first}.setGmtCreate(Calendar.getInstance().getTime());
       ${table.mapperName?uncap_first}.insert(${entity?uncap_first});
       return ${entity?uncap_first}.getId();
    }

    /**
     * 更新 ${table.comment}
     * @param bean ${table.comment}对象
     * @return 更新对象的唯一键
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long edit(${entity}UpdateDTO bean){
       ${entity} ${entity?uncap_first} = beanMapper.map(bean,${entity}.class);
       ${entity?uncap_first}.setGmtModified(Calendar.getInstance().getTime());
       ${table.mapperName?uncap_first}.update(${entity?uncap_first});
       return ${entity?uncap_first}.getId();
    }

    /**
     * 批量删除 ${table.comment}
     * @param ids 事件ID集合
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean remove(List<Long> ids){
      if(ids == null || ids.isEmpty()){
            return Boolean.TRUE;
        }
        if(ids.size() == 1){
          ${table.mapperName?uncap_first}.delete(ids.get(0));
        }else{
          ${table.mapperName?uncap_first}.remove(ids);
        }
        return Boolean.TRUE;
    }

    /**
     * 查询${table.comment}对象
     * @param bean 查询对象
     * @return 返回分页对象
     */
    @Override
    public Pagination<${entity}VO> query(${entity}QueryDTO bean){
        ${entity} queryBean = beanMapper.map(bean,${entity}.class);
        PageHelper.startPage(bean.getPage(),bean.getPageSize());
        Page<${entity}> page  = (Page<${entity}>)${table.mapperName?uncap_first}.query(queryBean);
        Pagination<${entity}VO> result = new Pagination<>();
        result.setData(beanMapper.mapAsList(page.getResult(), ${entity}VO.class));
        result.setTotal(page.getTotal());
        return result;
    }

    /**
     * 获取${table.comment}对象
     * @param id 唯一键
     * @return 返回对象
     */
    @Override
    public ${entity}VO get(Long id){
        ${entity} ${entity?uncap_first} = ${table.mapperName?uncap_first}.get(id);
        if(null != ${entity?uncap_first}){
           return beanMapper.map(${entity?uncap_first},${entity}VO.class);
        }
        return null;
    }
}
</#if>
