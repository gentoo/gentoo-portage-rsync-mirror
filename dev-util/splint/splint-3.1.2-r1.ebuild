# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/splint/splint-3.1.2-r1.ebuild,v 1.2 2014/06/18 13:43:06 klausman Exp $

EAPI=5

DESCRIPTION="Check C programs for vulnerabilities and programming mistakes"
HOMEPAGE="http://lclint.cs.virginia.edu/"
SRC_URI="http://www.splint.org/downloads/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="
	sys-devel/flex
"

src_configure() {
	# We do not need bison/yacc at all here
	# We definitely need libfl
	BISON=no LEXLIB=-lfl econf
}

src_compile() {
	local subdir
	# skip test/ subdir
	for subdir in src lib imports doc; do
		emake -j1 -C ${subdir}
	done
}

src_test() {
	emake -C test
}
