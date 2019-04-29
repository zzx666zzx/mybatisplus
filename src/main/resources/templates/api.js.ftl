import request from '@/utils/request'

export function page(params){
    return request({
        url:"<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/page",
        method:"get",
        params:params
    })
}

export function get(params) {
    return request({
        url:"<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/get",
        method:"get",
        params:params
    })
}

export function save(params) {
    return request({
        url:"<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/save",
        method:"post",
        data:params
    })
}

export function edit(params) {
    return request({
        url:"<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/edit",
        method:"post",
        data:params
    })
}

export function remove(params) {
    return request({
        url:"<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>/remove",
        method:"post",
        data:params
    })
}