var bs = zsi.bs.ctrl
,svn =  zsi.setValIfNull
,tblName = "tblUpload"
,modalImage = "modalWindowImage"
,modalProduct = "modalWindowProduct"
,tblProductModal = "tableProductModal"
,classification_id = null
,category_id = null
,group_id = null
,type_id = null
,g_is_update = false;

// Create a product object.
var Product = {
    Name: '',
    UnitOfMeasureId: '',
    BrandId: '',
    ClassificationId: '',
    CategoryId: '',
    GroupId: '',
    TypeId: '',
    AttributeId: '',
    IsActive: ''
};

zsi.ready(function(){
   displayRecords();
   getTemplate();
});

// Initialize the product object.
function initProduct() {
    Product.Name = '';
    Product.UnitOfMeasureId = '';
    Product.BrandId = '';
    Product.ClassificationId = '';
    Product.CategoryId = '';
    Product.GroupId = '';
    Product.TypeId = '';
    Product.AttributeId = '';
    Product.IsActive = '';
}

// Trigger the saving of a product.
$("#btnSave").click(function () {
    $("#grid").jsonSubmit({
        procedure: "product_upd"
        ,optionalItems: ["product_category_id","is_active"]
        ,onComplete: function (data) {
            $("#grid").clearGrid(); 
            displayRecords();
        }
    });
});

// Get the modal templates.
function getTemplate(){
    $.get(base_url + "templates/bsDialogBox.txt",function(d){
        var template = Handlebars.compile(d);     

        var context = { id:"modalWindow"
                        , title: "Product"
                        , footer:  ' <div class="pull-left"><button type="button" onclick="SubmitItems();" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button></div>'
                        , body:'<div ><div id="' + tblName + '" class="zGrid"></div></div>'
                      };
        var html    = template(context);     
        $("body").append(html);
        
        var contextImageWindow = { 
                          id    : modalImage
                        , title : "Product Image"
                        , footer: '<div class="pull-left"><button type="button" onclick="productImageUpload();" class="btn btn-primary"><span class="glyphicon glyphicon-upload"></span> Upload</button>'
                                   + '</div>' 
                    };
        var htmlImageWindow    = template(contextImageWindow);     
        $("body").append(htmlImageWindow);
        
        var contextProductModal = { 
                          id    : "modalProduct"
                        , title : ""
                        , sizeAttr: "modal-lg"
                        , footer: '<div class="pull-left">'
                            + '<button type="button" onclick="SubmitItems(this);" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk">'
                            + '</span>&nbsp;Submit</button>'
                            + '<button type="button" onclick="ClearItems(this);" class="btn btn-primary"><span class="glyphicon glyphicon-refresh">'
                            + '</span>&nbsp;Clear</button>'
                            + '<span id="process-message" class="message">&nbsp;</span>'
                        , body: '<div id="tblProductModal" class="form-horizontal">'
                                        +'<div class="form-group  ">' 
                                            +'<input type="hidden" name="product_id" id="product_id" class="form-control input-sm" > '
                                            +'<label class=" col-xs-3 control-label">Product Name: </label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<input type="text" name="product_name" id="product_name" class="form-control input-sm ">' 
                                            +'</div>'
                                        +'</div>'
                                        
                                        +'<div class="form-group  ">'     
                                            +'<label class=" col-xs-3 control-label">Unit of Measure:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="unit_of_measure_id" id="unit_of_measure_id" class="form-control input-sm "></select>' 
                                            +'</div>' 
                                        +'</div>'
                                        
                                        +'<div class="form-group  ">'     
                                            +'<label class=" col-xs-3 control-label">Product Brand:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_brand_id" id="product_brand_id" class="form-control input-sm "></select>' 
                                            +'</div>'
                                        +'</div>'
                                        
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Product Classification:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_classification_id" id="product_classification_id" class="form-control input-sm"></select>' 
                                            +'</div>' 
                                        +'</div>' 
                                            
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Product Category:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_category_id" id="product_category_id" class="form-control input-sm "></select>' 
                                            +'</div>'
                                        +'</div>' 
                                        
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Product Group:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_group_id" id="product_group_id" class="form-control input-sm "></select>' 
                                            +'</div>' 
                                        +'</div>' 
                                        
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Product Type:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_type_id" id="product_type_id" class="form-control input-sm"></select>' 
                                            +'</div>' 
                                        +'</div>'
                                        
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Product Attribute:</label>' 
                                            +'<div class=" col-xs-7">' 
                                                +'<select type="text" name="product_attribute_id" id="product_attribute_id" class="form-control input-sm "></select>' 
                                            +'</div>' 
                                        +'</div>'
                                        
                                        +'<div class="form-group  ">' 
                                            +'<label class=" col-xs-3 control-label">Active?:</label>' 
                                            +'<div class=" col-xs-2">' 
                                                +'<select name="is_active" id="is_active" class="form-control input-sm">'
                                                        +'<option value=""> </option>'
                                                        +'<option value="Y">Yes</option>'
                                                        +'<option value="N">No</option>'
                                                +'</select>' 
                                            +'</div>' 
                                            +'<input type="hidden" name="image_url" id="image_url" class="form-control input-sm ">' 
                                        +'</div>'
                                +'</div>'
                    };
        var htmlProductModal = template(contextProductModal);     
        $("body").append(htmlProductModal);
    });    
}

