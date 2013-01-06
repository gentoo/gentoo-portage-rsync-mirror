# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-pqf/fortune-mod-pqf-6.0.ebuild,v 1.9 2010/12/12 09:53:50 grobian Exp $

DESCRIPTION="Fortune database of Terry Pratchett's Discworld related quotes"
HOMEPAGE="http://www.lspace.org/"
SRC_URI="http://www.ie.lspace.org/ftp-lspace/words/pqf/pqf-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}"/pqf-${PV}
}

src_compile() {
	uniq "pqf-${PV}" | sed 's/^$/\%/g' > pqf
	echo "%" >> pqf
	strfile -r pqf || die
}

src_install() {
	insinto /usr/share/fortune
	doins pqf pqf.dat || die
}
