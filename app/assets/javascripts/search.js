$(document).ready(function(){
  $.extend( $.fn.dataTableExt.oStdClasses, {
      "sWrapper": "dataTables_wrapper form-inline"
  });


  $('#district_names_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#district_names_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#districts_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#districts_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#birth_years_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#birth_years_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#first_name_birth_years_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#first_name_birth_years_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#last_name_birth_years_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#last_name_birth_years_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#first_name_districts_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#first_name_districts_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#last_name_districts_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#last_name_districts_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#first_name_country_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#first_name_country_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#last_name_country_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#last_name_country_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#names_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#names_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#first_name_search_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#first_name_search_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    },
    "oSearch": {"sSearch": gon.initial_name_search}
  });

  $('#last_name_search_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#last_name_search_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    },
    "oSearch": {"sSearch": gon.initial_name_search}
  });

  $('#full_name_search_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#full_name_search_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    },
    "oSearch": {"sSearch": gon.initial_name_search},
/*    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 0 ] },
      { "sClass": "datatable_link_col", "aTargets": [ 0 ] }
    ],
    "aaSorting": [[1, 'asc']],*/
  });

  $('#districts_full_name_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#districts_full_name_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });

  $('#birth_years_full_name_datatable').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",    
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#birth_years_full_name_datatable').data('source'),
    "oLanguage": {
      "sUrl": gon.datatable_i18n_url
    }
  });


});
