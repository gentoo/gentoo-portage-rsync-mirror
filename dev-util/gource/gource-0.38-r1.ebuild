# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gource/gource-0.38-r1.ebuild,v 1.1 2013/01/30 16:19:14 flameeyes Exp $

EAPI=5

inherit eutils autotools flag-o-matic versionator

MY_P=${P/_p/-}
MY_P=${MY_P/_/-}
MY_DATE=${PV/*_p}

DESCRIPTION="A software version control visualization tool"
HOMEPAGE="http://code.google.com/p/gource/"
SRC_URI="http://gource.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-libs/libsdl-1.2.10[video,opengl,X]
	>=media-libs/sdl-image-1.2[jpeg,png]
	dev-libs/libpcre:3
	>=media-libs/libpng-1.2
	virtual/jpeg
	media-libs/mesa
	media-fonts/freefont
	>=media-libs/glew-1.5
	dev-libs/tinyxml
	>=dev-libs/boost-1.46[threads(+)]
	"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	media-libs/freetype:2
	>=media-libs/glm-0.9.3
	"

case ${PV} in
	*_beta*)
		my_v=$(get_version_component_range 1-3)
		my_v=${my_v//_/-}
		S="${WORKDIR}/${PN}-${my_v}" ;;
	*)
		S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)" ;;
esac

src_prepare() {
	epatch "${FILESDIR}/${P}+boost-1.50.patch"
	eautoreconf
}

src_configure() {
	# fix bug #386525
	# this enable gource to be compiled against dev-libs/tinyxml[stl]
	if has_version dev-libs/tinyxml[stl]; then
		append-cppflags -DTIXML_USE_STL;
	fi
	econf --enable-ttf-font-dir=/usr/share/fonts/freefont/ \
		--with-tinyxml
}

DOCS=( README ChangeLog THANKS )
