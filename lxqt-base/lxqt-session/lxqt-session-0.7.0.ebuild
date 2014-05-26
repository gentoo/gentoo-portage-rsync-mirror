# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-session/lxqt-session-0.7.0.ebuild,v 1.1 2014/05/26 14:03:42 jauhien Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="LXQT session manager"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

S=${WORKDIR}

CDEPEND="dev-qt/qtcore:4
	dev-qt/qtdbus
	dev-qt/qtgui:4
	lxqt-base/liblxqt
	razorqt-base/libqtxdg
	x11-libs/libX11"
DEPEND="${CDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	lxqt-base/lxqt-common"
