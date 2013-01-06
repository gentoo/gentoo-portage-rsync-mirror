# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/an/an-0.95.3.2.ebuild,v 1.7 2012/09/30 18:12:43 armin76 Exp $

EAPI="2"

inherit eutils toolchain-funcs versionator

DESCRIPTION="Very fast anagram generator with dictionary lookup"
HOMEPAGE="http://packages.debian.org/unstable/games/an"

MY_PV="$(get_version_component_range 1-2)"
DEB_REV="$(get_version_component_range 3-4)"
SRC_URI="
	mirror://debian/pool/main/a/${PN}/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/a/${PN}/${PN}_${MY_PV}-${DEB_REV}.diff.gz
"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE=""

RDEPEND="sys-apps/miscfiles[-minimal]"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	MY_PL="$(replace_version_separator 2 -)"
	epatch "${WORKDIR}"/${PN}_${MY_PV}-${DEB_REV}.diff

	# sys-apps/miscfiles doesn't have /usr/dict/words:
	sed -i README \
		-e 's:/usr/dict/words:/usr/share/dict/words:' \
		|| die "sed README failed"
	sed -i Makefile \
		-e 's|^CC=gcc|#CC=gcc|g' \
		-e 's|^CFLAGS=-O2|CFLAGS := $(CFLAGS)|g' \
		-e 's|$(CC) $(CFLAGS)|$(CC) $(CFLAGS) $(LDFLAGS)|g' \
		-e 's|&& make|\&\& $(MAKE)|g' \
		|| die "sed Makefile failed"
}

src_compile() {
	tc-export CC
	emake LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.6 || die
	dodoc \
		debian/changelog \
		debian/README.Debian \
		DICTIONARY \
		EXAMPLE.ANAGRAMS \
		HINTS \
		README \
		TODO || die
}

pkg_postinst() {
	einfo "Helpful note from an's author:"
	einfo "   If you do not have a dictionary you can obtain one from the"
	einfo "   following site: ftp://ftp.funet.fi/pub/doc/dictionaries/"
	einfo "   You will find a selection of dictionaries in many different"
	einfo "   languages here."
}
