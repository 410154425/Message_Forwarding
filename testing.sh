#!/system/bin/sh
#
#如发现模块BUG，执行此脚本文件，把结果截图给作者，谢谢！
#
MODDIR=${0%/*}
if type curl > /dev/null 2>&1; then
	MF_notification="$(dumpsys notification --noredact | sed -n 's/\\//g;p')"
	if [ ! -n "$MF_notification" ]; then
		MF_notification="$(dumpsys notification | sed -n 's/\\//g;p')"
		if [ ! -n "$MF_notification" ]; then
			echo "无法获取消息通知列表"
			exit 0
		fi
	fi
	MF_NotificationRecord="$(echo -e $MF_notification | sed -n 's/NotificationRecord(/\\nNotificationRecord(/g;p')"
	MF_Message="$(echo -e "$MF_NotificationRecord" | sed -n 's/mAdjustments=\[.*//g;s/stats=SingleNotificationStats{.*//g;p')"
	echo "serialno.$(getprop ro.serialno | sed -n 's/ //g;$p'),release.$(getprop ro.build.version.release | sed -n 's/ //g;$p'),sdk.$(getprop ro.build.version.sdk | sed -n 's/ //g;$p'),brand.$(getprop ro.product.brand | sed -n 's/ //g;$p'),model.$(getprop ro.product.model | sed -n 's/ //g;$p')"
	echo "$MF_Message"
else
	echo "系统缺少curl命令模块：无法转发消息，请安装curl模块后再使用"
fi

