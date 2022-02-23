# notify.sh
Shell scripts to send notification to IM (Telegram here) when commands end.


## Install && Configure

	curl https://raw.githubusercontent.com/kings-way/notify/master/notify.sh >> ~/.bashrc

	# then configure the API TOKEN and CHAT ID, even the api address.
	source ~/.bashrc

## Run

	sleep 2; notify

## Sample output

	Status: ✅
	from: [ Server-01 ]
	code: [ 0 ]
	cmd : [ sleep 2; notify ]

## Notice

* This script has only been tested on zsh and bash. Use at your own risk.
* You can edit the script to support more IMs' bot API. See the code comments.
