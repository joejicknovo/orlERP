  var bs              = zsi.bs.ctrl
    ,svn            =  zsi.setValIfNull
    ,wrapSD         = "<div class='input-group date'>"
    ,wrapED         = "</div>"
    ,tblName        = "tblWarehousingDirect"
    ,warehousing_detail_id = null
    ,ddlRR          = null
    ,ddlProduct     = []
    ,g_is_update = false
    ,g_data
;

if (!String.prototype.trim) {
  String.prototype.trim = function () {
    return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
  };
}
    
zsi.ready(function(){
   displayRecords(null);
   getTemplate();
   
   // Main page Project select option.
   $("select[name='warehousing_return_id']").dataBind("warehousing_return_filter");
   $("select[name='warehousing_return_id']").change(function() {
       if ($(this).val() !== '') {
        displayRecords($(this).val());
       }
   });
});

var  contextModalTemplate = {
    id: "modalTemplate"
    , title: ""
    , sizeAttr: "modal-lg"
    , footer: '<div class="pull-left">'
            + '<button type="button" onclick="save(this);" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk">'
            + '</span>&nbsp;Save</button>'
            + '<button type="button" onclick="clearItems(this);" class="btn btn-primary"><span class="glyphicon glyphicon-refresh">'
            + '</span>&nbsp;Clear</button>'
            + '<span id="process-message" class="message">&nbsp;</span>'
    , body: '<div id="tblModalTemplate" class="zGrid header"></div><br/><div><h4>Details</h4></div><div id="tblModalDetailsTemplate" class="zGrid detail"></div>'
};

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt", function(d) {
        var template = Handlebars.compile(d);
        $("body").append(template(contextModalTemplate));
    });    
}

function initDatePicker(){
    $('#modalTemplate input[id*=date]').datepicker();
}

function initSelectHeaderOptions(callbackFunc) {
    $("#modalTemplate select[name='delivery_id']").dataBind({
        url: base_url  + "selectoption/code/delivery_project_filter"
        , onComplete : function(){
            $("#modalTemplate select[name='return_by']").dataBind({
                url: base_url + "selectoption/code/employee"
                , onComplete : function(){
                    if(callbackFunc) callbackFunc();
                }
            });
        }
    });
}

function displayRecords(warehousing_return_id){   
    $("#grid").dataBind({
	    url            : execURL + "warehousing_return_sel @warehousing_return_id=" + warehousing_return_id
	    ,width          : 1235
	    ,height         : $(document).height() - 250
        ,blankRowsLimit : 0
        ,isPaging       : true
        ,dataRows       : [
            {text  : "Product Code"             , name  : "product_code"               , type  : "input"       , width : 100       , style : "text-align:left;"
    		    ,onRender : function(d){ 
    		        return "<a href='javascript:showModalUpdate("
    		        + JSON.stringify(d) + ",\""
    		        + svn(d,"warehousing_detail_id") + "\",\"" 
    		        + svn(d,"product_code")  + "\");'>" 
    		        + svn(d,"product_code") + " </a>";
    		    }
    		}
            ,{ text:"Product Name"           , width:300     , style:"text-align:left;"      ,type:"label"   ,name:"product_name" 
                ,onRender : function(d){ return svn(d, "product_name");}
            }
    		,{ text:"Unit"              , width:100     , style:"text-align:left;"      ,type:"label"   ,name:"unit_of_measure_code" 
    		    ,onRender : function(d){ return svn(d, "unit_of_measure_code");}
    		}	 
    		,{ text:"Unit Cost"         , width:100     , style:"text-align:right;"     ,type:"label"   ,name:"unit_price"      , class:"money"
    		    ,onRender : function(d){ return svn(d, "unit_price");}
    		}
    		,{ text:"Quantity"          , width:100     , style:"text-align:right;"     ,type:"label"   ,name:"quantity"        , class:"money"
    		    ,onRender : function(d){ return svn(d, "quantity");}
    		}	 
    		,{ text:"Warehouse"         , width:150     , style:"text-align:left;"      ,type:"label"   ,name:"warehouse_name" 
    		    ,onRender : function(d){ return svn(d, "warehouse_name");}
    		}	 
    		,{ text:"Rack"              , width:150     , style:"text-align:left;"      ,type:"label"   ,name:"warehouse_rack_name" 
    		    ,onRender : function(d){ return svn(d, "warehouse_rack_name");}
    		}	 
    		,{ text:"Tag No."           , width:100     , style:"text-align:right;"     ,type:"label"   ,name:"tag_no"
    		    ,onRender : function(d){ return svn(d, "tag_no");}
    		}
			,{ text:"Expiration Date"   , width:110     , style:"text-align:left;"      ,type:"label"   ,name:"expiration_date"
    		    , onRender : function(d){ return svn(d, "expiration_date").toDateFormat();}
    		}
        ]
        , onComplete: function(data) {
            g_data = data.rows;
        }
    });    
}

