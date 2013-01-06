# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.51-r4.ebuild,v 1.3 2012/09/23 08:49:34 phajdan.jr Exp $

EAPI=2
inherit eutils autotools flag-o-matic toolchain-funcs multilib pax-utils games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="mirror://sourceforge/zsnes/${PN}${PV//./}src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="ao custom-cflags opengl pax_kernel png"

RDEPEND="media-libs/libsdl[audio,video]
	>=sys-libs/zlib-1.2.3-r1
	amd64? ( >=app-emulation/emul-linux-x86-sdl-10.1 )
	ao? ( media-libs/libao )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	dev-lang/nasm
	amd64? ( >=sys-apps/portage-2.1 )"

S=${WORKDIR}/${PN}_${PV//./_}/src

src_prepare() {
	# Fixing compilation without libpng installed
	# Fix bug #186111
	# Fix bug #214697
	# Fix bug #170108
	# Fix bug #260247
	# Fix compability with libpng15 wrt #378735
	# Fix buffer overwrite #257963
	# Fix gcc47 compile #419635
	epatch \
		"${FILESDIR}"/${P}-libpng.patch \
		"${FILESDIR}"/${P}-archopt-july-23-update.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-libao-thread.patch \
		"${FILESDIR}"/${P}-depbuild.patch \
		"${FILESDIR}"/${P}-CC-quotes.patch \
		"${FILESDIR}"/${P}-libpng15.patch \
		"${FILESDIR}"/${P}-buffer.patch \
		"${FILESDIR}"/${P}-gcc47.patch

	sed -i -e '67i#define OF(x) x' zip/zunzip.h || die

	# Remove hardcoded CFLAGS and LDFLAGS
	sed -i \
		-e '/^CFLAGS=.*local/s:-pipe.*:-Wall -I.":' \
		-e '/^LDFLAGS=.*local/d' \
		-e '/\w*CFLAGS=.*fomit/s:-O3.*$STRIP::' \
		configure.in \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	tc-export CC
	use amd64 && multilib_toolchain_setup x86
	use custom-cflags || strip-flags

	append-flags -U_FORTIFY_SOURCE	#257963

	egamesconf \
		$(use_enable ao libao) \
		$(use_enable png libpng) \
		$(use_enable opengl) \
		--disable-debug \
		--disable-cpucheck \
		--enable-release \
		force_arch=no
}

src_compile() {
	emake makefile.dep || die "emake makefile.dep failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin zsnes || die "dogamesbin failed"
	if use pax_kernel; then
		pax-mark m "${D}""${GAMES_BINDIR}"/zsnes || die
	fi
	newman linux/zsnes.1 zsnes.6
	dodoc \
		../docs/{readme.1st,authors.txt,srcinfo.txt,stdards.txt,support.txt,thanks.txt,todo.txt,README.LINUX} \
		../docs/readme.txt/*
	dohtml -r ../docs/readme.htm/*
	make_desktop_entry zsnes ZSNES
	newicon icons/48x48x32.png ${PN}.png
	prepgamesdirs
}
