# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-engine/foomatic-db-engine-4.0.8.ebuild,v 1.7 2013/08/13 09:40:20 ago Exp $

EAPI="2"

inherit eutils perl-app versionator

DESCRIPTION="Generates ppds out of xml foomatic printer description files"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://www.openprinting.org/download/foomatic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="
	dev-libs/libxml2
	net-print/foomatic-filters"
PDEPEND="net-print/foomatic-db"

src_prepare() {
	epatch \
		"${FILESDIR}"/4.0.7-perl-module.patch \
		"${FILESDIR}"/4.0.7-respect-ldflag.patch
	sed -i -e "s:@LIB_CUPS@:$(cups-config --serverbin):" "${S}"/Makefile.in
}

src_configure() {
	default
	emake defaults || die "emake defaults failed"

	cd lib
	perl-app_src_configure
}

src_compile() {
	emake || die "emake failed"

	cd lib
	perl-app_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	cd lib
	perl-module_src_install
}

src_test() {
	cd lib
	perl-module_src_test
}
