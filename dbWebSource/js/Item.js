var bs = zsi.bs.ctrl;
var svn =  zsi.setValIfNull;
zsi.ready(function(){
   displayRecords();
});
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "item_upd"
        ,optionalItems: ["category_id","is_active"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "item_sel"
	    ,width          : 1100
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , type  : "hidden"      , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"item_id",type:"hidden",value: svn (d,"item_id")})
                                                    +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
            }	 
        		,{text  : "Category"        , name  : "category_id"          , type  : "select"      , width : 300       , style : "text-align:left;"}
        		,{text  : "Code"            , name  : "item_code"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Name"            , name  : "item_name"            , type  : "input"       , width : 300       , style : "text-align:left;"}
        		,{text  : "UoM"             , name  : "unit_of_measure_id"   , type  : "select"      , width : 150       , style : "text-align:left;"}
        		,{text  : "Upload Image"    , name  : "image_url"            , type  : "input"       , width : 100       , style : "text-align:left;"}
        		,{text  : "Active?"         , name  : "is_active"            , type  : "yesno"       , width : 100       , style : "text-align:left;", defaultValue: "Y"}
        
	    ]
	    ,onComplete:function(){
	          $("select[name='category_id']").dataBind("category_item");
	          $("select[name='unit_of_measure_id']").dataBind("unit_of_measure");
	    }
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