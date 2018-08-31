// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require notifyjs
//= require bootbox
//= require bootstrap_sb_admin_base_v2
//= require cocoon
//= require_tree .

// sobre escreve o dataconfirm do rails
$.rails.allowAction = function(element) {
  var message = element.attr('data-confirm');
  if (!message) { return true; }

  var opts = {
    title: "Confirmação",
    message: message,
    buttons: {
        confirm: {
            label: 'Sim',
            className: 'btn-success'
        },
        cancel: {
            label: 'Não',
            className: 'btn-danger'
        }
    },
    callback: function(result) {
      if (result) {
        element.removeAttr('data-confirm');
        element.trigger('click.rails')
      }
    }
  };

  bootbox.confirm(opts);

  return false;
}

// Js Original com funções do collapse na pasta Bug_somente_consulta 

//função para exibir check_box


function functionSelect() {
    var values1 = $('table tr td :checkbox:checked').map(function () {
                 var $this = $(this);
                 var linha =$this.closest('tr').find('td');
                 return linha[0].getElementsByTagName("input")[0].value;
              }).get();

    console.log(values1);
    openInNewTab(window.location.href+'/2.pdf?ids='+values1.toString());
}
function openInNewTab(url) {
  var win = window.open(url, '_blank');

  win.focus();
}