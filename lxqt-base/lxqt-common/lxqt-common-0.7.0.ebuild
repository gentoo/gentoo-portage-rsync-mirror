# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-common/lxqt-common-0.7.0.ebuild,v 1.1 2014/05/26 14:03:42 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt common resources"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

S=${WORKDIR}

DEPEND="lxqt-base/liblxqt
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4"
RDEPEND="${DEPEND}"
PDEPEND="lxqt-base/lxqt-session"

src_install() {
	cmake-utils_src_install
	dodir "/etc/X11/Sessions"
	dosym  "/usr/bin/startlxqt" "/etc/X11/Sessions/lxqt"
}
