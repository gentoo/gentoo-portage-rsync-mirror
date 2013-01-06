# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ical/ical-3.0-r1.ebuild,v 1.6 2011/02/10 17:22:25 ssuominen Exp $

EAPI=3
inherit autotools eutils multilib virtualx

DESCRIPTION="Tk-based Calendar program"
HOMEPAGE="http://launchpad.net/ical-tcl"
SRC_URI="http://launchpad.net/ical-tcl/3.x/${PV}/+download/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-newtcl.patch \
		"${FILESDIR}"/${P}-makefile.patch

	sed -i \
		-e 's:8.4 8.3:8.6 8.5 8.4 8.3:g' \
		-e 's:sys/utsname.h limits.h::' \
		configure.in || die

	sed -i \
		-e 's:mkdir:mkdir -p:' \
		-e "/LIBDIR =/s:lib:$(get_libdir):" \
		-e '/MANDIR =/s:man:share/man:' \
		Makefile.in || die

	eautoconf
}

src_compile() {
	emake OPTF="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_test() {
	if [[ ${EUID} != 0 ]]; then
		Xemake check || die
	fi
}

src_install() {
	emake prefix="${D}/usr" install || die

	dodoc ANNOUNCE *README RWMJ-release-notes.txt TODO
	dohtml {.,doc}/*.html

	rm -f "${D}"/usr/$(get_libdir)/ical/v3.0/contrib/README
}
