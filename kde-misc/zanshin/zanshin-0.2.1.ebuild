# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/zanshin/zanshin-0.2.1.ebuild,v 1.4 2012/04/19 04:25:56 maekke Exp $

EAPI=4

VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Todo management application for KDE"
HOMEPAGE="http://zanshin.kde.org/"
SRC_URI="http://files.kde.org/${PN}/${P}.tar.bz2"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdepim-runtime '' 4.6.0)
	dev-libs/boost
"
DEPEND=${RDEPEND}
