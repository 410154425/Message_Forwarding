#!/system/bin/sh
until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 5
done
sleep 1
MODDIR=${0%/*}
chmod 0755 "$MODDIR/up"
chmod 0755 "$MODDIR/mf.sh"
chmod 0755 "$MODDIR/upmf.sh"
chmod 0755 "$MODDIR/testing.sh"
chmod 0644 "$MODDIR/config.conf"
sleep 1
up=1
while :;
do
if [ "$up" = "60" -o "$up" = "21600" ]; then
	"$MODDIR/up" > /dev/null 2>&1 &
	up=61
fi
"$MODDIR/mf.sh" > /dev/null 2>&1
up="$(( $up + 1 ))"
sleep 1
done
