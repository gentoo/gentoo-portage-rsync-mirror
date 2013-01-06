# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/c-wrapper/c-wrapper-0.6.1.ebuild,v 1.4 2011/09/28 11:21:55 ssuominen Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Foreign function interface for C and Objective-C libraries"
HOMEPAGE="http://homepage.mac.com/naoki.koguro/prog/c-wrapper/"
SRC_URI="http://homepage.mac.com/naoki.koguro/prog/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE="examples"

RDEPEND="dev-scheme/gauche
	virtual/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-system-libffi.diff
	eautoreconf
}

src_test() {
	emake -j1 -s check
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README
	dohtml doc/*

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi
}
