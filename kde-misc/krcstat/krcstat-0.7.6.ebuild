# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krcstat/krcstat-0.7.6.ebuild,v 1.1 2012/10/26 04:42:23 creffett Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A Gentoo system management tool"
HOMEPAGE="http://www.binro.org"
SRC_URI="http://binro.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep konsole)
"
RDEPEND="${DEPEND}"
