# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-meta/lxqt-meta-0.7.0.ebuild,v 1.1 2014/05/27 18:20:21 jauhien Exp $

EAPI=5

inherit readme.gentoo

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="http://lxqt.org/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-minimal powermanagement"

S="${WORKDIR}"

DOC_CONTENTS="
	For your convenience you can review
	http://www.gentoo.org/proj/en/desktop/lxde/lxde-howto.xml and
	http://wiki.lxde.org/en/LXDE-Qt"

RDEPEND="
	>=lxde-base/lxde-icon-theme-0.5
	>=lxde-base/lxmenu-data-0.1.2
	~lxqt-base/lxqt-about-${PV}
	~lxqt-base/lxqt-common-${PV}
	~lxqt-base/lxqt-config-${PV}
	~lxqt-base/lxqt-config-randr-${PV}
	~lxqt-base/lxqt-notificationd-${PV}
	~lxqt-base/lxqt-panel-${PV}
	~lxqt-base/lxqt-policykit-${PV}
	~lxqt-base/lxqt-qtplugin-${PV}
	~lxqt-base/lxqt-runner-${PV}
	~lxqt-base/lxqt-session-${PV}
	~x11-misc/pcmanfm-qt-${PV}
	!minimal? (
		x11-wm/openbox
		>=x11-misc/obconf-qt-0.1.0 )
	powermanagement? (
		~lxqt-base/lxqt-powermanagement-${PV} )
"

pkg_postinst() {
	readme.gentoo_pkg_postinst
}
