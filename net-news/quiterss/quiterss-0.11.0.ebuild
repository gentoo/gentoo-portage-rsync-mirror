# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/quiterss/quiterss-0.11.0.ebuild,v 1.2 2013/03/02 23:07:49 hwoarang Exp $

EAPI=5

inherit qt4-r2

MY_P=QuiteRSS-${PV}-src

DESCRIPTION="A Qt4-based RSS/Atom feed reader"
HOMEPAGE="http://code.google.com/p/quite-rss/"
SRC_URI="http://quite-rss.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-qt/qtwebkit:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS=(AUTHORS HISTORY_EN HISTORY_RU README)

PATCHES=(
	"${FILESDIR}/${PN}-0.11.0-unbundle-sqlite.patch"
)
