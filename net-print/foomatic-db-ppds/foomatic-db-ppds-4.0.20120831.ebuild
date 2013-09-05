# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-4.0.20120831.ebuild,v 1.10 2013/09/05 05:39:30 vapier Exp $

EAPI=4

inherit eutils versionator

MY_P=${PN/-ppds}-$(replace_version_separator 2 '-')

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="
	http://dev.gentoo.org/~jlec/distfiles/${MY_P}.tar.gz
	http://linuxprinting.org/download/foomatic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${PN/-ppds}-$(get_version_component_range 3 ${PV})"

src_prepare() {
	epatch "${FILESDIR}/Makefile.in-4.0.20120117.patch"
}

src_install() {
	default
	rm -v "${ED}"/usr/share/foomatic/xmlschema/{driver,option,printer,types}.xsd || die "Cannot remove duplicates"
}
