--- vpnclient-orig/linuxcniapi.c	2008-06-23 11:59:12.000000000 -0500
+++ vpnclient/linuxcniapi.c	2009-11-12 15:33:52.135669168 -0600
@@ -338,8 +338,12 @@
     skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,22)
-    skb->network_header = (sk_buff_data_t) skb->data;
-    skb->mac_header = (sk_buff_data_t)pMac;
+/* 2.6.22 added an inline function for 32-/64-bit usage here, so use it.
+ * We have to use (pMac - skb->data) to get an offset.
+ * We need to cast ptrs to byte ptrs and take the difference.
+ */
+    skb_reset_network_header(skb);
+    skb_set_mac_header(skb, (int)((void *)pMac - (void *)skb->data));
 #else
     skb->nh.iph = (struct iphdr *) skb->data;
     skb->mac.raw = pMac;
@@ -478,8 +482,12 @@
     skb->dev = pBinding->pDevice;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,22)
-    skb->mac_header = (sk_buff_data_t)pMac;
-    skb->network_header = (sk_buff_data_t)pIP;
+/* 2.6.22 added an inline function for 32-/64-bit usage here, so use it.
+ * We have to use (pIP/pMac - skb->data) to get an offset.
+ * We need to cast ptrs to byte ptrs and take the difference.
+ */
+    skb_set_mac_header(skb, (int)((void *)pMac - (void *)skb->data));
+    skb_set_network_header(skb, (int)((void *)pIP - (void *)skb->data));
 #else
     skb->mac.raw = pMac;
     skb->nh.raw = pIP;
@@ -487,8 +495,13 @@
 
     /*ip header length is in 32bit words */
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,22)
-    skb->transport_header = (sk_buff_data_t)
-      (pIP + (((struct iphdr*)(skb->network_header))->ihl * 4));
+/* 2.6.22 added an inline function for 32-/64-bit usage here, so use it.
+ * We have to use (pIP - skb->data) to get an offset.
+ * We need to cast ptrs to byte ptrs and take the difference.
+ */
+    skb_set_transport_header(skb,
+        ((int)((void *)pIP - (void *)skb->data) +
+           (((struct iphdr*)(skb_network_header(skb)))->ihl * 4)));
 #else
     skb->h.raw = pIP + (skb->nh.iph->ihl * 4);
 #endif
@@ -496,7 +509,11 @@
 
     /* send this packet up the NIC driver */
     // May need to call dev_queue_xmit(skb) instead
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)
+    tmp_rc = pBinding->Inject_ops->ndo_start_xmit(skb, skb->dev);
+#else
     tmp_rc = pBinding->InjectSend(skb, skb->dev);
+#endif
 
 #ifdef VIRTUAL_ADAPTER
     pVABinding = CniGetVABinding();
