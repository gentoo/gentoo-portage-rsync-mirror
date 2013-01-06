# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.2.5.5.ebuild,v 1.7 2011/09/17 16:50:03 ssuominen Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://stratagus.sourceforge.net/"
SRC_URI="http://launchpad.net/stratagus/trunk/${PV}/+download/stratagus_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="bzip2 debug doc mikmod mng theora vorbis"

RDEPEND="x11-libs/libX11
	virtual/opengl
	>=dev-lang/lua-5
	media-libs/libpng
	media-libs/libsdl[audio,opengl,video]
	bzip2? ( app-arch/bzip2 )
	mikmod? ( media-libs/libmikmod )
	mng? ( media-libs/libmng )
	theora? ( media-libs/libtheora media-libs/libvorbis )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
	sed -i \
		-e 's/-O.*\(-fsigned-char\).*/\1"/' \
		configure.in \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with bzip2) \
		$(use_with mikmod) \
		$(use_with mng) \
		$(use_with theora) \
		$(use_with vorbis)
}
src_compile() {
	emake -j1 || die

	if use doc ; then
		emake doc || die
	fi
}

src_install() {
	dogamesbin stratagus || die "dogamesbin failed"
	dodoc README
	dohtml -r doc/*
	use doc && dohtml -r srcdoc/html/*
	prepgamesdirs
}
