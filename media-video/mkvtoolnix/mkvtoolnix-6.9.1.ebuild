# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-6.9.1.ebuild,v 1.1 2014/04/26 09:46:21 radhermit Exp $

EAPI=5
WX_GTK_VER="3.0"
USE_RUBY="ruby19 ruby20 ruby21"
# don't add ruby to RDEPEND
RUBY_OPTIONAL=yes
inherit eutils ruby-ng multilib toolchain-funcs versionator wxwidgets multiprocessing autotools

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug pch qt5 wxwidgets"

RDEPEND="
	>=dev-libs/libebml-1.3.0:=
	>=media-libs/libmatroska-1.4.1:=
	>=dev-libs/boost-1.46.0:=
	dev-libs/pugixml
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	sys-apps/file
	>=sys-devel/gcc-4.6
	sys-libs/zlib
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
	)
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )
"
DEPEND="${RDEPEND}
	|| ( $(ruby_implementations_depend) )
	virtual/pkgconfig
"

# workaround to override ruby-ng
S=${WORKDIR}/${P}

pkg_pretend() {
	# http://bugs.gentoo.org/419257
	local ver=4.6
	local msg="You need at least GCC ${ver}.x for C++11 range-based 'for' and nullptr support."
	if ! version_is_at_least ${ver} $(gcc-version); then
		eerror ${msg}
		die ${msg}
	fi
}

src_unpack() {
	# workaround to override ruby-ng
	default
}

src_prepare() {
	# hack from ruby-ng eclass to determine ruby version to build with
	local ruby_implementations=$(ruby_get_use_implementations)
	export RUBY="$(ruby_implementation_command ${ruby_implementations[0]})"

	epatch "${FILESDIR}"/${PN}-5.8.0-system-pugixml.patch \
		"${FILESDIR}"/${PN}-5.8.0-boost-configure.patch
	eautoreconf
}

src_configure() {
	local myconf

	if use wxwidgets ; then
		need-wxwidgets unicode
		myconf="--with-wx-config=${WX_CONFIG}"
	fi

	econf \
		$(use_enable debug) \
		$(use_enable qt5 qt) \
		$(use_enable wxwidgets) \
		$(usex pch "" --disable-precompiled-headers) \
		${myconf} \
		--disable-optimization \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--with-boost="${EPREFIX}"/usr \
		--with-boost-libdir="${EPREFIX}"/usr/$(get_libdir) \
		--without-curl
}

src_compile() {
	"${RUBY}" ./drake V=1 -j$(makeopts_jobs) || die
}

src_install() {
	DESTDIR="${D}" "${RUBY}" ./drake -j$(makeopts_jobs) install || die

	dodoc AUTHORS ChangeLog README TODO
	doman doc/man/*.1

	use wxwidgets && docompress -x /usr/share/doc/${PF}/guide
}
