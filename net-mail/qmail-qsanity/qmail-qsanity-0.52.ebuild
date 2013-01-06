# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-qsanity/qmail-qsanity-0.52.ebuild,v 1.4 2006/02/20 21:08:27 hansmi Exp $

DESCRIPTION="qmail-qsanity checks your queue data structures for internal consistency."
HOMEPAGE="http://www.qmail.org/"
SRC_URI="mirror://qmail/${P}"
LICENSE="as-is"
SLOT="0"
# Should run on all platforms without issue
KEYWORDS="x86 ~ppc ~hppa"
IUSE=""
DEPEND=""
RDEPEND="virtual/qmail dev-lang/perl"
S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${P} ${PN}
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin ${PN}
}
