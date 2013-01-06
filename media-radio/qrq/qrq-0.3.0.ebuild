# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qrq/qrq-0.3.0.ebuild,v 1.4 2012/02/16 18:09:35 phajdan.jr Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Yet another CW trainer for Linux/Unix"
HOMEPAGE="http://fkurz.net/ham/qrq.html"
SRC_URI="http://fkurz.net/ham/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pulseaudio"

DEPEND="sys-libs/ncurses
	pulseaudio? ( media-sound/pulseaudio )"
RDEPEND="${DEPEND}"

src_prepare() {
	# avoid prestripping of 'qrq' binary
	sed -i -e "s/install -s -m/install -m/" Makefile || die
	sed -i -e "s/CC=gcc/CC=$(tc-getCC)/" Makefile || die
}

src_compile() {
	CONF="USE_PA=NO USE_OSS=YES"
	if use pulseaudio; then
		CONF="USE_PA=YES USE_OSS=NO"
	fi
	emake $CONF
}

src_install() {
	emake $CONF DESTDIR="${D}/usr" install || die
	dodoc AUTHORS ChangeLog README || die
}
