# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.6.3-r1.ebuild,v 1.8 2012/10/14 19:01:13 armin76 Exp $

EAPI=4
inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="A library used to extract metadata from files of arbitrary type"
HOMEPAGE="http://www.gnu.org/software/libextractor/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="ffmpeg gsf gtk pdf qt4" # test

RESTRICT="test"

RDEPEND="app-arch/bzip2
	app-text/iso-codes
	>=dev-libs/glib-2
	media-gfx/exiv2
	media-libs/flac
	media-libs/libmpeg2
	media-libs/libogg
	media-libs/libvorbis
	>=sys-devel/libtool-2.2.6b
	sys-libs/zlib
	virtual/libintl
	ffmpeg? ( >=virtual/ffmpeg-0.10 )
	gsf? ( >=gnome-extra/libgsf-1.14.21 )
	gtk? ( x11-libs/gtk+:2 )
	pdf? ( app-text/poppler[cairo] )
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-svg:4
		)
	!app-crypt/pkcrack
	!sci-biology/glimmer
	!sci-chemistry/pdb-extract"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"
# test? ( app-forensics/zzuf )

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	sed -i \
		-e 's:CODEC_TYPE_VIDEO:AVMEDIA_TYPE_VIDEO:' \
		src/plugins/thumbnailffmpeg_extractor.c || die

	# Missing AC_ARG_ENABLE wrt #415447
	use gtk || { sed -i -e '/min_gtk_version=/s:=.*:=9999:' configure || die; }

	# m4/ax_create_pkgconfig_info.m4 is passing environment LDFLAGS to Libs:
	sed -i -e '/^ax_create_pkgconfig_ldflags=/s:$LDFLAGS ::' configure || die
}

src_configure() {
	local myconf

	use pdf && append-cppflags "$($(tc-getPKG_CONFIG) --cflags-only-I poppler)"

	if use qt4; then
		append-cppflags "$($(tc-getPKG_CONFIG) --cflags-only-I QtGui QtSvg)"
		append-ldflags "$($(tc-getPKG_CONFIG) --libs-only-L QtGui QtSvg)"
	else
		myconf="--without-qt"
	fi

	# Missing AC_ARG_ENABLE wrt #415447. Both because of private _ZTI9MemStream.
	local opt
	for opt in ac_cv_header_poppler_goo_gmem_h ac_cv_lib_poppler__ZTI9MemStream; do
		export ${opt}=$(usex pdf)
	done

	econf \
		--enable-glib \
		$(use_enable gsf) \
		--disable-gnome \
		$(use_enable ffmpeg) \
		${myconf}
}

src_compile() {
	emake -j1
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
