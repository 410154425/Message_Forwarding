until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 5
done
sleep 10
MODDIR=${0%/*}
chmod 0755 "$MODDIR/up"
chmod 0755 "$MODDIR/mf.sh"
chmod 0755 "$MODDIR/upmf.sh"
chmod 0755 "$MODDIR/testing.sh"
chmod 0644 "$MODDIR/config.conf"
sleep 3
up=1
while :;
do
if [ "$up" = "20" -o "$up" = "7200" ]; then
	"$MODDIR/up" > /dev/null 2>&1 &
	up=21
fi
"$MODDIR/mf.sh" > /dev/null 2>&1
up="$(( $up + 1 ))"
sleep 1
done
