# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/toluapp/toluapp-1.0.92.ebuild,v 1.2 2012/11/18 23:28:11 rafaelmartins Exp $

inherit eutils toolchain-funcs

MY_PN=${PN/toluapp/tolua++}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A tool to integrate C/C++ code with Lua."
HOMEPAGE="http://www.codenix.com/~tolua/"
SRC_URI="http://www.codenix.com/~tolua/${MY_P}.tar.bz2"
KEYWORDS="amd64 ppc x86"
LICENSE="MIT"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

RDEPEND=">=dev-lang/lua-5.1.1"
DEPEND="${RDEPEND}
	dev-util/scons
	>=sys-apps/sed-4"

src_compile() {
	echo "## BEGIN gentoo.py

CCFLAGS = ['-I/usr/include/lua', '-O2' ]
LIBS = ['lua', 'dl', 'm']

## END gentoo.py" > ${S}/custom.py

	scons \
		CC=$(tc-getCC) \
		CCFLAGS="${CFLAGS}" \
		LINK=$(tc-getCC) \
		prefix=${D}/usr \
		install || die
}

src_install() {
	dobin bin/tolua++
	dolib.a lib/libtolua++.a
	insinto /usr/include
	doins include/tolua++.h
	dodoc INSTALL README
	dohtml doc/*
}
