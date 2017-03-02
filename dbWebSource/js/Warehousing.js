var bs              = zsi.bs.ctrl
    ,svn            =  zsi.setValIfNull
    ,wrapSD         = "<div class='input-group date'>"
    ,wrapED         = "</div>"
    ,tblName        = "tblWarehousingDetail"
    ,warehousing_id = null
    ,rr_id          = null
    ,ddlRR          = null
    ,ddlProduct     = []
;


zsi.ready(function(){
   displayRecords();
   getTemplate();
});

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindow"
                        , title: "Warehousing Details" 
                        , sizeAttr: "fullWidth"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: '<div><div id="' + tblName + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}
function warehousingDetail(id,id2){
    warehousing_id =id;
    rr_id = id2;
    displayDetail(id,rr_id);
    $(".modal-title").text("Warehousing Details for » " + warehousing_id + " and R.R.#" + rr_id);
    $('#modalWindow').modal("show");
    if (modalWindow===0) {
        modalWindow=1;
        $("#modalWindow").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }  
}

function submitItems(){
    $("#frm_modalWindow").jsonSubmit({
         procedure  : "warehousing_detail_upd"
        ,optionalItems: ["warehousing_id","product_id","unit_of_measure_id","warehouse_id","rack_id"]
       // ,notInclude: "#product_id2"
        ,onComplete : function (data) {
            $("#" + tblName).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayDetail(warehousing_id);
        }
    });
}

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "warehousing_upd"
        ,optionalItems: ["status_id"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
});

function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "warehousing_sel"
	    ,width          : 915
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"warehousing_id",type:"hidden",value: svn (d,"warehousing_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
                 }	 
                ,{text  : "W.H. No."        , name  : "warehousing_id"      , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "R.R. No."        , name  : "receiving_item_id"   , type  : "select"      , width : 100       , style : "text-align:left;"}
        		,{text  : "Status"          , name  : "status_id"           , type  : "select"      , width : 100       , style : "text-align:left;"}
        		,{ text:"Detail"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='warehousingDetail(" + svn(d,"warehousing_id",0) +", " + svn(d,"receiving_item_id",0) +");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
        		/*,{ text:"Print"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='warehousingDetail(" + svn(d,"warehousing_id",0) +", " + svn(d,"receiving_item_id",0) +");'  ><span class='glyphicon glyphicon-print' style='font-size:12pt;' ></span> </a>" : ""); }}
                */
	    ]
	    ,onComplete:function(){
	          //$("select[name='receiving_item_id']").dataBind("receiving_receipt");
	          
	          $("select[name='receiving_item_id']").dataBind({
                    url: execURL + "rr_sel_option"
                    , isUniqueOptions: true
                    , text : "receiving_item_id"
                    , value: "receiving_item_id"
                    , onComplete: function(data){
                       $("select[name='receiving_item_id']").setUniqueOptions();
                       ddlRR = data;
                    }
                });
                
	          $("select[name='status_id']").dataBind("status_warehousing_filter");
	    }
    });    
}

function displayDetail(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblName).dataBind({
         url   : execURL + "warehousing_detail_sel @warehousing_id=" + id 
        ,width          : 1315
	    ,height         : 200
	    ,blankRowsLimit :5
        ,isPaging       : false
        ,dataRows       :[
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
                                return  bs({name:"warehousing_detail_id",type:"hidden",value:svn (d,"warehousing_detail_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"warehousing_id",type:"hidden",value:id})
                                    //  + bs({name:"product_id",type:"hidden",value:svn (d,"product_id")})
                                      ;
                            }            
    		 }	 
    		,{ text:"Product*"       , width:425     , style:"text-align:left;"      ,type:"select"    ,name:"product_id" }	 
    		,{ text:"Unit*"          , width:100     , style:"text-align:left;"      ,type:"select"    ,name:"unit_of_measure_id" }	 
    		,{ text:"Unit Cost*"     , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"unit_price"    , class:"money"}
    		,{ text:"Quantity*"      , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"quantity"      , class:"money"}	 
    		,{ text:"Warehouse*"     , width:150     , style:"text-align:left;"      ,type:"select"    ,name:"warehouse_id" }	 
    		,{ text:"Rack"          , width:150     , style:"text-align:left;"      ,type:"select"    ,name:"rack_id" }	 
    		,{ text:"Tag No."       , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"tag_no"}
			,{ text:"Expiration Date"                                                                                        , width : 140       , style : "text-align:left;"
    		    , onRender      : function(d){
    		            return wrapSD + bs({name:"expiration_date",value: svn(d,"expiration_date").toDateFormat() ,style: "width:100%;"}) + wrapED;
    		    }
    		}
 	    ]
       ,onComplete : function(){
            zsi.initDatePicker();
            setToNullIfChecked(id);
            $("#cbFilter2").setCheckEvent("#" + tblName + " input[name='cb']");
            
            if (rr_id !== 0) {
                $("select[name='product_id']").dataBind({
                    url: execURL + "warehousing_detail_product_sel @receiving_item_id = " + rr_id
                    , isUniqueOptions: true
                    , text : "product_name"
                    , value:"product_id"
                    , onComplete: function(data){
                       $("select[name='product_id']").setUniqueOptions();
                       ddlProduct = data;
                    }
                });
                $("select[name='product_id']").change(function(){
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
            
            $("select[name='unit_of_measure_id']").dataBind("unit_of_measure");
            $("select[name='warehouse_id']").dataBind("warehouse");
            $("select[name='rack_id']").dataBind("warehouse_rack");
        }
    });    
}

function setToNullIfChecked(id){
    $("#" + tblName + " input[name='cb']").change(function(){
            var td  = this.parentNode;
            var warehousing_id = $(td).find("#warehousing_id");
            if(this.checked) 
                warehousing_id.val(id);
            else
                warehousing_id.val('');
    });
}
/*$("#btnDelete").click(function(){
    zsi.form.deleteData({
         code       : "sys-0002"
        ,onComplete : function(data){
                        displayRecords();
                      }
    });      
});*/                                