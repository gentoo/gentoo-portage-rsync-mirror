# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/remind/remind-03.01.12.ebuild,v 1.6 2012/07/29 17:18:10 armin76 Exp $

inherit eutils

MY_P=${P/_beta/-BETA-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/products/remind"
SRC_URI="http://www.roaringpenguin.com/files/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="tk"

RDEPEND="tk? ( dev-lang/tk dev-tcltk/tcllib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(MAKE) install:&-nostripped:' "${S}"/Makefile || die
	epatch "${FILESDIR}"/03.01.12-test.patch
}

src_test() {
	if [[ ${EUID} -eq 0 ]] ; then
		ewarn "Testing fails if run as root. Skipping tests."
		return
	fi
	make test || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dobin www/rem2html || die "dobin failed"

	dodoc docs/WHATSNEW examples/defs.rem www/README.* || die "dodoc failed"

	if ! use tk ; then
		rm "${D}"/usr/bin/tkremind "${D}"/usr/share/man/man1/tkremind* \
			"${D}"/usr/bin/cm2rem*  "${D}"/usr/share/man/man1/cm2rem*
	fi

	rm "${S}"/contrib/rem2ics-*/{Makefile,rem2ics.spec} || die
	insinto /usr/share/${PN}
	doins -r contrib/
}
