# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ccal/ccal-0.6-r1.ebuild,v 1.4 2011/01/04 16:50:35 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Curses-based calendar/journal/diary/todo utility"
HOMEPAGE="http://www.jamiehillman.co.uk/ccal/"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	python_convert_shebangs 2 ${P}.py
}

src_install() {
	newbin ${P}.py ${PN} || die "dobin failed"
	dohtml "${FILESDIR}"/instructions.htm || die "dohtml failed"
}

pkg_postinst() {
	echo
	elog "Read /usr/share/doc/${PF}/html/instructions.htm for"
	elog "information on using ccal."
	echo
}
