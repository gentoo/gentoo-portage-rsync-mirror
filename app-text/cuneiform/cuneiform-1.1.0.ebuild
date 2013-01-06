# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cuneiform/cuneiform-1.1.0.ebuild,v 1.1 2011/04/29 09:11:06 pva Exp $

EAPI="4"
inherit cmake-utils versionator

PV_MAJ=$(get_version_component_range 1-2)
MY_P=${PN}-linux-${PV}

DESCRIPTION="An enterprise quality optical character recognition (OCR) engine by Cognitive Technologies"
HOMEPAGE="https://launchpad.net/cuneiform-linux"
SRC_URI="http://launchpad.net/${PN}-linux/${PV_MAJ}/${PV_MAJ}/+download/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug +imagemagick"

RDEPEND="imagemagick? ( media-gfx/imagemagick )"
DEPEND=">=dev-util/cmake-2.6.2
	${RDEPEND}"

DOCS="readme.txt"

S=${WORKDIR}/${MY_P}

src_prepare(){
	# respect LDFLAGS
	sed -i 's:\(set[(]CMAKE_SHARED_LINKER_FLAGS "[^"]*\):\1 $ENV{LDFLAGS}:' \
		"${S}/cuneiform_src/CMakeLists.txt" || die "failed to sed for LDFLAGS"
	# Fix automagic dependencies / linking
	if ! use imagemagick; then
		sed -i "s:find_package(ImageMagick COMPONENTS Magick++):#DONOTFIND:" \
			"${S}/cuneiform_src/CMakeLists.txt" \
		|| die "Sed for ImageMagick automagic dependency failed."
	fi
}