//Upload image browse button
function chooseFile() {
    $("#fileInput").click();
}

//Upload image modal
function showModalUploadUserImage(productId,productCode){
    product_id = productId;
    product_code = productCode;
    var m=$('#' + modalImage);
    
    m.find(".modal-title").text("Image for » " + productCode);
    m.modal("show");
    m.find("form").attr("enctype","multipart/form-data");
    
    $.get(base_url + 'page/name/UploadProductImage'
        ,function(data){
            m.find('.modal-body').html(data);
            initChangeEvent();
        }
    ); 
}

//Upload image to folder and save filename to database.
function productImageUpload(){
    var frm = $("#frm_" + modalImage);
    var fileOrg=frm.find("#fileInput").get(0);

    if( fileOrg.files.length<1 ) { 
         alert("Please select image.");
        return;
    }
    
    var file = fileOrg.files[0].name;
    var fileExt = file.split('.').pop();
    var fileName = product_code + "." + fileExt;
    
    var formData = new FormData( frm.get(0));
    formData.append('file', fileOrg.files[0], fileName);
    //fd.append( 'file', fileOrg.files[0], fileName);
    
    $.ajax({

        url: base_url + 'file/UploadImage',
        type: 'POST',
        
        //Ajax events
        success: completeHandler = function() {
                $.get(execURL  + "product_image_upload_upd @product_id=" + product_id + ",@image_filename='" +  fileName + "'"
                ,function(data){
                    zsi.form.showAlert("alert");
                    $('#' + modalImage).modal('toggle');
                    
                    //refresh latest records:
                    displayRecords("");
                });
        },
        error: errorHandler = function() {
            console.log("error");
        },
        // Form data
        data: formData,
        //Options to tell JQuery not to process data or worry about content-type
        cache: false,
        contentType: false,
        processData: false
    }, 'json');
}

//Upload image file size
function initChangeEvent(){
    $("input[name='file_thumbnail']").change(function(){
        fileNameThumbNail= this.files[0].name;
        var fileSize1 =  this.files[0].size / 1000.00; //to kilobytes
        if(fileSize1 > 100){ 
            alert("Please make sure that file size must not exceed 100 KB.");
            this.value="";
        }
    });
    
    $("input[name='file']").change(function(){
        fileNameOrg=this.files[0].name;
        var fileSize2 =  this.files[0].size / 1000.00; //to kilobytes
        if(fileSize2 > 800){ //1mb
            alert("It is recommended that file size must not exceed 800 KB.");
            this.value="";
        }
    });
}

// Display the records in the grid.
function displayRecords(){   
    var rownum = 0;
    var cb = bs({name:"cbFilter1",type:"checkbox"});
         $("#grid").dataBind({
	     url            : execURL + "product_display_sel"
	    ,width          : 1300
	    ,height         : $(document).height() - 250
	    ,selectorType   : "checkbox"
        ,blankRowsLimit:0
        ,isPaging : false
        ,dataRows : [
                 {text  : cb        , width : 25        , style : "text-align:left;"       
        		    ,onRender      :  function(d){ 
                		return bs({name:"product_id" ,value: svn (d,"product_id") ,type:"hidden"}) +
                		       bs({name:"image_url" ,value: svn (d,"image_url") ,type:"hidden"}) +
                               (d !==null ? bs({name:"cb" ,type:"checkbox"}) : "" );
                    }
                }	 
        		,{text  : "Code"            , name  : "product_code"         , type  : "input"       , width : 100       , style : "text-align:left;"
        		    ,onRender : function(d){ 
        		        return "<a href='javascript:showModalUpdate(\""
        		        + svn(d,"product_id") + "\",\"" +  svn(d,"product_code")  + "\");'>" 
        		        + svn(d,"product_code") + " </a>";
        		    }
        		}
        		,{text  : "Name"            , width : 320       , style : "text-align:left;"
        		    ,onRender : function(d){ return  svn (d,"product_name");}
        		}
        		,{text  : "Unit"            , width : 80       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"unit_of_measure_code"); }
        		}
        		,{text  : "Classification"  , width : 150       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_classification_name");}
        		}
        		,{text  : "Category"        , width : 100       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_category_name");}
        		}
        		,{text  : "Group"           , width : 100       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_group_name"); }
        		}
        		,{text  : "Type"            , width : 100       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_type_name"); }       		}
        		,{text  : "Brand"           , width : 100       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_brand_name"); }
        		}
        		,{text  : "Attribute"      , width : 100       , style : "text-align:left;"
        		    ,onRender :  function(d){ return svn (d,"product_attribute_value"); }
        		}
        		,{ text:"Upload Image"      , width:100     , style:"text-align:center;" 
        		    ,onRender : function(d){ return (d !== null ? "<a href='javascript:void(0);'  onclick='showModalUploadUserImage(\"" + svn(d,"product_id") +"\",\"" 
        		                                   + svn(d,"product_code") + "\");'  ><span class='glyphicon glyphicon-upload' style='font-size:12pt;' ></span> </a>" : ""); }
        		}
        		,{text  : "Active?"         , name  : "is_active"                   , type  : "yesno"       , width : 60       , style : "text-align:left;", defaultValue: "Y"}
	    ]
	   /*
        ,onSortClick : function(colNo,orderNo){
            console.log(colNo);
            console.log(orderNo);
        }
        */
    });   
}

