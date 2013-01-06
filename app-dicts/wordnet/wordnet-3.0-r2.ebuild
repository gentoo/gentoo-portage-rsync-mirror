# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/wordnet/wordnet-3.0-r2.ebuild,v 1.6 2012/05/31 03:36:03 zmedico Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="A lexical database for the English language"
HOMEPAGE="http://wordnet.princeton.edu/"
SRC_URI="ftp://ftp.cogsci.princeton.edu/pub/wordnet/${PV}/WordNet-${PV}.tar.gz
		mirror://gentoo/${P}-patchset-1.tar.bz2"
LICENSE="Princeton"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc"

# In contrast to what the configure script seems to imply, Tcl/Tk is NOT optional.
# cf. bug 163478 for details. (Yes, it's about 2.1 but it's still the same here.)
DEPEND="dev-lang/tcl
		dev-lang/tk"
RDEPEND="${DEPEND}"

S="${WORKDIR}/WordNet-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Don't install into PREFIX/dict but PREFIX/share/wordnet/dict
	epatch "${WORKDIR}/${P}-dict-location.patch"
	# Fixes bug 130024, make an additional shared lib
	epatch "${WORKDIR}/${P}-shared-lib.patch"
	# Don't install the docs directly into PREFIX/doc but PREFIX/doc/PN
	epatch "${WORKDIR}/${P}-docs-path.patch"
	epatch "${WORKDIR}"/${P}-CVE-2008-3908.patch #211491
	epatch "${WORKDIR}"/${P}-CVE-2008-2149.patch #211491

	# Don't install all the extra docs (html, pdf, ps) without doc USE flag.
	use doc || sed -i -e "s:SUBDIRS =.*:SUBDIRS = man:" doc/Makefile.am

	rm -f configure
	eautoreconf
}

src_compile() {
	append-flags -DUNIX -I"${T}"/usr/include

	PLATFORM=linux WN_ROOT="${T}/usr" \
	WN_DICTDIR="${T}/usr/share/wordnet/dict" \
	WN_MANDIR="${T}/usr/share/man" \
	WN_DOCDIR="${T}/usr/share/doc/wordnet-${PV}" \
	WNHOME="/usr/share/wordnet" \
	econf
	emake -e || die "emake Failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL README || die "dodoc failed"
}
