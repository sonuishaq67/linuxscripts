echo "sync"
sudo sync
echo "1 out of 5: sync over"
echo "drop caches, innodes and dentries"
sudo echo 3 > /proc/sys/vm/drop_caches
echo "2 out of 5: proc file over"
echo "swapoff"
sudo swapoff -av
echo "3 out of 5: swapoff over"
echo "sleep 30 secs"
sleep 30s
echo "sleep done"
echo "swapon"
sudo swapon -av
echo "4 out of 5: swapon over"
echo "status"
sudo free -h
echo "5 out of 5: done."
