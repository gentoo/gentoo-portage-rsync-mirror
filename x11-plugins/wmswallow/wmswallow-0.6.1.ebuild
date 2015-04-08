# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmswallow/wmswallow-0.6.1.ebuild,v 1.11 2014/08/10 20:09:04 slyfox Exp $

EAPI=2
IUSE=""

DESCRIPTION="A dock applet to make any application dockable"
HOMEPAGE="http://burse.uni-hamburg.de/~friedel/software/wmswallow.html"
SRC_URI="http://burse.uni-hamburg.de/~friedel/software/wmswallow/${PN}.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/wmswallow

src_prepare() {
	sed -i "s:\${OBJS} -o:\${OBJS} \${LDFLAGS} -o:" Makefile
}

src_compile() {
	make CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" xfree || die
}

src_install() {
	insinto /usr/bin
	doins wmswallow
	fperms 755 /usr/bin/wmswallow
	dodoc CHANGELOG README README.solaris todo
}
