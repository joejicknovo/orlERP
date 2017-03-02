 var bs              = zsi.bs.ctrl
    ,svn            =  zsi.setValIfNull
    ,wrapSD         = "<div class='input-group date'>"
    ,wrapED         = "</div>"
    ,tblName        = "tblWarehousingDirect"
    ,warehousing_detail_id = null
    ,ddlRR          = null
    ,ddlProduct     = []
    ,g_is_update = false
;

zsi.ready(function(){
   displayRecords();
   getTemplate();
});

var  contextModalTemplate = {
    id: "modalTemplate"
    , title: ""
    , sizeAttr: "modal-lg"
    , footer: '<div class="pull-left">'
            + '<button type="button" onclick="SubmitItems(this);" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk">'
            + '</span>&nbsp;Submit</button>'
            + '<button type="button" onclick="ClearItems(this);" class="btn btn-primary"><span class="glyphicon glyphicon-refresh">'
            + '</span>&nbsp;Clear</button>'
            + '<span id="process-message" class="message">&nbsp;</span>'
    , body: '<div id="tblModalTemplate" class="zGrid header"></div>'
};

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt", function(d) {
        var template = Handlebars.compile(d);
        $("body").append(template(contextModalTemplate));
    });    
}

function initDatePicker(){
    $('input[id*=date]').datepicker();
}

function initSelectOptions(callbackFunc) {
    $("select[name='product_id']").dataBind({
        url: base_url + "selectoption/code/product"
        , onComplete : function(){
            $("select[name='unit_of_measure_id']").dataBind({
                url: base_url +  "selectoption/code/units"
                , onComplete : function(){
                    $("select[name='warehouse_id']").dataBind({
                        url: base_url +  "selectoption/code/warehouse"
                        , onComplete : function(){
                            $("select[name='rack_id']").dataBind({
                                url: base_url +  "selectoption/code/warehouse_rack"
                                , onComplete : function(){
                                    if(callbackFunc) callbackFunc();
                                }
                            });
                        }
                    });
                }
            });
        }
    });
}

function warehousingDirect(id,id2){
    warehousing_detail_id =id;
    displayDetail(id);
    $(".modal-title").text("Warehousing Direct for » " + warehousing_detail_id);
    $('#modalWindow').modal("show");
    if (modalWindow===0) {
        modalWindow=1;
        $("#modalWindow").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }  
}

function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "warehousing_direct_sel"
	    ,width          : 1235
	    ,height         : $(document).height() - 250
        ,blankRowsLimit : 0
        ,isPaging       : true
        ,dataRows       : [
                {text  : "Product Code"             , name  : "product_code"               , type  : "input"       , width : 100       , style : "text-align:left;"
        		    ,onRender : function(d){ 
        		        return "<a href='javascript:showModalUpdate(\""
        		        + svn(d,"warehousing_detail_id") + "\",\"" +  svn(d,"product_code")  + "\");'>" 
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
    });    
}

function setToNullIfChecked(id){
    $("#" + tblName + " input[name='cb']").change(function(){
            var td  = this.parentNode;
            var warehousing_detail_id = $(td).find("#warehousing_detail_id");
            if(this.checked) 
                warehousing_detail_id.val(id);
            else
                warehousing_detail_id.val('');
    });
}

$("#btnNew").click(function(){
    g_is_update = false;
    $("#modalTemplate .modal-title").text("Warehousing Direct Entry");
    $("#modalTemplate").modal({ show: true, keyboard: false, backdrop: 'static' });
    buildForm();
    initSelectOptions();
    initDatePicker();
});

