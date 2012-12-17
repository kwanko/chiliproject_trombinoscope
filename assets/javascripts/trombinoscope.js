/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function getfilter_users_value()
{
    for (var i=1; i < 4; i++){
        if ($('filter_users_' + i).checked) return i;
    }
    return 0;
}

function filterTrombi(thevalue, thediv, theurl)
{
   new Ajax.Updater(thediv,
                    theurl,
                    {asynchronous:true, evalScripts:true,
                     parameters:'search_user=' + $('search_user').getValue() + '&filter_users=' + thevalue})
}

jQuery(document).ready(function($) {
//    $( "#selectable" ).selectable();

}
)

function valid_form(invalid_text){
    jQuery("#set_picture_form").submit(function() {
      var file_name = jQuery("#trombinoscope_picture_picture").val();
      if (file_name.match(/[A-Za-z0-9]+\.(jpg|jpeg)$/i)) return true;
      jQuery("#error_span").text(file_name + " " + invalid_text).show().fadeOut(5000);
      return false;
    });
}

function ajaxBox() {
    jQuery('.ajax-box').click(function() {
    var mydiv = "<div id='my-dialog' title='" + this.title + "'></div>";
    jQuery("#selectable").before(mydiv);
    jQuery("#my-dialog").html('').load(this.href);
    jQuery("#my-dialog").dialog({buttons: {Cancel: function() {jQuery( this ).dialog( "close" );}}, width: 'auto', modal: true, close: function(event, ui) {jQuery(this).remove();}});

    return false;

  });
}