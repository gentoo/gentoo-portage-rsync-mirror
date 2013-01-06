# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shunit2/shunit2-2.1.5.ebuild,v 1.2 2010/06/26 11:02:00 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Unit-test framework for Bourne-based shell scripts."
HOMEPAGE="http://code.google.com/p/shunit2/wiki/ProjectInfo"
SRC_URI="http://shunit2.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/perl
	net-misc/curl"

src_prepare() {
	epatch "${FILESDIR}"/test.patch
	sed -i -e '/^__SHUNIT_SHELL_FLAGS/s:u::' src/shell/shunit2 || die
}

src_compile() {
	local myconf="build"
	use doc && myconf="${myconf} docs"

	emake ${myconf} || die
}

src_install() {
	if use doc; then
		for DOC in build/{docbook/*,shunit2.html,shunit2_shelldoc.xml}; do
			dodoc ${DOC} || die
			rm ${DOC}
		done
	fi

	dodoc doc/*.txt || die
	dohtml doc/*.html || die

	insinto /usr/share/${PN}
	doins build/* || die
}
