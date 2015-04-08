# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gource/gource-0.43.ebuild,v 1.1 2014/11/26 02:14:54 dlan Exp $

EAPI=5

inherit eutils flag-o-matic versionator

MY_P=${P/_p/-}
MY_P=${MY_P/_/-}
MY_DATE=${PV/*_p}

DESCRIPTION="A software version control visualization tool"
HOMEPAGE="http://code.google.com/p/gource/"
SRC_URI="https://github.com/acaudwell/Gource/releases/download/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/boost-1.46:=[threads(+)]
	>=media-libs/glew-1.5
	>=media-libs/libpng-1.2
	media-libs/libsdl2[video,opengl,X]
	media-libs/sdl2-image[jpeg,png]
	dev-libs/libpcre:3
	dev-libs/tinyxml
	media-fonts/freefont
	media-libs/freetype:2
	media-libs/mesa
	virtual/glu
	virtual/jpeg
	"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
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

src_configure() {
	# fix bug #386525
	# this enable gource to be compiled against dev-libs/tinyxml[stl]
	if has_version dev-libs/tinyxml[stl]; then
		append-cppflags -DTIXML_USE_STL;
	fi
	econf \
		--enable-ttf-font-dir=/usr/share/fonts/freefont/ \
		--with-tinyxml
}

DOCS=( README ChangeLog THANKS )
