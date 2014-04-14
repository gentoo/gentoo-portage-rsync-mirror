# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/uncrustify/uncrustify-9999.ebuild,v 1.3 2014/04/14 06:40:55 alexxy Exp $

EAPI="5"

if [[ $PV == *9999* ]]; then
	EGIT_REPO_URI="git://github.com/bengardner/uncrustify.git
		https://github.com/bengardner/uncrustify.git"
	KEYWORDS=""
	SRC_URI=""
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris ~x86-solaris"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

inherit eutils

DESCRIPTION="C/C++/C#/D/Java/Pawn code indenter and beautifier"
HOMEPAGE="http://uncrustify.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="test"

DEPEND="test? ( =dev-lang/python-2* )"
RDEPEND=""

src_test() {
	cd tests
	python2 run_tests.py || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
