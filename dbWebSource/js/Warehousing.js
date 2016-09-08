  var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
var store_id = null;

zsi.ready(function(){
  var $store =  $("select[name='receiving_item_id']")
         $store.dataBind("receiving_item");
         $store.change(function(){
        store_id = this.value;
    });
       
    
   /* $(".zPanel").css({
            height:$(window).height()-179
        });*/
     
   
  
});

function displayStores(id){
     
}


$("#btnGo").click(function(){
  displayStores();
   displayRecords();
});

$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
              procedure  : "warehousing_upd"
               ,optionalItems : ["item_id","unit_of_measure_id","warehouse_id","rack_id","status_id"]
             ,onComplete : function (data) {
                  $("#grid").clearGrid();
                  if(data.isSuccess===true) zsi.form.showAlert("alert");
                  displayRecords();
             }
        });    
});



 function displayRecords(){   
      var cb = bs({name:"cbFilter1",type:"checkbox"});
     $("#grid").dataBind({
	     url            : procURL + "warehousing_sel" // @receiving_item_id=" + receiving_item_id
	    ,width          : 1200
	    ,height         : 506
	    ,selectorType   : "checkbox"
        ,blankRowsLimit:5
       // ,isPaging : false
        ,dataRows : [
        		 {text  : cb                                 , width : 25        , style : "text-align:left;"       
            		    , onRender      :  function(d){ 
                		              return bs({name:"warehousing_id"   ,value: svn (d,"warehousing_id")    ,type:"hidden"})
                		                 +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                    }
                }	 
            	,{ text:"Item"              , width:200        , style:"text-align:center;"        , type:"select"          ,name:"item_id"}
                ,{ text:"UoM"               , width:100        , style:"text-align:center;"        , type:"select"          ,name:"unit_of_measure_id" }
                ,{ text:"Unit Price"        , width:100        , style:"text-align:center;"        , type:"input"           ,name:"unit_price" }
                ,{ text:"Quantity"          , width:100        , style:"text-align:center;"        , type:"input"           ,name:"quantity" }
                ,{ text:"Location"          , width:200        , style:"text-align:center;"        , type:"select"          ,name:"warehouse_id" }
                ,{ text:"Rack"              , width:100        , style:"text-align:center;"        , type:"select"          ,name:"rack_id" }
                ,{ text:"Tag No."           , width:100        , style:"text-align:center;"        , type:"input"           ,name:"tag_no" }
                ,{ text:"Exp. Date"         , width:100        , style:"text-align:center;"        , type:"input"           ,name:"expiration_date" }
                ,{ text:"Status"            , width:150        , style:"text-align:center;"        , type:"select"          ,name:"status_id" }
   ]
   
        ,onComplete: function(){
         $("select[name='item_id']").dataBind("item");
         $("select[name='unit_of_measure_id']").dataBind("unit_of_measure");
         $("select[name='warehouse_id']").dataBind("warehouse");   
         $("select[name='rack_id']").dataBind("rack");   
         $("select[name='status_id']").dataBind("status");   
        }
    });    
}

                   