$("#btnNew").click(function(){
    g_is_update = false;
    $("#modalTemplate .modal-title").text("Warehousing Return Project Products");
    $("#modalTemplate").modal({ show: true, keyboard: false, backdrop: 'static' });
    $("#tblModalDetailsTemplate").children().empty();
    buildHeaderForm();
    initSelectHeaderOptions();
    initDatePicker();
    
    $("#modalTemplate #delivery_id").change(function() {
        var delivery_id = $(this).val();
        if (delivery_id !== '') {
            $.get(execURL + "delivery_sel @delivery_id=" + delivery_id, function(d) {
                if (d.rows !== null && d.rows.length > 0) {
                    $("#modalTemplate #project_id").val(d.rows[0].project_id);
                    loadProjectDetails(delivery_id);
                }
            });
        }
    });
});

function loadProjectDetails(delivery_id) {
    $("#tblModalDetailsTemplate").dataBind({
        url: execURL + "warehousing_detail_return_sel"
        //,optionalItems: ["item_id", "serial_no", "unit_of_measure_id", "quantity", "remarks"]
        ,width:  $(document).width() - 208
        ,height: 235 //$(document).height() - 250
        ,blankRowsLimit: 10
        ,isPaging: false
        ,dataRows: [
            {text  : ""             , type  : "hidden"       , width : 26       , style : "text-align:left;"
    		    , onRender : function(d){ 
    		        return     bs({name:"warehousing_detail_id",type:"hidden", value: svn (d,"warehousing_detail_id")})
                        //+  bs({name:"warehousing_id",type:"hidden", value: svn (d,"warehousing_id")});
                        +  bs({name:"warehousing_id",type:"hidden", value: "0"});
    		    }
    		}
            ,{text  : "Product"             , name  : "product_id"               , type  : "select"      , width : 210       , style : "text-align:left;"}
            ,{text  : "Unit"                , name  : "unit_of_measure_id"       , type  : "select"      , width : 125       , style : "text-align:left;"}
            ,{text  : "Unit Cost"           , name  : "unit_price"               , type  : "input"       , width : 80       , style : "text-align:left;"}
    		,{text  : "Quantity"            , name  : "quantity"                 , type  : "input"       , width : 80       , style : "text-align:left;"}
    		,{text  : "Warehouse"           , name  : "warehouse_id"             , type  : "select"      , width : 200       , style : "text-align:left;"}
    		,{text  : "Rack"                , name  : "rack_id"                  , type  : "select"      , width : 130       , style : "text-align:left;"}
    		,{text  : "Tag No."             , name  : "tag_no"                   , type  : "input"       , width : 100       , style : "text-align:left;"}
    		,{text  : "Expiration Date"     , width : 110       , style : "text-align:left;"
    		    , onRender: function(d) {
    		        return  bs({name:"expiration_date",type:"input", value: svn (d,"expiration_date")})
    		              + bs({name:"warehousing_return_id",type:"hidden", value: svn (d,"warehousing_return_id")});
    		    }
    		}
        ]
        ,onComplete: function(){
            $("#tblModalDetailsTemplate select[name='unit_of_measure_id']").dataBind("unit_of_measure");
            $("#tblModalDetailsTemplate select[name='warehouse_id']").dataBind("warehouse");
            $("#tblModalDetailsTemplate select[name='rack_id']").dataBind("warehouse_rack");
            $('#tblModalDetailsTemplate input[id*=date]').datepicker();
            
            $("#tblModalDetailsTemplate select[name='product_id']").dataBind({
                url: execURL + "delivery_detail_return_sel_option @delivery_id = " + delivery_id
                , isUniqueOptions: true
                , text : "product"
                , value: "product_id"
                , onComplete: function(data){
                   $("#tblModalDetailsTemplate select[name='product_id']").setUniqueOptions();
                   ddlProduct = data;
                }
            });
            $("#tblModalDetailsTemplate select[name='product_id']").change(function(){
                var _obj  = this;
                var _result =  Enumerable.From(ddlProduct).Where(function (i) {  return  i.product_id == _obj.value }).ToArray();
                
                if( _result.length  > 0) {
                    var _i = _result[0];
                    var _$zRow =  $(this).closest(".zRow");
                    _$zRow.find("#unit_of_measure_id").val(_i.unit_of_measure_id);
                    _$zRow.find("#unit_price").val(_i.unit_price);
                    _$zRow.find("#quantity").val(_i.quantity);
                }
            });
        }  
    });
}

