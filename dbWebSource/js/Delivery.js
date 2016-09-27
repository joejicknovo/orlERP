var bs = zsi.bs.ctrl
    ,svn =  zsi.setValIfNull
    ,wrapSD = "<div class='input-group date'>"
    ,wrapED = "</div>";
var tblName = "tblDeliveryItemDetail";
var receiving_item_id =null;
zsi.ready(function(){
   displayRecords();
   getTemplate();
});

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindow"
                        , title: "Supplies Site Issuance Details" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblName + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}
function deliveryDetail(id){
    delivery_item_id =id;
    displayDetail(id);
    $(".modal-title").text("Supplies Site Issuance Details for » " + delivery_item_id);
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
         procedure  : "delivery_item_detail_upd"
        ,optionalItems: ["delivery_item_id","item_id","unit_of_measure_id"]
        ,onComplete : function (data) {
            $("#" + tblName).clearGrid();
            //alert(delivery_item_id);
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayDetail(delivery_item_id);
        }
    });
}

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "delivery_item_upd"
        ,optionalItems: ["company_vehicle_id","company_driver_id","outsource_shipper_id"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});

function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "delivery_item_sel"
	    ,width          : 1200
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"delivery_item_id",type:"hidden",value: svn (d,"delivery_item_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "DR No."                      , name  : "delivery_item_id"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Project"                     , name  : "project_id"                  , type  : "select"      , width : 150       , style : "text-align:left;"}
    			,{text  : "Date"                                                                                        , width : 100       , style : "text-align:left;"
        		    , onRender      : function(d){
        		            return wrapSD + bs({name:"delivery_date",value: svn(d,"delivery_date").toDateFormat()}) + wrapED;
        		    }
        		}
        		,{text  : "In-charge"                   , name  : "delivery_incharge_id"        , type  : "select"      , width : 150      , style : "text-align:left;"}
        		,{text  : "Vehicle Plate No."           , name  : "company_vehicle_id"          , type  : "select"      , width : 150      , style : "text-align:left;"}
        		,{text  : "Driver"                      , name  : "company_driver_id"           , type  : "select"      , width : 150      , style : "text-align:left;"}
        		,{text  : "Shipper"                     , name  : "outsource_shipper_id"        , type  : "select"      , width : 150      , style : "text-align:left;"}
        		,{text  : "Status"                      , name  : "status_id"                   , type  : "select"      , width : 100      , style : "text-align:left;"}
        		,{ text:"Detail"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='deliveryDetail(" + svn(d,"delivery_item_id") +");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
        		/*,{ text:"View"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='deliveryDetail(" + svn(d,"delivery_item_id") +");'  ><span class='glyphicon glyphicon-list-alt' style='font-size:12pt;' ></span> </a>" : ""); }}
        		,{ text:"Print"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='deliveryDetail(" + svn(d,"delivery_item_id") +");'  ><span class='glyphicon glyphicon-print' style='font-size:12pt;' ></span> </a>" : ""); }}
                */
	    ]
	    ,onComplete:function(){
	          zsi.initDatePicker();
	          $("select[name='project_id']").dataBind("project");
	          $("select[name='delivery_incharge_id']").dataBind("employee");
	          $("select[name='company_driver_id']").dataBind("employee");
	          $("select[name='status_id']").dataBind("status_delivery_filter");
	    }
    });    
}