function buildForm() {
    var $table = $("#tblModalTemplate");
    $table.html('');
    var html = '<div class="form-horizontal" style="padding:5px">' +
        '<input type="hidden" name="warehousing_detail_id" id="warehousing_detail_id" class="form-control input-sm" >' +
        '<input type="hidden" name="warehousing_id" id="warehousing_id" class="form-control input-sm" value="0">' +
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Product</label>' +
            '<div class=" col-xs-6">' +
                '<select type="text" name="product_id" id="product_id" class="form-control input-sm"></select>' +
            '</div>' +
            '<label class=" col-xs-2 control-label">Unit</label>' +
            '<div class=" col-xs-3">' +
                '<select type="text" name="unit_of_measure_id" id="unit_of_measure_id" class="form-control input-sm"></select>' +
            '</div>' +
        '</div>' +
        
        '<br />' +
        
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Unit Cost</label>' +
            '<div class=" col-xs-3">' +
                '<input type="text" name="unit_price" id="unit_price" class="form-control input-sm numeric">' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Quantity</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="quantity" id="quantity" class="form-control input-sm numeric">' +
            '</div>' +
            '<label class=" col-xs-2 control-label">Warehouse</label>' +
            '<div class=" col-xs-3">' +
                '<select type="text" name="warehouse_id" id="warehouse_id" class="form-control input-sm"></select>' +
            '</div>' +
        '</div>' +
        
        '<br />' +
        
        '<div class="form-group  ">' +
            '<label class=" col-xs-1 control-label">Rack</label>' +
            '<div class=" col-xs-3">' +
                '<select type="text" name="rack_id" id="rack_id" class="form-control input-sm"></select>' +
            '</div>' +
            '<label class=" col-xs-1 control-label">Tag No.</label>' +
            '<div class=" col-xs-2">' +
                '<input type="text" name="tag_no" id="tag_no" class="form-control input-sm">' +
            '</div>' +
            '<label class=" col-xs-2 control-label">Expiration Date</label>' +
            '<div class=" col-xs-3">' +
                '<input type="text" name="expiration_date" id="expiration_date" class="form-control input-sm" >' +
            '</div>' +
        '</div>' +
        
    '</div>';
    
    $table.append(html);
    initDatePicker();
}

function showModalUpdate(warehousing_detail_id, product_code) {
    g_is_update = true;
    $("#modalTemplate .modal-title").text("Update for " + product_code);
    $("#modalTemplate").modal({ show: true, keyboard: false, backdrop: 'static' });
    buildForm();
    
    $("#tblModalTemplate #warehousing_detail_id").val(warehousing_detail_id);
    initSelectOptions(function(){
        $.get(execURL + "warehousing_direct_sel_param @warehousing_detail_id=" + warehousing_detail_id, function(d) {
            if (d.rows !== null) {
                $("#product_id").val(d.rows[0].product_id);
                $("#unit_of_measure_id").val(d.rows[0].unit_of_measure_id);
                $("#unit_price").val(d.rows[0].unit_price);
                $("#quantity").val(d.rows[0].quantity);
                $("#warehouse_id").val(d.rows[0].warehouse_id);
                $("#rack_id").val(d.rows[0].rack_id);
                $("#tag_no").val(d.rows[0].tag_no);
                $("#expiration_date").val(d.rows[0].expiration_date.toDateFormat());
            }
        });
    });
    
    initDatePicker();
}

function SubmitItems(obj){
    if ($.isNumeric($("#unit_price").val()) === false || $.isNumeric($("#quantity").val()) === false) {
        alert('Invalid entries found.');
        return;
    }
    
    var result = confirm("All entries correct. Continue?");
    if (result) {
        $('.btn-primary').prop('disabled', true);
        showProcessMessage("Saving data. Please wait...");
        $("#tblModalTemplate").jsonSubmit({
            procedure: "warehousing_direct_upd"
            //,optionalItems: ["warehousing_detail_id"]
            , onComplete: function(data) {
                if (data.isSuccess === true) {
                    showProcessMessage("");
                    $('.btn-primary').prop('disabled', false);
                    if (g_is_update === true) {
                        alert('Warehousing (direct) updated successfully.');    
                    } else {
                        clearEntries();
                        alert('New Warehousing (direct) saved successfully.');        
                    }
                    displayRecords();
                } else {
                    alert('An error occurred while saving the data. Please try again.');
                }
            }
        });
    }
}

function clearEntries() {
    $('input[type=text]').val('');
    $('select').val('');
}   

// Shows a confirmation message before clearing the input items.
function ClearItems(obj) {
    var result = confirm("This will clear your entries. Continue?");
    if (result) {
        clearEntries();
    }
} 

function showProcessMessage(msg) {
    $("#modalTemplate #process-message").html(msg);
}
