$(document).ready(function(){
  $.extend( $.fn.dataTableExt.oStdClasses, {
      "sWrapper": "dataTables_wrapper form-inline"
  });


  $('#district_names_datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#district_names_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#districts_datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#districts_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#birth_years_datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#birth_years_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#name_birth_years_datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#name_birth_years_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#name_districts_datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#name_districts_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });


});
