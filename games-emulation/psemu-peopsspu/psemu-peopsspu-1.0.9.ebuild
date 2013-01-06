# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-peopsspu/psemu-peopsspu-1.0.9.ebuild,v 1.4 2008/02/14 22:59:29 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="P.E.Op.S Sound Emulation (SPU) PSEmu Plugin"
HOMEPAGE="http://sourceforge.net/projects/peops/"
SRC_URI="mirror://sourceforge/peops/PeopsSpu${PV//./}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="alsa oss"

DEPEND="alsa? ( media-libs/alsa-lib )
	=x11-libs/gtk+-1*"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	cd src
	sed -i \
		-e "s:-mpentium -O3 -ffast-math -fomit-frame-pointer:${CFLAGS}:" \
		Makefile \
		|| die "sed Makefile failed"

	cd linuxcfg
	unpack ./spucfg.tar.gz
	emake maintainer-clean || die "distclean linuxcfg"
	rm -f {,src/}Makefile.in aclocal.m4 configure
	edos2unix $(find -name '*.[ch]') *.in
	eautoreconf
}

src_compile() {
	cd src
	if use oss || ! use alsa; then
		emake clean || die "oss clean"
		emake USEALSA=FALSE || die "oss build"
		mv libspu* ..
	fi
	if use alsa ; then
		emake clean || die "alsa clean"
		emake USEALSA=TRUE || die "alsa build"
		mv libspu* ..
	fi

	cd linuxcfg
	econf || die
	emake || die "linuxcfg failed"
	mv src/spucfg src/cfgPeopsOSS
}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libspu* || die "doexe plugins"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPeopsOSS || die "doexe cfg"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins spuPeopsOSS.cfg || die "doins failed"
	dodoc src/*.txt *.txt
	prepgamesdirs
}
