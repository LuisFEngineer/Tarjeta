extends Control

@onready var animator = $Anims
@onready var tarjeta = $Tarjeta
@onready var boton = $OpenBt

@onready var diasL = $Tarjeta/bgContador/vCont/dateCont/dias
@onready var horasL = $Tarjeta/bgContador/vCont/dateCont/horas
@onready var minsL = $Tarjeta/bgContador/vCont/dateCont/mins
@onready var segsL = $Tarjeta/bgContador/vCont/dateCont/segs

var sensibilidad = 1.3
var count = 0

var maxDayNumForDate = 35
var hourParty = 17

func _ready() -> void:
	getReverseCount()
	for child in get_children():
		if child is TextureRect:
			if child.name.begins_with("tapa") && !child.name.ends_with("1"):
				child.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		var offset = event.relative.y * sensibilidad
		if count+offset <= 0 && count+offset > -tarjeta.size.y+1920:
			count += offset
			tarjeta.position.y = count

func _process(delta: float) -> void:
	getReverseCount()

func _on_open_bt_pressed() -> void:
	animator.play("OpenSobre")
	boton.visible = false


func _on_link_2_pressed() -> void:
	OS.shell_open("https://www.google.com/maps?q=Jard%C3%ADn+Jeric%C3%B3,+Acatempan+29,+Col.+Loma+del+Pi%C3%B1%C3%B3n,+58056+Morelia,+Mich.&ftid=0x842d0dcc78dc63b1:0xaf54a5a9dadeac82&entry=gps&lucs=,94297695,94275415,94284484,94231188,94280568,47071704,94218641,94282134,94286869&g_ep=CAISEjI1LjQ5LjkuODM4ODk5MTgzMBgAIIgnKlEsOTQyOTc2OTUsOTQyNzU0MTUsOTQyODQ0ODQsOTQyMzExODgsOTQyODA1NjgsNDcwNzE3MDQsOTQyMTg2NDEsOTQyODIxMzQsOTQyODY4NjlCAk1Y&skid=e008b9df-1b8e-4e2f-bf8b-e7721d23eba8&g_st=ipc")


func _on_link_1_pressed() -> void:
	OS.shell_open("https://www.google.com/maps/place/Parroquia+de+la+Inmaculada+Concepci%C3%B3n+de+la+Virgen+Mar%C3%ADa/@19.7006594,-101.1736406,17z/data=!3m1!4b1!4m6!3m5!1s0x842d0e0f4ff981ad:0x866d4cf589987066!8m2!3d19.7006594!4d-101.1736406!16s%2Fm%2F0288xmf?entry=ttu&g_ep=EgoyMDI2MDExMy4wIKXMDSoASAFQAw%3D%3D")

func getReverseCount():
	var now_ts = Time.get_unix_time_from_system()
	
	var target_datetime = {
		"year": 2026,
		"month": 2,
		"day": 14,
		"hour": 17,
		"minute": 0,
		"second": 0
	}
	
	var target_ts = Time.get_unix_time_from_datetime_dict(target_datetime)
	var remaining = target_ts - now_ts
	
	format_time(remaining)
	
func format_time(seconds: int) -> void:
	seconds = max(seconds, 0)

	var days = seconds / 86400
	var hours = (seconds % 86400) / 3600
	var minutes = (seconds % 3600) / 60
	var secs = seconds % 60
	
	diasL.text = "%d" % days
	horasL.text = "%02d" % hours
	minsL.text = "%02d" % minutes
	segsL.text = "%02d" % secs
