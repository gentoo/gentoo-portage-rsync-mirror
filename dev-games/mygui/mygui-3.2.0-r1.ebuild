# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/mygui/mygui-3.2.0-r1.ebuild,v 1.5 2014/03/08 23:17:25 hasufell Exp $

EAPI=5
CMAKE_REMOVE_MODULES="yes"
CMAKE_REMOVE_MODULES_LIST="FindFreetype"
inherit eutils cmake-utils flag-o-matic multilib

MY_PN=MyGUI
MY_P=${MY_PN}_${PV}

DESCRIPTION="A library for creating GUIs for games"
HOMEPAGE="http://mygui.info/"
SRC_URI="mirror://sourceforge/my-gui/${MY_PN}/${MY_P}/${MY_P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc plugins samples static-libs test tools linguas_ru"

RDEPEND="dev-games/ogre:=[freeimage,opengl]
	media-libs/freetype:2
	samples? ( dev-games/ois )
	tools? ( dev-games/ois )"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}
STATIC_BUILD=${WORKDIR}/${P}_build_static

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlinking.patch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-FHS.patch
}

src_configure() {
	use debug && append-cppflags -DDEBUG

	local mycmakeargs=()

	# static configuration
	if use static-libs ; then
		mycmakeargs=( -DMYGUI_STATIC=ON
			-DMYGUI_BUILD_DOCS=OFF
			-DMYGUI_INSTALL_DOCS=OFF
			-DMYGUI_USE_FREETYPE=ON
			$(cmake-utils_use plugins MYGUI_BUILD_PLUGINS)
			-DMYGUI_BUILD_DEMOS=OFF
			-DMYGUI_INSTALL_SAMPLES=OFF
			-DMYGUI_BUILD_TOOLS=OFF
			-DMYGUI_INSTALL_TOOLS=OFF
			-DMYGUI_BUILD_WRAPPER=OFF
			-DMYGUI_RENDERSYSTEM=2 )

		CMAKE_BUILD_DIR=${STATIC_BUILD} cmake-utils_src_configure
		unset mycmakeargs
	fi

	# main configuration
	mycmakeargs=( -DMYGUI_STATIC=OFF
		$(cmake-utils_use doc MYGUI_BUILD_DOCS)
		$(cmake-utils_use doc MYGUI_INSTALL_DOCS)
		-DMYGUI_USE_FREETYPE=ON
		$(cmake-utils_use plugins MYGUI_BUILD_PLUGINS)
		$(cmake-utils_use samples MYGUI_BUILD_DEMOS)
		$(cmake-utils_use samples MYGUI_INSTALL_SAMPLES)
		$(cmake-utils_use tools MYGUI_BUILD_TOOLS)
		$(cmake-utils_use tools MYGUI_INSTALL_TOOLS)
		-DMYGUI_BUILD_WRAPPER=OFF
		-DMYGUI_RENDERSYSTEM=2 )

	if use tools || use samples ; then
		mycmakeargs+=( -DMYGUI_INSTALL_MEDIA=ON )
	else
		mycmakeargs+=( -DMYGUI_INSTALL_MEDIA=OFF )
	fi

	cmake-utils_src_configure
}

src_compile() {
	# build system does not support building static and shared at once,
	# run a double build
	if use static-libs ; then
		CMAKE_BUILD_DIR=${STATIC_BUILD} cmake-utils_src_compile
	fi

	cmake-utils_src_compile

	use doc && emake -C "${CMAKE_BUILD_DIR}"/Docs api-docs
}

src_install() {
	cmake-utils_src_install

	if use static-libs ; then
		find "${STATIC_BUILD}" -name "*.a" \! -name "libCommon.a" -exec dolib.a '{}' \;
		insinto /usr/$(get_libdir)/pkgconfig
		doins "${STATIC_BUILD}"/pkgconfig/MYGUIStatic.pc
	fi

	if use doc ; then
		dohtml -r "${CMAKE_BUILD_DIR}"/Docs/html/*

		if use linguas_ru ; then
			docompress -x /usr/share/doc/${PF}/Papers
			dodoc -r Docs/Papers
		fi
	fi

	# test media not needed at runtime
	rm -rf "${D}"/usr/share/MYGUI/Media/UnitTests
	# wrapper not available for linux, remove related media
	rm -rf "${D}"/usr/share/MYGUI/Media/Wrapper
}

pkg_postinst() {
	einfo
	elog "ogre.cfg and Ogre.log are created as"
	elog "~/mygui-ogre.cfg and ~/mygui-Ogre.log"
	einfo
}