// Clear the contents of the select options.
// Param: array of select options
function clearSelectOptions(select_array) {
    $.each(select_array, function() {
        $(this).empty();
    });
}

// Trigger the addition of new product.
$("#btnNew").click(function(){
    g_is_update = false;
    clearEntries();
    $("#modalProduct .modal-title").text("Product Entry");
    $("#modalProduct").modal({ show: true, keyboard: false, backdrop: 'static' });
    $("#tblProductModal #unit_of_measure_id").dataBind({
        url: base_url + "selectoption/code/unit_of_measure"
        , onComplete : function(){
            $("#tblProductModal #product_brand_id").dataBind({
                url: base_url + "selectoption/code/product_brands"
                , onComplete : function(){
                    loadProductClassification();
                }
            });
        }
    });
});

// Load the product classification list for the new entry.
function loadProductClassification() {
    var product_classification = $("#tblProductModal #product_classification_id");
    product_classification.dataBind({ 
        url : execURL + "product_classification_sel_option"
        , onComplete: function() {
            var select_array = [
                $("#tblProductModal #product_category_id")
                ,$("#tblProductModal #product_group_id")
                ,$("#tblProductModal #product_type_id")
                ,$("#tblProductModal #product_attribute_id")
            ];
            if (g_is_update === true) {
                clearSelectOptions(select_array);
                product_classification.val(Product.ClassificationId);
                loadProductCategory(product_classification.val());
            }
            product_classification.change(function(){
                if(product_classification.val() !== "") {
                    clearSelectOptions(select_array);
                    loadProductCategory(product_classification.val());
                }
            });
        }
    });
}

// Load the product category list based on the product classification id for the new entry.
function loadProductCategory(product_classification_id) {
    if (product_classification_id !== null) {
        var product_category = $("#tblProductModal #product_category_id");
        product_category.dataBind({ 
            url :execURL + "product_category_sel_option '" + product_classification_id + "'" 
            , onComplete: function() {
                var select_array = [
                    $("#tblProductModal #product_group_id")
                    ,$("#tblProductModal #product_type_id")
                    ,$("#tblProductModal #product_attribute_id")
                ];
                if (g_is_update === true) {
                    clearSelectOptions(select_array);
                    product_category.val(Product.CategoryId);
                    loadProductGroup(product_category.val());
                }
                product_category.change(function(){
                    if(product_category.val() !== "") {
                        loadProductGroup(product_category.val());
                    }
                });
            }
        });
    }
}

// Load the product group list based on the product category id for the new entry.
function loadProductGroup(product_category_id) {
    if (product_category_id !== null) {
        var product_group = $("#tblProductModal #product_group_id");
        product_group.dataBind({ 
            url :execURL + "product_group_sel_option '" + product_category_id + "'" 
            , onComplete: function() {
                var select_array = [
                    $("#tblProductModal #product_type_id")
                    ,$("#tblProductModal #product_attribute_id")
                ];
                if (g_is_update === true) {
                    clearSelectOptions(select_array);
                    product_group.val(Product.GroupId);
                    loadProductType(product_group.val());
                }
                product_group.change(function(){
                    if(product_group.val() !== "") {
                        loadProductType(product_group.val());
                    }
                });
            }
        });
    }
}

