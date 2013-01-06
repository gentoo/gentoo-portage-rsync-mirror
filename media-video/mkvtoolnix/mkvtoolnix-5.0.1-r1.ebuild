# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-5.0.1-r1.ebuild,v 1.4 2012/07/03 04:51:27 jdhore Exp $

EAPI=4

inherit wxwidgets autotools

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-fbsd"
IUSE="bzip2 debug lzo pch wxwidgets"

RDEPEND="
	>=dev-libs/libebml-1.2.2
	>=media-libs/libmatroska-1.3.0
	>=dev-libs/boost-1.36.0
	dev-libs/expat
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	sys-apps/file
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	lzo? ( dev-libs/lzo )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] )
"
DEPEND="${RDEPEND}
	dev-ruby/rake
"

src_prepare() {
	# Disable automagic curl dep used for online update checking
	sed -i -e '/curl/d' configure.in
	export CURL_CFLAGS="" CURL_LIBS=""

	eautoreconf
}

src_configure() {
	local myconf

	use pch || myconf+=" --disable-precompiled-headers"

	if use wxwidgets ; then
		WX_GTK_VER="2.8"
		need-wxwidgets unicode
		myconf+=" --with-wx-config=${WX_CONFIG}"
	fi

	econf \
		$(use_enable lzo) \
		$(use_enable bzip2 bz2) \
		$(use_enable wxwidgets) \
		$(use_enable debug) \
		--disable-qt \
		${myconf} \
		--docdir=/usr/share/doc/${PF} \
		--with-boost-regex=boost_regex \
		--with-boost-filesystem=boost_filesystem \
		--with-boost-system=boost_system
}

src_compile() {
	rake || die "rake failed"
}

src_install() {
	# Don't run strip while installing stuff, leave to portage the job.
	DESTDIR="${D}" rake install || die

	dodoc AUTHORS ChangeLog README TODO
	doman doc/man/*.1

	docompress -x /usr/share/doc/${PF}/guide
}
