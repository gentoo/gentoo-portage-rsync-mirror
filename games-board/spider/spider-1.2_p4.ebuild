# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/spider/spider-1.2_p4.ebuild,v 1.6 2012/12/11 06:34:02 ulm Exp $

EAPI=2
inherit eutils games

MY_P="${P%%_*}"
MY_P="${MY_P/-/_}"
DEB_V="${P##*_p}"

DESCRIPTION="Spider Solitaire"
HOMEPAGE="http://packages.debian.org/stable/games/spider"
SRC_URI="mirror://debian/pool/main/s/spider/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/s/spider/${MY_P}-${DEB_V}.diff.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="athena"

RDEPEND="x11-libs/libXext
	athena? ( x11-libs/libXaw )
	x11-libs/libXmu
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-proto/xproto"

S=${WORKDIR}/${MY_P/_/-}.orig

src_prepare() {
	epatch "${WORKDIR}"/${MY_P}-${DEB_V}.diff
	sed -i \
		-e '/MKDIRHIER/s:/X11::' \
		*Imakefile \
		|| die "sed failed"
	rm Makefile
}

src_configure() {
	imake \
		-DUseInstalled \
		-DSmallCards=NO \
		-DRoundCards \
		$(use athena && echo "-DCompileXAW=YES" || echo "-DCompileXlibOnly=YES") \
		-I/usr/lib/X11/config \
		|| die "imake failed"
	sed -i \
		-e '/CC = /d' \
		-e '/CDEBUGFLAGS = /d' \
		-e '/LDOPTIONS = /s/$/$(LDFLAGS)/' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	emake -j1 \
		DESTDIR="${D}" \
		BINDIR="${GAMES_BINDIR}" \
		MANSUFFIX="6" \
		MANDIR="/usr/share/man/man6" \
		HELPDIR="/usr/share/doc/${PF}" \
		install install.doc install.man \
		|| die "make install failed"

	dodoc README* ChangeLog
	newicon icons/Spider.png ${PN}.png
	make_desktop_entry spider Spider
	prepgamesdirs
}