// Load the product type list based on the product group id for the new entry.
function loadProductType(product_group_id) {
    if (product_group_id !== null) {
        var product_type = $("#tblProductModal #product_type_id");
        product_type.dataBind({ 
            url :execURL + "product_type_sel_option '" + product_group_id + "'" 
            , onComplete: function() {
                var select_array = [
                    $("#tblProductModal #product_attribute_id")
                ];
                if (g_is_update === true) {
                    clearSelectOptions(select_array);
                    product_type.val(Product.TypeId);
                    loadProductAttribute(product_type.val());
                }
                product_type.change(function(){
                    if(product_type.val() !== "") {
                        loadProductAttribute(product_type.val());
                    }
                });
            }
        });
    }
}

// Load the product attribute list based on the product type id for the new entry.
function loadProductAttribute(product_type_id) {
    if (product_type_id !== null) {
        var product_attribute = $("#tblProductModal #product_attribute_id");
        product_attribute.dataBind({ 
            url :execURL + "product_attribute_sel_option '" + product_type_id + "'" 
            , onComplete: function() {
                if (g_is_update === true) {
                    product_attribute.val(Product.AttributeId);
                }
            }
        });
    }
}

// Show the modal window for product update.
function showModalUpdate(product_id, product_code) {
    g_is_update = true;
    clearEntries();
    $("#modalProduct .modal-title").text("Product Update");
    $("#modalProduct").modal({ show: true, keyboard: false, backdrop: 'static' });
    $("#tblProductModal #product_id").val(product_id);
    // Get the product info before populating the dropdowns and set their values.
    $.get(execURL + "product_display_sel @product_id=" + product_id 
    , function(data){
        if (data.rows !== null) {
            //Store the product info in the product object, which will be accessed globally after the dropdowns are loaded.
            Product.Name = data.rows[0].product_name;
            Product.UnitOfMeasureId = data.rows[0].unit_of_measure_id;
            Product.BrandId = data.rows[0].product_brand_id;
            Product.ClassificationId = data.rows[0].product_classification_id;
            Product.CategoryId = data.rows[0].product_category_id;
            Product.GroupId = data.rows[0].product_group_id;
            Product.TypeId = data.rows[0].product_type_id;
            Product.AttributeId = data.rows[0].product_attribute_id;
            Product.IsActive = data.rows[0].is_active;

            var obj_product_name = $("#tblProductModal #product_name");
            obj_product_name.val(Product.Name);
            var obj_is_active = $("#tblProductModal #is_active");
            obj_is_active.val(Product.IsActive);
            var obj_unit_of_measure = $("#tblProductModal #unit_of_measure_id");
            obj_unit_of_measure.dataBind({
                url: base_url + "selectoption/code/unit_of_measure"
                , onComplete : function(obj){
                    obj_unit_of_measure.val(Product.UnitOfMeasureId);
                    var obj_product_brand = $("#tblProductModal #product_brand_id");
                    obj_product_brand.dataBind({
                        url: base_url + "selectoption/code/product_brands"
                        , onComplete : function(){
                            obj_product_brand.val(Product.BrandId);
                            loadProductClassification();
                        }
                    });
                }
            });
        }
    });
}

// Triggers the deletion of the selected product(s);
$("#btnDelete").click(function(){
    zsi.form.deleteData({
         code       : "sys-0005"
        , onComplete : function(data){
                        displayRecords();
                      }
    });      
});             

// Clear all the textboxes and set the selected value of the dropdownlists to none.
function clearEntries() {
    $("#tblProductModal input[type=text]").val('');
    $("#tblProductModal select").val('');
}   

// Shows a confirmation message before clearing the input items.
function ClearItems(obj) {
    var result = confirm("This will clear your entries. Continue?");
    if (result) {
        clearEntries();
    }
} 

// Submit the form or element for saving new entries.
function SubmitItems(obj) {
    var result = confirm("All entries correct. Continue?");
    if (result) {
        $('.btn-primary').prop('disabled', true);
        showProcessMessage("Saving data. Please wait...");
        $("#tblProductModal").jsonSubmit({
            procedure: "product_upd"
            , optionalItems: ["product_brand_id", "product_category_id", "is_active", "image_url"]
            , onComplete: function (data) {
                if (data.isSuccess === true) {
                    showProcessMessage("");
                    $('.btn-primary').prop('disabled', false);
                    if (g_is_update === true) {
                        alert('Product updated successfully.');    
                    } else {
                        alert('New product saved successfully.');        
                    }
                    initProduct();
                    clearEntries();
                    displayRecords();
                } else {
                    alert('An error occurred while saving the data. Please try again.');
                }
            }
        });
    }
}

function showProcessMessage(msg) {
    $("#modalProduct #process-message").html(msg);
}
   