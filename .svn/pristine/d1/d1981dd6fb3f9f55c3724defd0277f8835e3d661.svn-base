package ${package.Service}.entity;
<#list table.importPackages as pkg>
    <#if !(pkg?starts_with("com.baomidou.mybatisplus"))>
import ${pkg};
import javax.validation.constraints.NotNull;
    </#if>
</#list>
/**
 * <p>
    * ${table.comment} 保存对象
    * </p>
 *
 * @author ${author}
 * @since ${date}
 */
public class ${entity}UpdateDTO implements Serializable {
    private static final long serialVersionUID = 1L;
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.propertyName != 'gmtCreate' && field.propertyName != 'gmtModified'>
        <#if field.keyFlag>
            <#assign keyPropertyName="${field.propertyName}"/>
        </#if>

        <#if field.comment!?length gt 0>
    /**
     * ${field.comment}
     */
        </#if>
    <#if field.keyFlag>
    @NotNull(message = "缺少唯一键")
    </#if>
    private ${field.propertyType} ${field.propertyName};
    </#if>
</#list>
<#------------  END 字段循环遍历  ---------->


<#list table.fields as field>
    <#if field.propertyType == "boolean">
        <#assign getprefix="is"/>
    <#else>
        <#assign getprefix="get"/>
    </#if>
    <#if field.propertyName != 'gmtCreate' && field.propertyName != 'gmtModified'>

    public ${field.propertyType} ${getprefix}${field.capitalName}() {
        return ${field.propertyName};
    }

    public void set${field.capitalName}(${field.propertyType} ${field.propertyName}) {
        this.${field.propertyName} = ${field.propertyName};
    }
    </#if>
</#list>

    @Override
    public String toString() {
        return "${entity}UpdateDTO{" +
<#list table.fields as field>
    <#if  field.propertyName != 'gmtCreate' && field.propertyName != 'gmtModified'>
        <#if field_index==1>
            "${field.propertyName}=" + ${field.propertyName} +
        <#else>
            ", ${field.propertyName}=" + ${field.propertyName} +
        </#if>
    </#if>
</#list>
        "}";
    }
}