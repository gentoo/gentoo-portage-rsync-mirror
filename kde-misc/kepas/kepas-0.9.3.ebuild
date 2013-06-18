# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kepas/kepas-0.9.3.ebuild,v 1.1 2013/06/17 23:52:02 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A zeroconf KDE4 filetransfer tool"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=73968"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug oscar zeroconf"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
	oscar? ( $(add_kdebase_dep kopete oscar) )
	zeroconf? ( $(add_kdebase_dep kdnssd) )
"

PATCHES=( "${FILESDIR}/${P}-as-needed.patch" )