function buildHeaderForm() {
    var $table = $("#tblModalTemplate");
    $table.html('');
    var html = '<div class="form-horizontal" style="padding:5px">' +
        //'<input type="hidden" name="warehousing_detail_id" id="warehousing_detail_id" class="form-control input-sm" >' +
        '<input type="hidden" name="warehousing_return_id" id="warehousing_return_id" class="form-control input-sm">' +
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Project</label>' +
            '<div class=" col-xs-4">' +
                '<input type="hidden" name="project_id" id="project_id" class="form-control input-sm" >' +
                '<select type="text" name="delivery_id" id="delivery_id" class="form-control input-sm"></select>' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Return Date</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="return_date" id="return_date" class="form-control input-sm" >' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Return By</label>' +
            '<div class=" col-xs-3">' +
                '<select type="text" name="return_by" id="return_by" class="form-control input-sm"></select>' +
            '</div>' +
        '</div>' +
        
        '<br />' +
        
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Notes</label>' +
            '<div class=" col-xs-7">' +
                '<input type="text" name="notes" id="notes" class="form-control input-sm" >' +
            '</div>' ;
        '</div>' +
        
    '</div>';
    
    $table.append(html);
    initDatePicker();
}

function showModalUpdate(data, warehousing_detail_id, product_code) {
    g_is_update = true;
    $("#modalTemplate .modal-title").text("Update for " + product_code);
    $("#modalTemplate").modal({ show: true, keyboard: false, backdrop: 'static' });
    $("#tblModalDetailsTemplate").children().empty();
    buildHeaderForm();

    $("#modalTemplate #delivery_id").dataBind({
        url: base_url  + "selectoption/code/delivery_project_filter"
        , onComplete : function(){
            $("#modalTemplate #return_by").dataBind({
                url: base_url + "selectoption/code/employee"
                , onComplete : function(){
                    $.get(execURL + "warehousing_return_sel_by_warehousing_detail_id @warehousing_detail_id=" + warehousing_detail_id, function(d) {
                        if (d.rows !== null) {
                            $("#modalTemplate #delivery_id").val(d.rows[0].delivery_id);
                            $("#modalTemplate #return_date").val(d.rows[0].return_date);
                            $("#modalTemplate #return_by").val(d.rows[0].return_by);
                            $("#modalTemplate #notes").val(d.rows[0].notes);
                        }
                        
                        buildDetailsUpdate(warehousing_detail_id);
                        initDatePicker();
                        setDetailsUpdateData(data);
                    });
                }
            });
        }
    });
}

function loadSelectOptionsDetailsUpdate(callback) {
    $("#tblModalDetailsTemplate #product_id").dataBind({
        url: base_url  + "selectoption/code/product"
        , onComplete : function(){
            $("#tblModalDetailsTemplate #unit_of_measure_id").dataBind({
                url: base_url + "selectoption/code/unit_of_measure"
                , onComplete : function(){
                    $("#tblModalDetailsTemplate #warehouse_id").dataBind({
                        url: base_url + "selectoption/code/warehouse"
                        , onComplete : function(){
                            $("#tblModalDetailsTemplate #rack_id").dataBind({
                                url: base_url + "selectoption/code/warehouse_rack"
                                , onComplete : function(){
                                    if(callback) callback();
                                }
                            });
                        }
                    });
                }
            });
        }
    });
}

function setDetailsUpdateData(data) {
    //console.log(data);
    loadSelectOptionsDetailsUpdate(function() {
        $("#tblModalTemplate #project_id").val(data.project_id);
        $("#tblModalDetailsTemplate #warehousing_id").val(data.warehousing_id);
        $("#tblModalDetailsTemplate #product_code").val(data.product_code);
        $("#tblModalDetailsTemplate #product_id").val(data.product_id);
        $("#tblModalDetailsTemplate #unit_of_measure_id").val(data.unit_of_measure_id);
        $("#tblModalDetailsTemplate #unit_price").val(data.unit_price);
        $("#tblModalDetailsTemplate #quantity").val(data.quantity);
        $("#tblModalDetailsTemplate #warehouse_id").val(data.warehouse_id);
        $("#tblModalDetailsTemplate #rack_id").val(data.rack_id);
        $("#tblModalDetailsTemplate #tag_no").val(data.tag_no);
        $("#tblModalDetailsTemplate #expiration_date").val(data.expiration_date);
        $("#tblModalDetailsTemplate #warehousing_return_id").val(data.warehousing_return_id);
    });
}

