# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/jreen/jreen-1.1.1.ebuild,v 1.4 2014/05/22 17:05:29 kensington Exp $

EAPI=5

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/euroelessar/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~ppc x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/euroelessar/${PN}"
	KEYWORDS=""
fi

inherit qt4-r2 cmake-utils ${GIT_ECLASS}

DESCRIPTION="Qt XMPP library"
HOMEPAGE="https://github.com/euroelessar/jreen"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND="
	>=app-crypt/qca-2.0.3
	>=net-dns/libidn-1.20
	>=dev-qt/qtcore-4.6.0:4
	>=dev-qt/qtgui-4.6.0:4
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog README )
