# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/wordnet/wordnet-3.0-r3.ebuild,v 1.7 2015/03/25 08:01:51 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic autotools multilib

DESCRIPTION="A lexical database for the English language"
HOMEPAGE="http://wordnet.princeton.edu/"
SRC_URI="ftp://ftp.cogsci.princeton.edu/pub/wordnet/${PV}/WordNet-${PV}.tar.gz
		mirror://gentoo/${P}-patchset-1.tar.bz2"
LICENSE="Princeton"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="doc"

# In contrast to what the configure script seems to imply, Tcl/Tk is NOT optional.
# cf. bug 163478 for details. (Yes, it's about 2.1 but it's still the same here.)
DEPEND="
	dev-lang/tcl:0
	dev-lang/tk:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/WordNet-${PV}"

src_prepare() {
	# Don't install into PREFIX/dict but PREFIX/share/wordnet/dict
	epatch "${WORKDIR}/${P}-dict-location.patch"
	# Fixes bug 130024, make an additional shared lib
	epatch "${WORKDIR}/${P}-shared-lib.patch"
	# Don't install the docs directly into PREFIX/doc but PREFIX/doc/PN
	epatch "${WORKDIR}/${P}-docs-path.patch"
	epatch "${WORKDIR}"/${P}-CVE-2008-3908.patch #211491
	epatch "${WORKDIR}"/${P}-CVE-2008-2149.patch #211491

	epatch "${FILESDIR}"/${P}-tcl8.6.patch

	# Don't install all the extra docs (html, pdf, ps) without doc USE flag.
	use doc || sed -i -e "s:SUBDIRS =.*:SUBDIRS = man:" doc/Makefile.am

	# Drop installation of OLD tk.h headers #255590
	sed '/^SUBDIRS/d' -i include/Makefile.am
	sed 's: include/tk/Makefile::' -i configure.ac
	rm -rf include/tk/

	rm -f configure
	eautoreconf
}

src_configure() {
	append-cppflags -DUNIX -I"${T}"/usr/include

	PLATFORM=linux WN_ROOT="${T}/usr" \
	WN_DICTDIR="${T}/usr/share/wordnet/dict" \
	WN_MANDIR="${T}/usr/share/man" \
	WN_DOCDIR="${T}/usr/share/doc/wordnet-${PV}" \
	WNHOME="${EPREFIX}/usr/share/wordnet" \
	econf \
		--with-tcl="${EPREFIX}"/usr/$(get_libdir) \
		--with-tk="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	emake -e || die "emake Failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL README || die "dodoc failed"
}
