# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/libqtxdg/libqtxdg-0.5.1.ebuild,v 1.6 2013/01/20 19:06:40 ago Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="http://razor-qt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="mirror://github/Razor-qt/razor-qt/razorqt-${PV}.tar.bz2"
	KEYWORDS="amd64 ~ppc x86"
	S="${WORKDIR}/razorqt-${PV}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="sys-apps/file
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	!<razorqt-base/razorqt-meta-0.5.0
	!x11-wm/razorqt"
RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

CMAKE_USE_DIR=${S}/libraries/qtxdg
