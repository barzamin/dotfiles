function rightnow() {
	local now _discard
	cat /proc/uptime | read now _discard
	echo $now
}
