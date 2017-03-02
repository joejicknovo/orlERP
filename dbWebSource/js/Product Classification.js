var bs = zsi.bs.ctrl
   ,svn =  zsi.setValIfNull
   ,tblCategory = "tblProductCategory"
   ,tblGroup = "tblProductGroup"
   ,tblType = "tblProductType"
   ,tblAttribute = "tblProductAttribute"
   ,classification_id = null
   ,classification_name = null
   ,category_id = null
   ,category_name = null
   ,group_id = null
   ,group_name = null
   ,type_id = null
   ,type_name = null;

zsi.ready(function(){
   displayRecords();
   getCategory();
   getGroup();
   getType();
   getAttribute();
});

//Product Category
function getCategory(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindowCategory"
                        , title: "Product Category" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitCategory();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblCategory + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}

function submitCategory(){
    $("#frm_modalWindowCategory").jsonSubmit({
         procedure  : "product_category_upd"
        ,optionalItems: ["product_classification_id","is_active"]
        ,onComplete : function (data) {
            $("#" + tblCategory).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayCategory(classification_id);
        }
    });
}

function categoryModal(id, name){
    classification_id = id;
    classification_name = name;
    displayCategory(id);
    $("#modalWindowCategoryLabel").text("Categories for » " + classification_name);
    $('#modalWindowCategory').modal("show");
    if (modalWindowCategory===0) {
        modalWindowCategory=1;
        $("#modalWindowCategory").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }    
}

//Product Group
function getGroup(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindowGroup"
                        , title: "Product Group" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitGroup();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        
                        '<div><div id="' + tblGroup + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });    
}

function submitGroup(){
    $("#frm_modalWindowGroup").jsonSubmit({
         procedure  : "product_group_upd"
        ,optionalItems: ["product_category_id","is_active"]
        ,onComplete : function (data) {
            $("#" + tblGroup).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayGroup(category_id);
        }
    });
}

function groupModal(id, name){
    category_id = id;
    category_name = name;
    displayGroup(id);
    $("#modalWindowGroupLabel").text("Groups for » " + category_name);
    $('#modalWindowGroup').modal("show");
    if (modalWindowGroup===0) {
        modalWindowGroup=2;
        $("#modalWindowGroup").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }    
}

//Product Type
function getType(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindowType"
                        , title: "Product Type" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitType();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        '<div><div id="' + tblType + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });
}

function submitType(){
    $("#frm_modalWindowType").jsonSubmit({
         procedure  : "product_type_upd"
        ,optionalItems: ["product_group_id","is_active"]
        ,onComplete : function (data) {
            $("#" + tblType).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayType(group_id);
        }
    });
}

function typeModal(id, name){
    group_id = id;
    group_name = name;
    displayType(id);
    $("#modalWindowTypeLabel").text("Types for » " + group_name);
    $('#modalWindowType').modal("show");
    if (modalWindowType===0) {
        modalWindowType=3;
        $("#modalWindowType").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }    
}

//Product Attribute
function getAttribute(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     
        
        var context = { id:"modalWindowAttribute"
                        , title: "Product Attribute" 
                        , sizeAttr: "modal-lg"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="submitAttribute();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body: 
                        '<div><div id="' + tblAttribute + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
    });
}

function submitAttribute(){
    $("#frm_modalWindowAttribute").jsonSubmit({
         procedure  : "product_attribute_upd"
        ,optionalItems: ["product_type_id","is_active"]
        ,onComplete : function (data) {
            $("#" + tblAttribute).clearGrid();
            if(data.isSuccess) zsi.form.showAlert("alert");
            displayAttribute(type_id);
        }
    });
}

function attributeModal(id, name){
    type_id = id;
    type_name = name;
    displayAttribute(id);
    $("#modalWindowAttributeLabel").text("Attributes for » " + type_name);
    $('#modalWindowAttribute').modal("show");
    if (modalWindowAttribute===0) {
        modalWindowAttribute=4;
        $("#modalWindowAttribute").on("hide.bs.modal", function () {
                if (confirm("You are about to close this window. Continue?")) return true;
                return false;
        });
    }    
}

//Product Classification
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "product_classification_upd"
        ,optionalItems: ["is_active"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            if(data.isSuccess===true) zsi.form.showAlert("alert");
            displayRecords();
        }
    });
    
});
    
function displayRecords(){   
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "product_classification_sel"
	    ,width          : 615
	    ,height         : $(document).height() - 250
	    //,selectorType   : "checkbox"
        ,blankRowsLimit:5
        ,isPaging : false
        ,dataRows : [
                 {text  : cb                                                , width : 25        , style : "text-align:left;"       
        		    , onRender      :  function(d){ 
                		                   return     bs({name:"product_classification_id", value: svn (d,"product_classification_id"), type:"hidden"})
                		                           +  (d !==null ? bs({name:"cb",type:"checkbox"}) : "" );
                            }
                }	 
        		,{text  : "Code"       , name  : "product_classification_code"       , type  : "input"   , width : 100    , style : "text-align:left;"}
        		,{text  : "Name"       , name  : "product_classification_name"       , type  : "input"   , width : 300    , style : "text-align:left;"}
        		,{text  : "Active?"    , name  : "is_active"                         , type  : "yesno"   , width : 100    , style : "text-align:left;" , defaultValue:"Y" }
        		,{text  : "Category"   , width:60     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='categoryModal(" + svn(d,"product_classification_id") +",\"" + svn(d,"product_classification_name") +"\");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
	    ]
    });    
}

