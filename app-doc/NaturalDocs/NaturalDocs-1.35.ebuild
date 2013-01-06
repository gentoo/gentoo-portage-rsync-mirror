# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/NaturalDocs/NaturalDocs-1.35.ebuild,v 1.8 2008/02/19 17:15:47 dertobi123 Exp $

DESCRIPTION="Extensible, multi-language source code documentation generator"
HOMEPAGE="http://www.naturaldocs.org/"
SRC_URI="mirror://sourceforge/naturaldocs/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	mkdir ${P} || die "could not create directory ${P}"
	cd ${P}
	unzip "${DISTDIR}"/${P}.zip
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# Install Perl script, modules, and other supporting stuff
	insinto /usr/share/${PN}
	doins -r Modules Styles Config Help Info JavaScript
	exeinto /usr/share/${PN}
	doexe ${PN}

	# Symlink the Perl script into /usr/bin
	dodir /usr/bin
	dosym /usr/share/${PN}/${PN} /usr/bin/${PN}

	# Documentation
	dodoc *.txt
	dohtml -r Help/*
}
