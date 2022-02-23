# curl https://raw.githubusercontent.com/kings-way/notify/master/notify.sh >> ~/.bashrc
# source ~/.bashrc
# run:  cmd ; notify

TELEGRAM_CHAT_ID="xxxxxxxxxx"
TELEGRAM_BOT_TOKEN="xxxxxxxx"
API_URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage?parse_mode=html&chat_id=$TELEGRAM_CHAT_ID"

# or you can setup a proxy server like below, to hide the TOKEN or CHAT_ID from this script.
# API_URL="https://some.example.com/tg_bot_notify/$TELEGRAM_CHAT_ID"

notify() {
	ret_code=$?
	shell=$(cat /proc/$$/comm)

	# if we run something like: "cmd; notify", then there is only one line of shell history.
	# and we are not using builtin-vars like !!, cause it only works in interactive-shell. 
	if [ "$shell" = "bash" ]; then
		cur_cmd=$(history 1 | sed 's/^ *[0-9]* *//')	# bash will output the current command
	elif [ "$shell" = "zsh" ]; then
		#cur_cmd=$(history -1)							# zsh will output the last command
		cur_cmd=$history[${(%):-%h}]
	else
		cur_cmd=$(history | tail -1)
	fi

	if [ $ret_code -eq 0 ];then
		ret_status="✅"
	else
		ret_status="❌"
	fi

	text="Status: $ret_status\n"
	text+="from: [ <b>$(hostname)</b> ]\n"
	text+="code: [ <b>$ret_code</b> ]\n"
	text+="cmd : [ <code>$cur_cmd</code> ]"

	curl "$API_URL" --data-urlencode text="$(echo -e $text)" >> /dev/null 2>&1
}
