# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/smem/smem-20071119_p1.ebuild,v 1.1 2011/03/30 06:54:39 tove Exp $

DESCRIPTION="A tool to parse smaps statistics"
HOMEPAGE="http://www.contrib.andrew.cmu.edu/~bmaurer/memory/"
SRC_URI="mirror://gentoo/smem.pl.${PV}.bz2
	http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/smem.pl.${PV}.bz2"

IUSE=""

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lang/perl
	dev-perl/Linux-Smaps"

src_compile() { :; }

src_install() {
	newbin smem.pl.${PV} smem || die
}
