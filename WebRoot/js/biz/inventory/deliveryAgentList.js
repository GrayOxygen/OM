jQuery(function ($) {
    $("#submenu-menu-advert-user").addClass("active");
    $("#menu-advert").addClass("active");
    $("#menu-advert").addClass("open");

    initTable();
    $("#searchGoodsBtn").click(function () {
        searchGoods();
    });
    $("#dp_quoteStartDate").datetimepicker({
		minView: "month",
		format: 'yyyy-mm-dd',
	    language: 'zh-CN',
		weekStart: 1,
	    todayBtn:  1,
		autoclose: true,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
    
    $("#dp_quoteEndDate").datetimepicker({
		minView: "month",
		format: 'yyyy-mm-dd',
	    language: 'zh-CN',
		weekStart: 1,
	    todayBtn:  1,
		autoclose: true,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
    
});

var oTable = null;
function initTable() {
    if (oTable == null) {
        oTable = $("#out_list").dataTable({
            "bAutoWidth": false,//自动宽度
            "bLengthChange": true,//是否显示一个每页长度的选择条（需要分页器支持）
            "bProcessing": true,//以指定当正在处理数据的时候，是否显示“正在处理”这个提示信息
            "bFilter": true,//过滤功能
            "bInfo": true,//页脚信息
            //"sPaginationType": "two_button",
            "bServerSide": true,//异步请求必须设置
            "sAjaxSource": ROOT_PATH + "/view/inventory/deliveryAgent/queryDeliveryAgentPage.action",  //异步请求地址
            "aoColumns": [
                {"mDataProp": "storageDeliveryOrder.deliveryNo"},
                {"mDataProp": "goodsInfo.goodsName"},
                {"mDataProp": "agentNumber"},
                {"mDataProp": "remark"},
                {
                    "sDefaultContent": "", "mRender": function (data, type, full) {
                    var actionDiv = '';
                    actionDiv = '<div class="hidden-sm hidden-xs btn-group">' +
                        '<button onclick="queryDeliveryOrderById(\'' + full.deliveryOrderId + '\')" class="btn btn-xs btn-success"><i class="ace-icon fa fa-search-plus bigger-120"></i></button>' +
                        '<button onclick="preAddOrModifyDeliveryOrder(\'' + full.deliveryOrderId + '\')" class="btn btn-xs btn-info"><i class="ace-icon fa fa-pencil bigger-120"></i></button>' +
                        '<button onclick="deleteDeliveryOrder(\'' + full.deliveryOrderId + '\')" class="btn btn-xs btn-danger"><i class="ace-icon fa fa-trash-o bigger-120"></i></button>';
                    actionDiv += '</div>';
                    return actionDiv;
                }
                }
            ],
            "oLanguage": {
                "sProcessing": "正在加载中......",
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有数据！",
                "sEmptyTable": "表中无数据存在！",
                "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                "sInfoEmpty": "显示0到0条记录",
                "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                zeroRecords: "没有内容",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上一页",
                    "sNext": "下一页",
                    "sLast": "末页"
                }
            },
            "aoColumnDefs": [{//和aoColums类似，但他可以给指定列附近爱属性
                "bSortable": false, "aTargets": [0, 1, 2, 3, 4],//这句话意思是第1,3,6,7,8,9列（从0开始算） 不能排序
                "searchable": false,
                "orderable": false,
                "targets": 0
            }],
            "fnServerData": retrieveData,
        });


    } else {
        oTable.fnDraw(); //重新加载数据
    }

}

/**
 * sSource   查询链接
 * aoData    参数
 * fnCallback 返回数据填充方法
 */
function retrieveData(sSource, aoData, fnCallback) {
    //商品名称或编号
    var keyword = $("#keyword").val();
    var param = {"keyword": keyword};


    for (var i = 0; i < aoData.length; i++) {
        var _aoData = aoData[i];
        if (_aoData.name == "iDisplayStart") {
            /*开始页数*/
            param.iDisplayStart = _aoData.value;
        } else if (_aoData.name == "iDisplayLength") {
            /*记录条数*/
            param.iDisplayLength = _aoData.value;
        } else if (_aoData.name == "sEcho") {
            /*操作次数*/
            param.sEcho = _aoData.value;
        }
    }
    //提交访问
    $.ajax({
        type: "POST",
        url: sSource,
        dataType: "json",
        data: param, // 以json格式传递
        success: function (resp) {
            fnCallback(resp);
//            removeMask($('.goods-container'));
        }
    });
}

function dateFind(){
	if($("#dp_quoteStartDate").val() != "" && $("#dp_quoteEndDate").val() != ""){
		initTable();
	}
}