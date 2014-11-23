# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-notificationd/lxqt-notificationd-0.7.0.ebuild,v 1.6 2014/11/23 16:21:10 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt notification daemon and library"
HOMEPAGE="http://lxqt.org/"

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

DEPEND="
	~dev-libs/libqtxdg-0.5.3
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	~lxqt-base/liblxqt-${PV}
	~lxqt-base/lxqt-common-${PV}
"
RDEPEND="${DEPEND}"
