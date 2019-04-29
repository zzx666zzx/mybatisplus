<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

<#if enableCache>
    <!-- 开启二级缓存 -->
    <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

</#if>
<#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
<#list table.fields as field>
<#if field.keyFlag><#--生成主键排在第一位-->
        <id column="${field.name}" property="${field.propertyName}" />
</#if>
</#list>
<#list table.commonFields as field><#--生成公共字段 -->
    <result column="${field.name}" property="${field.propertyName}" />
</#list>
<#list table.fields as field>
<#if !field.keyFlag><#--生成普通字段 -->
        <result column="${field.name}" property="${field.propertyName}" />
</#if>
</#list>
    </resultMap>

</#if>
<#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
<#list table.commonFields as field>
        ${field.name},
</#list>
        ${table.fieldNames}
    </sql>


    <sql id="Base_Where">
        <where>
            <trim  suffixOverrides="and | or">
            <#list table.fields as field>
                <#if !field.keyFlag && field.name != 'gmt_modified' && field.name != 'gmt_create'><#--生成普通字段 -->
                 <if test="bean.${field.propertyName} != null ">
                     ${field.name} = ${r'#{bean.'}${field.propertyName}${r'}'} and
                 </if>
                </#if>
            </#list>
            </trim>
        </where>
    </sql>

   <insert id="insert" useGeneratedKeys="true"  keyProperty="id" parameterType="${package.Entity}.${entity}">
       insert into ${table.name}
       <trim prefix="(" suffix=")" suffixOverrides=",">
           <#list table.fields as field>
               <#if !field.keyFlag && field.name != 'gmt_modified'><#--生成普通字段 -->
                 <if test="${field.propertyName} != null ">${field.name}, </if>
               </#if>
           </#list>
       </trim>
       values
       <trim prefix="(" suffix=")" suffixOverrides="," prefixOverrides=",">
            <#list table.fields as field>
                <#if !field.keyFlag && field.name != 'gmt_modified'><#--生成普通字段 -->
                <if test="${field.propertyName} != null ">${r'#{'}${field.propertyName}${r'}'}, </if>
                </#if>
            </#list>
       </trim>
   </insert>

    <delete id="delete" parameterType="long">
        delete from ${table.name} where  id = ${r'#{id}'}
    </delete>
    <delete id="remove" parameterType="long">
        delete from ${table.name} where  id in
        <foreach collection="ids" item="id" open="(" separator="," close=")">
            ${r'#{id}'}
        </foreach>
    </delete>

   <update id="update" parameterType="${package.Entity}.${entity}">
       update ${table.name}
       <set>
           <#list table.fields as field>
               <#if !field.keyFlag && field.name != 'gmt_create'><#--生成普通字段 -->
                    <if test="bean.${field.propertyName} != null ">${field.name} = ${r'#{bean.'}${field.propertyName}${r'}'}, </if>
                </#if>
            </#list>
       </set>
       where id = ${r'#{bean.id}'}
   </update>

    <select id="get" parameterType="long" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from ${table.name}
        where id = ${r'#{id}'}
    </select>

    <select id="query" parameterType="${package.Entity}.${entity}" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from ${table.name}
        <include refid="Base_Where"/>
    </select>
</#if>
</mapper>