function buildDetailsUpdate(warehousing_detail_id) {
    $("#tblModalDetailsTemplate").children().empty();
    var html = '<div class="form-horizontal" style="padding:5px">' +
        '<input type="hidden" name="warehousing_detail_id" id="warehousing_detail_id" class="form-control input-sm" value="' + warehousing_detail_id + '">' +
        '<input type="hidden" name="warehousing_id" id="warehousing_id" class="form-control input-sm" value="' + warehousing_detail_id + '">' +
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Product</label>' +
            '<div class=" col-xs-8">' +
                '<select type="text" name="product_id" id="product_id" class="form-control input-sm"></select>' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Unit</label>' +
            '<div class=" col-xs-2">' +
                '<select type="text" name="unit_of_measure_id" id="unit_of_measure_id" class="form-control input-sm"></select>' +
            '</div>' +
        '</div>' +
        
        '<br />' +
        
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Unit Cost</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="unit_price" id="unit_price" class="form-control input-sm" >' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Quantity</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="quantity" id="quantity" class="form-control input-sm" >' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Warehouse</label>' +
            '<div class=" col-xs-2">' +
                '<select type="text" name="warehouse_id" id="warehouse_id" class="form-control input-sm"></select>' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Rack</label>' +
            '<div class=" col-xs-2">' +
                '<select type="text" name="rack_id" id="rack_id" class="form-control input-sm"></select>' +
            '</div>' +
        '</div>' +
        
        '<br />' +
        
        '<div class="form-group  ">' +
            
            
            '<label class=" col-xs-1 control-label">Tag No.</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="tag_no" id="tag_no" class="form-control input-sm" >' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Expiration Date</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="expiration_date" id="expiration_date" class="form-control input-sm" >' +
                '<input type="hidden" name="warehousing_return_id" id="warehousing_return_id" class="form-control input-sm" >' +
            '</div>' +
        '</div>' +
        
    '</div>';
    
    $("#tblModalDetailsTemplate").append(html);
}

function save(obj){
    var delivery_id = $('#modalTemplate #delivery_id').val();
    var return_date = $("#modalTemplate #return_date").val();
    var return_by = $("#modalTemplate #return_by").val();
    if (delivery_id.trim() === '' || return_date.trim() === '' || return_by.trim() === '') {
        alert('Invalid entries found.');
        return;
    }
    
    var result = confirm("All entries correct. Continue?");
    if (result) {
        $('.btn-primary').prop('disabled', true);
        showProcessMessage("Saving data. Please wait...");
        $("#tblModalTemplate").jsonSubmit({
            procedure: "warehousing_return_header_upd"
            , onComplete: function(data) {
                if (data.isSuccess === true) { 
                    if (g_is_update === true) {
                        saveDetails(null);
                    } else {
                        $("#tblModalDetailsTemplate input[name='warehousing_return_id']").val(data.returnValue);
                        //Saving of details.
                        saveDetails(data.returnValue);
                    }
                } else {
                    $('.btn-primary').prop('disabled', false);
                    showProcessMessage("");
                    console.log(data.errMsg);
                    alert("An error occurred while saving the data. Please try again.");
                }
            }
        });
    }
}

function saveDetails(warehousing_return_id) {
    $("#tblModalDetailsTemplate").jsonSubmit({
        procedure: "warehousing_return_upd"
        , optionalItems: ["warehousing_id", "warehousing_return_id"]
        , onComplete: function (data) {
            if (data.isSuccess === true) { 
                showProcessMessage("");
                if (g_is_update === true) {
                    g_is_update = false;
                    alert('Warehousing (return) updated successfully.');    
                } else {
                    clearEntries();
                    alert('New Warehousing (return) saved successfully.');        
                }
                $('.btn-primary').prop('disabled', false);
                displayRecords($(".main-select-project").val());
            } else {
                $('.btn-primary').prop('disabled', false);
                showProcessMessage("");
                console.log(data.errMsg);
                alert("An error occurred while saving the data. Please try again.");
            }
        }
    });
}

function updateDetails() {
    $("#tblModalDetailsTemplate").jsonSubmit({
        procedure: "warehousing_return_upd"
        , optionalItems: ["warehousing_id", "warehousing_return_id"]
        , onComplete: function (data) {
            if (data.isSuccess === true) { 
                showProcessMessage("");
                if (g_is_update === true) {
                    alert('Warehousing (return) updated successfully.');    
                } else {
                    clearEntries();
                    alert('New Warehousing (return) saved successfully.');        
                }
                $('.btn-primary').prop('disabled', false);
                displayRecords($(".main-select-project").val());
            } else {
                showProcessMessage("");
                console.log(data.errMsg);
                alert("An error occurred while saving the data. Please try again.");
            }
        }
    });
}

function clearEntries() {
    $('#modalTemplate input[type=text]').val('');
    $('#modalTemplate select').val('');
}   

// Shows a confirmation message before clearing the input items.
function clearItems(obj) {
    var result = confirm("This will clear your entries. Continue?");
    if (result) {
        clearEntries();
    }
} 

function showProcessMessage(msg) {
    $("#modalTemplate #process-message").html(msg);
}
    