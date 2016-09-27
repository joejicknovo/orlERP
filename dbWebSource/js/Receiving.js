var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
var tblName = "tblReceivingDetail";
var receiving_item_id =null;
zsi.ready(function(){
   displayRecords();
   getTemplate();
});

function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindow"
                        , title: "Receiving Details" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblName + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}
function receivingDetail(id){
    receiving_item_id =id;
    displayDetail(id);
    $(".modal-title").text("Receiving Details for » " + name);
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
         procedure  : "receiving_item_detail_upd"
        ,onComplete : function (data) {
            $("#" + tblName).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayDetail(receiving_item_id);
        }
    });
}

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "receiving_item_upd"
        ,optionalItems: ["purchase_order_id","status_id"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});

function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "receiving_item_sel"
	    ,width          : 615
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"receiving_item_id",type:"hidden",value: svn (d,"receiving_item_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "P.O. No."        , name  : "purchase_order_id"   , type  : "select"      , width : 100       , style : "text-align:left;"}
        		,{text  : "Delivered By"    , name  : "delivered_by"        , type  : "input"       , width : 150       , style : "text-align:left;"}
        		,{text  : "remark"          , name  : "remark"              , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Status"          , name  : "status_id"           , type  : "select"      , width : 100      , style : "text-align:left;"}
        		,{ text:"Detail"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='receivingDetail(" + svn(d,"receiving_item_id") +");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
        		,{ text:"View"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='receivingDetail(" + svn(d,"receiving_item_id") +");'  ><span class='glyphicon glyphicon-list-alt' style='font-size:12pt;' ></span> </a>" : ""); }}
        		,{ text:"Print"      , width:40     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='receivingDetail(" + svn(d,"receiving_item_id") +");'  ><span class='glyphicon glyphicon-print' style='font-size:12pt;' ></span> </a>" : ""); }}
        
	    ]
	    ,onComplete:function(){
	          $("select[name='purchase_order_id']").dataBind("purchase_order");
	          $("select[name='status_id']").dataBind("status_receiving_filter");
	    }
    });    
}

function displayDetail(id){   
    var sumObject = {};
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblName).dataBind({
         url   : procURL + "receiving_item_detail_sel @receiving_item_id=" + id 
        ,width          : 600
	    ,height         : 400
	    ,blankRowsLimit : 5
        ,isPaging       : false
        ,features: [{
            ftype: 'summary'
        }]
        ,dataRows       :[
    		 { text: cb             , width:40  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
    		                    sumObject = d;
                                return  bs({name:"receiving_item_detail_id",type:"hidden",value:svn (d,"receiving_item_detail_id")})  
                                        + bs({name:"receiving_item_id",type:"hidden",value:svn (d,"receiving_item_id")});
                                        /*+ bs({name:"cb",type:"checkbox",checked :(d.receiving_item_id!==""?true:false)});*/
                            }
    		 }	 
    		,{ text:"Item"          , width:200     , style:"text-align:left;"      ,type:"select"    ,name:"item_id"           , summaryType: '' }	 
    		,{ text:"Quantity"      , width:70      , style:"text-align:right;"     ,type:"input"     ,name:"quantity"          , summaryType: 'sum' }	 
    		,{ text:"UoM"           , width:70      , style:"text-align:left;"      ,type:"select"    ,name:"unit_of_measure_id", summaryType: '' }	 	 
    		,{ text:"Unit Price"    , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"unit_price"        , summaryType: 'sum' }
    		,{ text:"Amount"        , width:100     , style:"text-align:right;"     ,type:"input"     ,name:"amount"            , summaryType: 'sum' }
 	    ]
       ,onComplete : function(){
            setToNullIfChecked(id);
            $("#cbFilter2").setCheckEvent("#" + tblName + " input[name='cb']");
            $("select[name='unit_of_measure_id']").dataBind("unit_of_measure");
            $(document).ready(function () {
                $('#table .zRow #quantity, #unit_price').on('change', function() {
                    $('#table .zRow').each(function() {
                        var qty = $(this).find('input#quantity').val();
                        var rate = $(this).find('input#unit_price').val();
                        var amt = (qty * rate);
                        $(this).find('input#amount').val(amt === 0 ? '' : amt);
                    }); //END .each
                    return false;
                }); // END click 
            });
        }
    });  
    setTimeout(function(){
       console.log(sumObject);
    },10);
}

function setToNullIfChecked(id){
    $("#" + tblName + " input[name='cb']").change(function(){
            var td  = this.parentNode;
            var receiving_item_id = $(td).find("#receiving_item_id");
            if(this.checked) 
                receiving_item_id.val(id);
            else
                receiving_item_id.val('');
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