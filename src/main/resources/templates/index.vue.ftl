<template>
    <div class="app-container yy-card">
        <div class="filter-container">
            <el-input  style="width: 300px;" class="input-with-select" placeholder="搜索" v-model="listQuery.queryString">
                <el-button slot="append" icon="el-icon-search" @click="handleSearch"></el-button>
            </el-input>
            <el-button class="filter-item fr" v-waves style="margin-left: 10px;" @click="handleCreate" type="success" icon="el-icon-plus">新增</el-button>
            <el-button class="filter-item fr" type="danger" v-waves icon="el-icon-delete" @click="handleDelete">删除</el-button>
        </div>
        <el-table :key='tableKey' :data="list" v-loading="listLoading" element-loading-text="" border fit highlight-current-row
                  style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column
                    type="selection"
                    width="35" >
            </el-table-column>
            <el-table-column align="center" label="名称">
                <template slot-scope="scope">
                    <span>{{scope.row.realName}}</span>
                </template>
            </el-table-column>
            <el-table-column align="center" label="字段" >
                <template slot-scope="scope">
                    <span>{{scope.row.mobile}}</span>
                </template>
            </el-table-column>
            <el-table-column align="center" label="类型">
                <template slot-scope="scope">
                    <span>{{scope.row.email}}</span>
                </template>
            </el-table-column>
            <el-table-column align="center" label="操作" width="77" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button circle type="primary" icon="el-icon-winner-bianji" @click="handleEdit(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="pagination-container">
            <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
        </div>
        <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
            <el-form :rules="rules" ref="temp_form" :model="temp_form" label-position="right" label-width="70px" style='width: 400px; margin-left:0px;'>
                <el-form-item  label="事件名" :label-width="formLabelWidth" prop="eventName">
                    <el-input  v-model="temp_form.eventName" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item  label="事件key" :label-width="formLabelWidth" prop="eventKey">
                    <el-input  v-model="temp_form.eventKey" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="备注" :label-width="formLabelWidth">
                    <el-input type="textarea" v-model="temp_form.remark" auto-complete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button v-if="dialogStatus =='create'" type="primary" @click="doSave${entity}">确 定</el-button>
                <el-button v-else type="primary" @click="doEdit${entity}">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import {page,save,edit,remove } from '@/api<#if package.ModuleName??>/${package.ModuleName?replace(".","/")}</#if>/${table.entityPath}'
    import waves from '@/directive/waves' // 水波纹指令
    export default {
        name: "index",
        directives: {
            waves
        },
        data() {
            return {
                textMap: {
                    edit: '编辑',
                    create: '新增'
                },
                formLabelWidth: "100px",
                dialogFormVisible: false,
                dialogStatus:"create",
                tableKey: 0,
                list: null,
                total: null,
                listLoading: false,
                listQuery: {
                    page: 1,
                    pageSize: 10
                },
                temp_form: {

                },
                multipleSelection: [],
                rules: {}
            }
        },
        created(){
            this.query${entity}()
        },
        methods:{
            handleSelectionChange(val){
                this.multipleSelection = val
            },
            //改变每页数量
            handleSizeChange(val) {
                this.listQuery.pageSize = val
                this.query${entity}()
            },
            //查询指定页数
            handleCurrentChange(val){
                this.listQuery.page = val
                this.query${entity}()
            },
            //搜索
            handleSearch(){
                this.query${entity}()
            },
            handleCreate(){
                this.dialogStatus = "create"
                this.dialogFormVisible = true
                this.$nextTick(() => {
                    this.$refs['temp_form'].clearValidate()
                })
            },
            handleEdit(){
                this.dialogStatus = "edit"
                this.dialogFormVisible = true
                this.$nextTick(() => {
                    this.$refs['temp_form'].clearValidate()
                })
            },
            handleDelete(){
                let ids = new Array();
                for(var i = 0 ;i < this.multipleSelection.length;i++){
                    ids.push(this.multipleSelection[i].id);
                }
                if(ids.length == 0){
                    this.$message({
                        type: 'error',
                        message: '未选择用户!'
                    });
                    return
                }
                this.$confirm('确认删除所选用户?','提示',{
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    remove({ids:ids.join(",")}).then(() =>{
                    this.listQuery.page =1;
                    this.query${entity}()
                    this.$message({
                        type: 'success',
                        message: '删除成功!'
                    });
                })
            }).catch(() => {

                })
            },
            query${entity}(){
                this.listLoading = true
                page(this.listQuery).then(res => {
                    this.list = res.data.data
                    this.total = res.data.total
                    this.listLoading = false
                })
            },
            doSave${entity}(){
                this.$refs['temp_form'].validate((valid) => {
                    if(valid) {
                        save(this.temp_form).then(res => {
                            this.query${entity}()
                            this.dialogFormVisible = false
                            this.$message({
                                type: 'success',
                                message: '创建成功!'
                            })
                        })
                    }
                })
            },
            doEdit${entity}(){
                this.$refs['temp_form'].validate((valid) => {
                    if(valid) {
                        edit(this.temp_form).then(res => {
                            this.query${entity}()
                        this.dialogFormVisible = false
                        this.$message({
                            type: 'success',
                            message: '修改成功!'
                        })
                    })
                    }
                })
            }
        }
    }
</script>

<style scoped>

</style>