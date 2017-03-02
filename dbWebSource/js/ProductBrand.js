  var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "product_brand_upd"
        ,optionalItems: ["is_active"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "product_brand_sel"
	    ,width          : 448
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"product_brand_id",type:"hidden",value: svn (d,"product_brand_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
                }	 
        		,{text  : "Code"            , name  : "product_brand_code"         , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "product_brand_name"         , type  : "input"       , width : 200       , style : "text-align:left;"}
        		,{text  : "Active?"         , name  : "is_active"                  , type  : "yesno"       , width : 100       , style : "text-align:left;", defaultValue: "Y"}
	    ]
    });    
}
$("#btnDelete").click(function(){
    zsi.form.deleteData({
         code       : "sys-0008"
        ,onComplete : function(data){
                        displayRecords();
                      }
    });      
});         