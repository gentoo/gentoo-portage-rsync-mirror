# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/liblxqt/liblxqt-0.7.0.ebuild,v 1.4 2014/11/02 21:18:07 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

S=${WORKDIR}

DEPEND=">=razorqt-base/libqtxdg-0.5.3
	<razorqt-base/libqtxdg-1.0.0
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"
