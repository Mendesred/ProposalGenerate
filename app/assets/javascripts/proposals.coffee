# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap

jQuery ->
	$('#proposalTab').DataTable({
		responsive: true
		 });

check_value = (obj_select, obj_collapse) ->
	if obj_select.val() == '1'
		obj_collapse.collapse 'show'
		##console.log 'teste clicou 1'
		##console.log "valshow = #{obj_collapse.attr('id')}"
	if obj_select.val() == '0'
		obj_collapse.collapse 'hide'
		##console.log 'teste clicou 0'
		##console.log "valhide = #{obj_collapse.attr('id')}"
	return
	
hash =
	{'#proposal_h_extra_jornada_all': '#hExtraSim',
	'#proposal_h_extra_refeicao_all': '#hExtraAllAlmoco',
	'#proposal_h_extra_jornada_matu': '#hExtraMatutinoJornada',
	'#proposal_h_extra_refeicao_matu': '#almocoExtraMatutinoAlmoco',
	'#proposal_h_extra_jornada_vesp': '#hExtraVespertinoJornda',
	'#proposal_h_extra_refeicao_vesp': '#hExtraVespertinoAlmoco',
	'#proposal_h_extra_jornada_notur': '#hExtraNoturnoJornada',
	'#proposal_h_extra_refeicao_notur': '#hExtraNoturnoAlmoco',
	'#proposal_vr_all': '#allDiasVR',
	'#proposal_vr_matu': '#matutinoVr',
	'#proposal_vr_vesp': '#vespertinoVrOption',
	'#proposal_vr_notur': '#noturnoVrOption',
	'#proposal_vt_all': '#allDiasVT',
	'#proposal_vt_matu': '#peridMatutinoJornada',
	'#proposal_vt_vesp': '#periodVespJornada',
	'#proposal_vt_notur': '#periodNoturnoJornada'}


###h_extra_jornada_all###
$(document).ready ->
	for key, val of hash
		$(key).on 'change', check_value($(key), $(val))
		#console.log "val = #{$(key).val()}"
		#console.log "#{key} = #{val}"
	return


$(document).on 'change', '#proposal_h_extra_jornada_all', ->
	check_value $('#proposal_h_extra_jornada_all'), $('#hExtraSim')
	return
$(document).on 'change', '#proposal_h_extra_refeicao_all', ->
	check_value $('#proposal_h_extra_refeicao_all'), $('#hExtraAllAlmoco')
	return
$(document).on 'change', '#proposal_h_extra_jornada_matu', ->
	check_value $('#proposal_h_extra_jornada_matu'), $('#hExtraMatutinoJornada')
	return
$(document).on 'change', '#proposal_h_extra_refeicao_matu', ->
	check_value $('#proposal_h_extra_refeicao_matu'), $('#almocoExtraMatutinoAlmoco')
	return
$(document).on 'change', '#proposal_h_extra_jornada_vesp', ->
	check_value $('#proposal_h_extra_jornada_vesp'), $('#hExtraVespertinoJornda')
	return
$(document).on 'change', '#proposal_h_extra_refeicao_vesp', ->
	check_value $('#proposal_h_extra_refeicao_vesp'), $('#hExtraVespertinoAlmoco')
	return
$(document).on 'change', '#proposal_h_extra_jornada_notur', ->
	check_value $('#proposal_h_extra_jornada_notur'), $('#hExtraNoturnoJornada')
	return
$(document).on 'change', '#proposal_h_extra_refeicao_notur', ->
	check_value $('#proposal_h_extra_refeicao_notur'), $('#hExtraNoturnoAlmoco')
	return
$(document).on 'change', '#proposal_vr_all', ->
	check_value $('#proposal_vr_all'), $('#allDiasVR')
	return
$(document).on 'change', '#proposal_vr_matu', ->
	check_value $('#proposal_vr_matu'), $('#matutinoVr')
	return
$(document).on 'change', '#proposal_vr_vesp', ->
	check_value $('#proposal_vr_vesp'), $('#vespertinoVrOption')
	return
$(document).on 'change', '#proposal_vr_notur', ->
	check_value $('#proposal_vr_notur'), $('#noturnoVrOption')
	return
$(document).on 'change', '#proposal_vt_all', ->
	check_value $('#proposal_vt_all'), $('#allDiasVT')
	return
$(document).on 'change', '#proposal_vt_matu', ->
	check_value $('#proposal_vt_matu'), $('#peridMatutinoJornada')
	return
$(document).on 'change', '#proposal_vt_vesp', ->
	check_value $('#proposal_vt_vesp'), $('#periodVespJornada')
	return
$(document).on 'change', '#proposal_vt_notur', ->
	check_value $('#proposal_vt_notur'), $('#periodNoturnoJornada')
	return

check_radio = (obj_select_radio1, obj_select_radio2, obj_collapse1, obj_collapse2) ->
  if document.getElementById(obj_select_radio1.attr('id')).checked
    obj_collapse1.collapse 'show'
    obj_collapse2.collapse 'hide'
  if document.getElementById(obj_select_radio2.attr('id')).checked
    obj_collapse1.collapse 'hide'
    obj_collapse2.collapse 'show'
  return


$(document).ready ->
  $('#proposal_radio_h_extra_all').on 'change', check_radio($('#proposal_radio_h_extra_all'), $('#proposal_radio_h_extra_parcial'), $('#tab_all'), $('#tab_parcial'))
  return
$(document).on 'change', '#proposal_radio_h_extra_all', ->
  check_radio $(this), $('#proposal_radio_h_extra_parcial'), $('#tab_all'), $('#tab_parcial')
  return
$(document).on 'change', '#proposal_radio_h_extra_parcial', ->
  check_radio $('#proposal_radio_h_extra_all'), $(this), $('#tab_all'), $('#tab_parcial')
  return
$(document).ready ->
  $('#proposal_radio_vr_extra_all').on 'change', check_radio($('#proposal_radio_vr_extra_all'), $('#proposal_radio_vr_extra_parcial'), $('#tab_all_vr'), $('#tab_parcial_vr'))
  return
$(document).on 'change', '#proposal_radio_vr_extra_all', ->
  check_radio $(this), $('#proposal_radio_vr_extra_parcial'), $('#tab_all_vr'), $('#tab_parcial_vr')
  return
$(document).on 'change', '#proposal_radio_vr_extra_parcial', ->
  check_radio $('#proposal_radio_vr_extra_all'), $(this), $('#tab_all_vr'), $('#tab_parcial_vr')
  return
$(document).ready ->
  $('#proposal_radio_vt_extra_all').on 'change', check_radio($('#proposal_radio_vt_extra_all'), $('#proposal_radio_vt_extra_parcial'), $('#tab_all_vt'), $('#tab_parcial_vt'))
  return
$(document).on 'change', '#proposal_radio_vt_extra_all', ->
  check_radio $(this), $('#proposal_radio_vt_extra_parcial'), $('#tab_all_vt'), $('#tab_parcial_vt')
  return
$(document).on 'change', '#proposal_radio_vt_extra_parcial', ->
  check_radio $('#proposal_radio_vt_extra_all'), $(this), $('#tab_all_vt'), $('#tab_parcial_vt')
  return