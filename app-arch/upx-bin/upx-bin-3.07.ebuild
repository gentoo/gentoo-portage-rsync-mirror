# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-bin/upx-bin-3.07.ebuild,v 1.1 2011/01/06 03:21:52 vapier Exp $

MY_P="${PN/-bin}-${PV}"
DESCRIPTION="Ultimate Packer for eXecutables (binary version with proprietary NRV compression)"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="x86? ( http://upx.sourceforge.net/download/${MY_P}-i386_linux.tar.bz2 )
	amd64? ( http://upx.sourceforge.net/download/${MY_P}-amd64_linux.tar.bz2 )
	ppc? ( http://upx.sourceforge.net/download/${MY_P}-powerpc_linux.tar.bz2 )
	arm? ( http://upx.sourceforge.net/download/${MY_P}-armeb_linux.tar.bz2 )
	mips? ( http://upx.sourceforge.net/download/${MY_P}-mipsel_linux.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="!app-arch/upx-ucl"

S=${WORKDIR}

src_install() {
	cd ${MY_P}*
	into /opt
	dobin upx || die
	doman upx.1 || die
	dodoc upx.doc BUGS NEWS README* THANKS TODO
	dohtml upx.html || die
}
