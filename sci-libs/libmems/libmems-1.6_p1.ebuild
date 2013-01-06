# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libmems/libmems-1.6_p1.ebuild,v 1.2 2012/11/09 06:43:40 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="Library for sci-biology/mauve"
HOMEPAGE="http://gel.ahabs.wisc.edu/mauve/"
SRC_URI="http://dev.gentoo.org/~jlec/${P}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

CDEPEND="
	dev-libs/boost
	sci-libs/libgenome
	sci-libs/libmuscle"
DEPEND="${CDEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${CDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-build.patch
	"${FILESDIR}"/${P}-boost.patch
	"${FILESDIR}"/${P}-gcc-4.7.patch
	)
