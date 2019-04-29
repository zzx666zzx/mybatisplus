package ${package.Controller};



<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>
import ${package.Service}.${table.serviceName};
import ${package.Service}.entity.${entity}QueryDTO;
import ${package.Service}.entity.${entity}SaveDTO;
import ${package.Service}.entity.${entity}UpdateDTO;
import ${package.Service}.entity.${entity}VO;
import cn.winner.iwin.web.core.bean.ResponseModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import cn.winner.iwin.core.base.Pagination;
import cn.winner.iwin.core.constant.SymbolConstants;
import cn.winner.iwin.core.exception.ExceptionBuilder;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

import static cn.winner.iwin.core.constant.CommonErrorConstants.ERR_PARAMETER;

/**
 * <p>
 * ${table.comment} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {

    @Autowired
    private ${table.serviceName} ${table.serviceName?substring(1)?uncap_first};

   /**
     * 获取${table.comment}
     * @param id    ${table.comment} ID
     * @return  ${table.comment} 对象
     */
    @RequestMapping(value = "/get",method = RequestMethod.GET)
    public ResponseModel<${entity}VO> get(Long id){
        return success(${table.serviceName?substring(1)?uncap_first}.get(id));
    }

    /**
     * 保存${table.comment}
     * @param bean ${table.comment}对象
     * @return 唯一键
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResponseModel<Long> save(@Valid ${entity}SaveDTO bean){
        return success(${table.serviceName?substring(1)?uncap_first}.save(bean));
    }

    /**
     * 保存${table.comment}
     * @param bean 需要更新的${table.comment}对象
     * @return 唯一键
     */
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public ResponseModel<Long> edit(@Valid ${entity}UpdateDTO bean){
        return success(${table.serviceName?substring(1)?uncap_first}.edit(bean));
    }


    /**
     * 删除${table.comment}，支持批量，以","分隔
     * @param ids id 集合
     * @return 返回是否删除成功
     */
    @RequestMapping(value = "/remove",method = RequestMethod.POST)
    public ResponseModel<Boolean> remove(@RequestParam String ids){
        return success(${table.serviceName?substring(1)?uncap_first}.remove(getIds(ids)));
    }

    /**
     * 分页查询${table.comment} 数据
     * @param bean 查询对象
     * @return 返回分页结果
     */
    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public ResponseModel<Pagination<${entity}VO>> page(@Valid ${entity}QueryDTO bean){
        return success(${table.serviceName?substring(1)?uncap_first}.query(bean));
    }
<#else>
public class ${table.controllerName} {

</#if>
}
</#if>