function displayCategory(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblCategory).dataBind({
         url   : execURL + "product_category_sel @product_classification_id=" + id 
        ,width          : 810
	    ,height         : 200
	    ,blankRowsLimit :5
        ,isPaging       : false
        ,dataRows       :[
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
                                return  bs({name:"product_category_id",type:"hidden",value:svn (d,"product_category_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"product_classification_id",type:"hidden",value:id});
                            }            
    		 }	 
    		,{text:"Code"        , name:"product_category_code"  ,type:"input"  , width:100     , style:"text-align:left;" }	 
    		,{text:"Name"        , name:"product_category_name"  ,type:"input"  , width:500     , style:"text-align:left;" }	 
    		,{text:"Active?"     , name:"is_active"              ,type:"yesno"  , width:100     , style:"text-align:left;"   ,defaultValue:"Y" }
    		,{text:"Group"                                                      , width:60      , style:"text-align:center;" 
        		 ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='groupModal(" + svn(d,"product_category_id") +",\"" + svn(d,"product_category_name") +"\");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
 	    ]
    });    
}

function displayGroup(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblGroup).dataBind({
         url   : execURL + "product_group_sel @product_category_id=" + id 
        ,width          : 810
	    ,height         : 200
	    ,blankRowsLimit :5
        ,isPaging       : false
        ,dataRows       :[
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
                                return  bs({name:"product_group_id",type:"hidden",value:svn (d,"product_group_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"product_category_id",type:"hidden",value:id});
                            }            
    		 }	 
    		,{text:"Code"        , name:"product_group_code"  ,type:"input"  , width:100     , style:"text-align:left;" }	 
    		,{text:"Name"        , name:"product_group_name"  ,type:"input"  , width:500     , style:"text-align:left;" }	 
    		,{text:"Active?"     , name:"is_active"           ,type:"yesno"  , width:100     , style:"text-align:left;"   ,defaultValue:"Y" }
    		,{text:"Type"                                                    , width:60      , style:"text-align:center;" 
        		 ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='typeModal(" + svn(d,"product_group_id") +",\"" + svn(d,"product_group_name") +"\");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
 	    ]
    });    
}

function displayType(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblType).dataBind({
         url   : execURL + "product_type_sel @product_group_id=" + id 
        ,width          : 810
	    ,height         : 200
	    ,blankRowsLimit : 5
        ,isPaging       : false
        ,dataRows       : [
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
                                return  bs({name:"product_type_id",type:"hidden",value:svn (d,"product_type_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"product_group_id",type:"hidden",value:id});
                            }            
    		 }	 
    		,{text:"Code"        , name:"product_type_code"  ,type:"input"   , width:100     , style:"text-align:left;" }	 
    		,{text:"Name"        , name:"product_type_name"  ,type:"input"   , width:500     , style:"text-align:left;" }	 
    		,{text:"Active?"     , name:"is_active"          ,type:"yesno"   , width:100     , style:"text-align:left;"   ,defaultValue:"Y" }
    		,{text:"Attribute"                                               , width:60      , style:"text-align:center;" 
        		 ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'onclick='attributeModal(" + svn(d,"product_type_id") +",\"" + svn(d,"product_type_name") +"\");'  ><span class='glyphicon glyphicon-list' style='font-size:12pt;' ></span> </a>" : ""); }}
 	    ]
    });    
}

function displayAttribute(id){   
    var cb = bs({name:"cbFilter2",type:"checkbox",style:"margin-top: 2px;"});
    $("#" + tblAttribute).dataBind({
         url   : execURL + "product_attribute_sel @product_type_id=" + id 
        ,width          : 750
	    ,height         : 200
	    ,blankRowsLimit : 5
        ,isPaging       : false
        ,dataRows       : [
    		 { text: cb             , width:25  , style:"text-align:left;" 
    		     ,onRender : function(d){ 
                                return  bs({name:"product_attribute_id",type:"hidden",value:svn (d,"product_attribute_id")})  
                                      + (d !==null ? bs({name:"cb",type:"checkbox"}) : "" )
                                      + bs({name:"product_type_id",type:"hidden",value:id});
                            }            
    		 }	 
    		,{text:"Seq. No."     , name:"product_attribute_sequence_no"  ,type:"input"   , width:100     , style:"text-align:left;" }	 
    		,{text:"Value"        , name:"product_attribute_value"        ,type:"input"   , width:500     , style:"text-align:left;" }	 
    		,{text:"Active?"      , name:"is_active"                      ,type:"yesno"   , width:100     , style:"text-align:left;"   ,defaultValue:"Y" }
    		
 	    ]
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
    