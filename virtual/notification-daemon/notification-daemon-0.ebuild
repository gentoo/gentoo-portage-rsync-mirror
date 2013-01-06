# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/notification-daemon/notification-daemon-0.ebuild,v 1.8 2012/11/19 09:19:26 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual for notification daemon dbus service"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="gnome"

RDEPEND="
	gnome? ( || ( x11-misc/notification-daemon
		gnome-base/gnome-shell ) )
	!gnome? ( || ( x11-misc/notification-daemon
		xfce-extra/xfce4-notifyd
		x11-misc/qtnotifydaemon
		x11-misc/notify-osd
		>=x11-wm/awesome-3.4.4
		x11-wm/enlightenment[enlightenment_modules_notification]
		x11-wm/enlightenment[e_modules_notification]
		kde-base/knotify ) )"
DEPEND=""
