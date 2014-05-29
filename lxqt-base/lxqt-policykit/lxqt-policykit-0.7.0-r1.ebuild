# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-policykit/lxqt-policykit-0.7.0-r1.ebuild,v 1.2 2014/05/29 08:07:47 mrueg Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt PolKit authentication agent"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
	S=${WORKDIR}
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	lxqt-base/liblxqt
	razorqt-base/libqtxdg
	sys-auth/polkit-qt
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install(){
	cmake-utils_src_install
	doman man/*.1
}
