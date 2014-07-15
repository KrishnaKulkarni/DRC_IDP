$(function() {

    // var $resourceSiteWebsite = $('input#resource_site_website');
//
//     $('input.required').validate(function(e) {
//         return e.val().trim() != '';
//     });
//
//     $().validate(function(e) {
//         return (!!e.val().isURL()
//             && e.val().indexOf('javascript:') == -1);
//     });
//
//     $('#save').click(function() {
//         var $invalidInputs = $('.invalid-input');
//         if ($resourceSiteWebsite.val().indexOf('http') != 0) {
//             $resourceSiteWebsite.val(
//                 'http://' + $resourceSiteWebsite.val());
//         }
//         if (!!$invalidInputs.length) {
//             $invalidInputs.addClass('force');
//             vex.dialog.alert("Please fill out the highlighted fields.");
//             return false;
//         }
//     });
//
//     var disableAvailability = function() {
//         var checked = !!($(this).is(':checked'));
//         $('.resource_site_available_date')
//                 .fadeTo('slow', (0+checked), function() {})
//                 .prop('disabled', checked);
//     };
//
//     var setDateFieldDefaultStatus = function() {
//         if (!$('#resource_site_capacity_sensitive').is(':checked')) {
//             $('.resource_site_available_date').prop('disabled', true).hide();
//         }
//     };
//
//     setDateFieldDefaultStatus();
//     $('#resource_site_capacity_sensitive').click(disableAvailability);
//
//     $('.closed-toggle').change(function() {
//         var isChecked = $(this).is(':checked');
//         $(this).parents('tr')
//             .toggleClass('inactive', isChecked)
//             .find('select.time-input').attr('disabled', isChecked ? "disabled" : false);
//     });
    
    
    //Toggle visibility which inputs are disabled based on the checkbox
    $('#gold_standard_identity_alternate_village_status').change(function(){
      
        var isChecked = $(this).is(':checked');         
        $('.gold_standard_identity_village_id').toggleClass('blurred');
        $('.gold_standard_identity_alternate_village').toggleClass('blurred');                
        $('#gold_standard_identity_village_id').attr('disabled', isChecked ? "disabled" : false);
        $('#gold_standard_identity_alternate_village').attr('disabled', isChecked ? false : "disabled");
    });
    
    $('#gold_standard_identity_head_of_household_status').change(function(){
      
        var isChecked = $(this).is(':checked');         
        $('.gold_standard_identity_head_of_household_first_name').toggleClass('blurred');               
        $('#gold_standard_identity_head_of_household_first_name').attr('disabled', isChecked ? "disabled" : false);
        $('.gold_standard_identity_head_of_household_last_name').toggleClass('blurred');               
        $('#gold_standard_identity_head_of_household_last_name').attr('disabled', isChecked ? "disabled" : false);
        $('.gold_standard_identity_head_of_household_alternate_name').toggleClass('blurred');               
        $('#gold_standard_identity_head_of_household_alternate_name').attr('disabled', isChecked ? "disabled" : false);
        $('.gold_standard_identity_relation_to_head_of_household').toggleClass('blurred');               
        $('#gold_standard_identity_relation_to_head_of_household').attr('disabled', isChecked ? "disabled" : false);
    });

});