function displayDetail(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    var totalAmount = 0;
    var totalQuantity = 0;
    var totalUnitPrice = 0;
    var rate = 0;
    var qty = 0;
    var amt = 0;
    $("#" + tblName).dataBind({
         url   : procURL + "delivery_item_detail_sel @delivery_item_id=" + id 
        ,width          : 1100
	    ,height         : 200
	    ,blankRowsLimit :5
        ,isPaging       : false
        ,dataRows       :[
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
    		         //console.log(svn(d,"amount",111));
    		                totalAmount += parseFloat(svn(d,"amount",0));
                            totalQuantity += parseFloat(svn(d,"quantity",0));
                            totalUnitPrice += parseFloat(svn(d,"unit_price",0));
                        
                                return  bs({name:"delivery_item_detail_id",type:"hidden",value:svn (d,"delivery_item_detail_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"delivery_item_id",type:"hidden",value:id});
                            }            
    		 }	 
    		,{ text:"Product"       , width:200     , style:"text-align:left;"      ,type:"select"    ,name:"item_id" }	 
    		,{ text:"Unit"          , width:100     , style:"text-align:left;"      ,type:"select"    ,name:"unit_of_measure_id" }	 
    		//,{ text:"Unit Cost"     , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"unit_price"    , class:"money"}
    		//,{ text:"Quantity"      , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"quantity"      , class:"money"}	 
    		//,{ text:"Amount"        , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"amount"        , class:"money"}
    		,{ text:"Unit Cost"     , width:100     , style:"text-align:right;"     ,class:"moneyGridRightAlign"     
    		    ,onRender : function(d){
    		        rate = parseFloat(svn(d,"unit_price",0));
    		        rate = Number(rate);
                    return bs({name:"unit_price", type:"input", value:rate === 0 ? '' : rate.toFixed(2)});
    		    }
    		}
    		,{ text:"Quantity"      , width:100     , style:"text-align:right;"     , class:"moneyGridRightAlign"
        		,onRender : function(d){
    		        qty = parseFloat(svn(d,"quantity",0));
    		        qty = Number(qty);
                    return bs({name:"quantity", type:"input", value:qty === 0 ? '' : qty.toFixed(2)});
    		    }
    		}
    		,{ text:"Amount"        , width:100     , style:"text-align:right;"     , class:"moneyGridRightAlign"
        		,onRender : function(d){
    		        amt = parseFloat(svn(d,"amount",0));
    		        amt = Number(amt);
                    return bs({name:"amount", type:"input", value:amt === 0 ? '' : amt.toFixed(2)});
    		    }
    		}
 	    ]
       ,onComplete : function(){
           
           var varTTL = '<div class="zRow">' +
                                        '<div class="zCell totalLabel">Total >>></div>' +
                                        '<div id="ttlUCost" class="zCell amountFormat">'+ totalUnitPrice.toFixed(2) +'</div>' +
                                        '<div id="ttlQty" class="zCell amountFormat">' + totalQuantity.toFixed(2) + '</div>' +
                                        '<div id="ttlAmt" class="zCell amountFormat">' + totalAmount.toFixed(2) + '</div>' +
                                    '</div>'; 
            $("#tblDeliveryItemDetail").find(".right #table div:first").before(varTTL);
            setToNullIfChecked(id);
            $("#cbFilter2").setCheckEvent("#" + tblName + " input[name='cb']");
            $("select[name='item_id']").dataBind("item");
            $("select[name='unit_of_measure_id']").dataBind("unit_of_measure");
            $('#amount').prop('readonly',true);
            $(document).ready(function () {
                $('#table .zRow #quantity, #unit_price').on('change', function() {
                    totalAmount = 0;
                    totalQuantity = 0;
                    totalUnitPrice = 0;
                    $('#table .zRow').each(function() {
                        qty = $(this).find('input#quantity').val();
                        rate = $(this).find('input#unit_price').val();
                        amt = (qty * rate);
                        alert(rate);
                        $(this).find('#amount').prop('readonly',true);
                        $(this).find('input#amount').val(amt === 0 ? '' : amt.toFixed(2));
                        if (amt) {
                            totalAmount += parseFloat(amt);
                            $("#ttlAmt").html(totalAmount.toFixed(2));
                        }
                        if (qty) {
                            totalQuantity += parseFloat(qty);
                            $("#ttlQty").html(totalQuantity.toFixed(2));
                        }
                        if (rate) {
                            totalUnitPrice += parseFloat(rate);
                            $("#ttlUCost").html(totalUnitPrice.toFixed(2));
                        }
                    }); //END .each
                    return false;
                }); // END click 
            });
        }
    });    
}

function setToNullIfChecked(id){
    $("#" + tblName + " input[name='cb']").change(function(){
            var td  = this.parentNode;
            var delivery_item_id = $(td).find("#delivery_item_id");
            if(this.checked) 
                delivery_item_id.val(id);
            else
                delivery_item_id.val('');
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