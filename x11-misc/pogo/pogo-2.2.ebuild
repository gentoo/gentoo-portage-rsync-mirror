# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pogo/pogo-2.2.ebuild,v 1.15 2010/11/08 12:42:35 nelchael Exp $

DESCRIPTION="Pogo is a neat launcher program for X"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://m80.dyndns.org/propaganda/pogo/index.shtml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	media-libs/imlib
	virtual/jpeg
	>=sys-apps/sed-4"

src_compile() {
	cp "${FILESDIR}"/Makefile .
	make clean || die "Clean failed"
	for file in `grep -r /usr/local/ *|cut -f1 -d":"|sort|uniq`;do
		sed -i -e "s:/usr/local:/usr/share:g" ${file}
	done
	make all || die "Make failed"
}

src_install() {
	dodoc README
	emake DESTDIR="${D}" install || die
}
