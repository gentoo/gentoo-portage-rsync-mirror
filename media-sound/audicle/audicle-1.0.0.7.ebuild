# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audicle/audicle-1.0.0.7.ebuild,v 1.2 2012/05/05 08:11:27 mgorny Exp $

EAPI=2
inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A Context-sensitive, On-the-fly Audio Programming Environ/mentality"
HOMEPAGE="http://audicle.cs.princeton.edu/"
SRC_URI="http://audicle.cs.princeton.edu/release/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+alsa jack oss truetype"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	media-libs/libsndfile
	media-libs/freeglut
	virtual/opengl
	virtual/glu
	x11-libs/gtk+:2
	truetype? ( media-libs/ftgl
		media-fonts/corefonts )
	app-admin/eselect-audicle"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.0.0.6-font.patch"
	epatch "${FILESDIR}/${P}-hid-smc.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-const.patch"

	sed -i \
		-e "s@../ftgl_lib/FTGL/include@/usr/include/FTGL@" \
		-e "s@../ftgl_lib/FTGL/mac/build@/usr/lib@" \
		-e "s/gcc -o/\$(CC) -o/" \
		-e "s/-O3 -c/-c \$(CFLAGS)/" \
		src/makefile.{alsa,jack,oss} || die "sed failed"
}

pkg_setup() {
	if ! use alsa && ! use jack && ! use oss; then
		eerror "One of the following USE flags is needed: jack, alsa or oss"
		die "Please set one audio engine type"
	fi
}

compile_backend() {
	backend=$1
	local config
	use truetype && config="USE_FREETYPE_LIBS=1"
	einfo "Compiling against ${backend}"
	cd "${S}/src"
	emake -f "makefile.${backend}" CC=$(tc-getCC) CXX=$(tc-getCXX) LEX=flex \
		YACC=bison ${config} || die "emake failed"
	mv audicle{,-${backend}}
	emake -f makefile clean
}

src_compile() {
	# when compile with athlon or athlon-xp flags
	# audicle crashes on removing a shred with a double free or corruption
	# it happens in Chuck_VM_Stack::shutdown() on the line
	#   SAFE_DELETE_ARRAY( stack );
	replace-cpu-flags athlon athlon-xp i686

	use jack && compile_backend jack
	use alsa && compile_backend alsa
	use oss && compile_backend oss
}

src_install() {
	use jack && dobin src/audicle-jack
	use alsa && dobin src/audicle-alsa
	use oss && dobin src/audicle-oss
	dodoc AUTHORS PROGRAMMER README THANKS TODO VERSIONS
}

pkg_postinst() {
	elog "Audicle now can use many audio engines, so you can specify audio engine"
	elog "with audicle-{jack,alsa,oss}"
	elog "Or you can use 'eselect audicle' to set the audio engine"

	einfo "Calling eselect audicle update..."
	eselect audicle update --if-unset
}
