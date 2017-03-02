  var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;


zsi.ready(function(){
  
   /* $(".zPanel").css({
            height:$(window).height()-179
        });*/
     
    displayRecords();
  
});


 function displayRecords(){   
      var cb = bs({name:"cbFilter1",type:"checkbox"});
     $("#grid").dataBind({
	     url            : execURL + "supply_monitoring_sel"
	    ,width          : 845
	    ,height         : 506
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
       // ,isPaging : false
        ,dataRows : [
    	         { text:"Code"                    , width:100       , style:"text-align:left;"          ,name:"product_code"}
    	        ,{ text:"Product"                 , width:400       , style:"text-align:left;"          ,name:"product"}
            	,{ text:"Unit"                    , width:100       , style:"text-align:center;"        ,name:"unit_of_measure_code"    ,class:"text-center"}
            	,{ text:"Lates Price"             , width:100       , style:"text-align:center;"        ,name:"latest_price"            ,class:"text-center"}
            	,{ text:"Available Stocks"        , width:120       , style:"text-align:center;"        ,name:"remaining_quantity"      ,class:"text-center"}
	    ]
    });    
}

             