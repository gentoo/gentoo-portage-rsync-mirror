# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/y4mscaler/y4mscaler-9.0.ebuild,v 1.7 2008/10/31 12:14:20 aballier Exp $

SRC_URI="http://www.mir.com/DMG/Software/${P}-src.tgz"
DESCRIPTION="A video scaler which operates on YUV4MPEG2 streams, as used by the tools in the MJPEGtools project."
HOMEPAGE="http://www.mir.com/DMG/Software/"
LICENSE="GPL-2"

DEPEND=">=media-video/mjpegtools-1.8.0-r1"

KEYWORDS="amd64 x86"
IUSE=""
SLOT="0"

src_compile() {
	# There's no 'configure' script (yet)
	sed -i -e "s:CPU_OPT =:CPU_OPT = ${CXXFLAGS}:" Makefile
	emake || die
}

src_install() {
	# The program doesn't have an install routine (for now)
	dobin y4mscaler || die
	doman y4mscaler.1 || die
	dodoc ChangeLog README TODO
}
