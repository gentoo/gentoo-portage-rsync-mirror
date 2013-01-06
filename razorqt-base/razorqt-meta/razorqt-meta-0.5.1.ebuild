# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/razorqt-meta/razorqt-meta-0.5.1.ebuild,v 1.2 2013/01/06 18:13:00 ago Exp $

EAPI=4

DESCRIPTION="Meta ebuild to install the complete Razor-qt desktop environment"
HOMEPAGE="http://razor-qt.org/"
SRC_URI=""

if [[ ${PV} = *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~ppc ~x86"
fi

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
IUSE="doc +lightdm +policykit"

DEPEND=""
RDEPEND="~razorqt-base/libqtxdg-${PV}
	~razorqt-base/razorqt-appswitcher-${PV}
	~razorqt-base/razorqt-autosuspend-${PV}
	~razorqt-base/razorqt-config-${PV}
	~razorqt-base/razorqt-data-${PV}[doc?]
	~razorqt-base/razorqt-desktop-${PV}
	~razorqt-base/razorqt-kbshortcuts-${PV}
	~razorqt-base/razorqt-libs-${PV}
	~razorqt-base/razorqt-notifications-${PV}
	~razorqt-base/razorqt-openssh-askpass-${PV}
	~razorqt-base/razorqt-panel-${PV}
	~razorqt-base/razorqt-power-${PV}
	~razorqt-base/razorqt-runner-${PV}
	~razorqt-base/razorqt-session-${PV}
	lightdm? ( ~razorqt-base/razorqt-lightdm-greeter-${PV} )
	policykit? ( ~razorqt-base/razorqt-policykit-${PV} )
	|| ( x11-wm/openbox
		kde-base/kwin
		x11-wm/metacity
		xfce-base/xfwm4
		x11-wm/enlightenment
		x11-wm/fvwm
		x11-wm/sawfish
		x11-wm/windowmaker
	)
	!<razorqt-base/razorqt-lightdm-greeter-0.5.0
	!<razorqt-base/razorqt-meta-0.5.0
	!x11-misc/lightdm-razorqt-greeter
	!x11-wm/razorqt"
