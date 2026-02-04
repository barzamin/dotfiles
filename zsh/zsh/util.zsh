function rightnow() {
	cat /proc/uptime | read now _
	echo $now
}
