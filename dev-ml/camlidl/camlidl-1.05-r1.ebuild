# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlidl/camlidl-1.05-r1.ebuild,v 1.1 2013/08/27 16:54:54 aballier Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="CamlIDL is a stub code generator for using C/C++ libraries from O'Caml"
HOMEPAGE="http://caml.inria.fr/camlidl/"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"
LICENSE="QPL-1.0 LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/ocaml-3.10.2:=[ocamlopt]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/tests.patch"
	epatch "${FILESDIR}/includes.patch"
}

src_compile() {
	# Use the UNIX makefile
	libdir=`ocamlc -where`
	sed -i -e "s|OCAMLLIB=.*|OCAMLLIB=${libdir}|" config/Makefile.unix
	sed -i -e "s|BINDIR=.*|BINDIR=/usr/bin|" config/Makefile.unix
	ln -s Makefile.unix config/Makefile

	# Make
	emake -j1
}

src_test() {
	einfo "Running tests..."
	cd tests
	emake CCPP="$(tc-getCXX)"
}

src_install() {
	libdir=`ocamlc -where`
	dodir ${libdir}/caml
	dodir /usr/bin
	# Install
	emake BINDIR="${ED}/usr/bin" OCAMLLIB="${ED}${libdir}" install

	# Add package header
	sed -e "s/@VERSION/${P}/g" "${FILESDIR}/META.camlidl" >	"${ED}${libdir}/META.camlidl" || die

	# Documentation
	dodoc README Changes
}
