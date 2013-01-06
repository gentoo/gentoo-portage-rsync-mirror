# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/j/j-701-r1.ebuild,v 1.1 2012/11/26 03:56:52 patrick Exp $

EAPI=4
DESCRIPTION="Modern, high-level, general-purpose, high-performance programming language"
HOMEPAGE="http://jsoftware.com"
SRC_URI="http://www.jsoftware.com/download/${PN}${PV}_b_source.tar.gz"

inherit eutils

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/jgplsrc"

src_prepare() {
	sed -i -e 's:make libj >& make.txt:make libj:' bin/build_libj || die
	if use amd64; then
		sed -i -e 's/bits=32/bits=64/' bin/jconfig || die
	fi
}

src_compile() {
	bin/jconfig	|| die
	bin/build_defs 	|| die
	bin/build_libj 	|| die
	bin/build_jconsole || die
}

src_install() {
	# since this appears to use hardcoded relative paths
	# there's no sane way to put it in the normal filesystem hierarchy
	mkdir -p "${D}/opt/j"
	cp -r j/* "${D}/opt/j" || die
	mkdir -p "${D}/usr/bin"
	echo -e "#!/bin/sh\n/opt/j/bin/jconsole" > "${D}/usr/bin/jc"  || die
	chmod +x "${D}/usr/bin/jc"
}
