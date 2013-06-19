# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netsurf/netsurf-3.0.ebuild,v 1.3 2013/06/19 07:26:45 xmw Exp $

EAPI=5

inherit eutils base toolchain-funcs multilib-minimal

DESCRIPTION="a free, open source web browser"
HOMEPAGE="http://www.netsurf-browser.org/"
SRC_URI="http://download.netsurf-browser.org/netsurf/releases/source/${P}-src.tar.gz
	http://xmw.de/mirror/netsurf-fb.modes-example.gz"

LICENSE="GPL-2 MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="+bmp fbcon truetype +gif gstreamer gtk javascript +jpeg +mng pdf-writer
	+png +rosprite +svg +svgtiny +webp fbcon_frontend_able fbcon_frontend_linux
	fbcon_frontend_sdl fbcon_frontend_vnc fbcon_frontend_x"

REQUIRED_USE="|| ( fbcon gtk )
	amd64? ( abi_x86_32? (
		!gstreamer !javascript !pdf-writer svg? ( svgtiny ) !truetype ) )
	fbcon? ( ^^ ( fbcon_frontend_able fbcon_frontend_linux fbcon_frontend_sdl
		fbcon_frontend_vnc fbcon_frontend_x ) )"

RDEPEND="dev-libs/libxml2
	net-misc/curl
	>=dev-libs/libcss-0.2.0[${MULTILIB_USEDEP}]
	>=net-libs/libhubbub-0.2.0[${MULTILIB_USEDEP}]
	bmp? ( >=media-libs/libnsbmp-0.1.0[${MULTILIB_USEDEP}] )
	fbcon? ( >=dev-libs/libnsfb-0.1.0[${MULTILIB_USEDEP}]
		truetype? ( media-fonts/dejavu
			media-libs/freetype )
	)
	gif? ( >=media-libs/libnsgif-0.1.0[${MULTILIB_USEDEP}] )
	gtk? ( dev-libs/glib:2
		gnome-base/libglade:2.0
		media-libs/lcms:0
		x11-libs/gtk+:2
		amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs
				app-emulation/emul-linux-x86-gtklibs ) ) )
	gstreamer? ( media-libs/gstreamer:0.10 )
	javascript? ( dev-lang/spidermonkey:0/mozjs185 )
	jpeg? ( virtual/jpeg
		amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs ) ) )
	mng? ( media-libs/libmng
		amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs ) ) )
	pdf-writer? ( media-libs/libharu )
	png? ( media-libs/libpng
		amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs ) ) )
	svg? ( svgtiny? ( >=media-libs/libsvgtiny-0.1.0[${MULTILIB_USEDEP}] )
		!svgtiny? ( gnome-base/librsvg:2 ) )
	webp? ( >=media-libs/libwebp-0.3.0[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	rosprite? ( >=media-libs/librosprite-0.1.0[${MULTILIB_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${PN}-2.9-conditionally-include-image-headers.patch
	"${FILESDIR}"/${P}-framebuffer-pkgconfig.patch )
DOCS=( fb.modes README Docs/USING-Framebuffer
	Docs/ideas/{cache,css-engine,render-library}.txt )
NETSURF_COMPONENT_TYPE=binary

### future context of netsurf.eclass

NETSURF_BUILDSYSTEM="${NETSURF_BUILDSYSTEM:-buildsystem-1.0}"
NETSURF_COMPONENT_TYPE="${NETSURF_COMPONENT_TYPE:-lib-static lib-shared}"
SRC_URI=${SRC_URI:-http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz}
SRC_URI+="
	http://download.netsurf-browser.org/libs/releases/${NETSURF_BUILDSYSTEM}.tar.gz -> netsurf-${NETSURF_BUILDSYSTEM}.tar.gz"
IUSE+=" debug"
if has lib-static ${NETSURF_COMPONENT_TYPE} ; then
	IUSE+=" static-libs"
fi
if has doc ${IUSE} ; then
	DEPEND+="
	doc? ( app-doc/doxygen )"
fi
DEPEND+="
	virtual/pkgconfig"
pkg_setup(){
	netsurf_src_prepare() {
		base_src_prepare

		multilib_copy_sources
	}

	netsurf_src_configure() {
		netsurf_makeconf=(
			NSSHARED=${WORKDIR}/${NETSURF_BUILDSYSTEM}
			Q=
			HOST_CC="\$(CC)"
			CCOPT=
			CCNOOPT=
			CCDBG=
			LDDBG=
			AR="$(tc-getAR)"
			BUILD=$(usex debug debug release)
			PREFIX="${EROOT}"usr
		)

		multilib-minimal_src_configure
	}

	netsurf_src_compile() {
		multilib-minimal_src_compile "$@"

		if has doc ${USE} ; then
			netsurf_make "$@" docs
		fi
	}

	netsurf_src_test() {
		multilib-minimal_src_test "$@"
	}

	netsurf_src_install() {
		multilib-minimal_src_install "$@"
	}

	multilib_src_configure() {
		sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
			-i Makefile || die
		if [ -f ${PN}.pc.in ] ; then
			sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
				-i ${PN}.pc.in || die
		fi
	}

	netsurf_make() {
		for COMPONENT_TYPE in ${NETSURF_COMPONENT_TYPE} ; do
			if [ "${COMPONENT_TYPE}" == "lib-static" ] ; then
				if ! use static-libs ; then
					continue
				fi
			fi
			emake CC="$(tc-getCC)" LD="$(tc-getLD)" "${netsurf_makeconf[@]}" \
				COMPONENT_TYPE=${COMPONENT_TYPE} "$@"
		done
	}

	multilib_src_compile() {
		netsurf_make "$@"
	}

	multilib_src_test() {
		netsurf_make test "$@"
	}

	multilib_src_install() {
		#DEFAULT_ABI may not be the last.
		#install to clean dir, rename binaries, move everything back
		if [ "${ABI}" != "${DEFAULT_ABI}" ] ; then
			netsurf_make DESTDIR="${D}"${ABI} install "$@"
			if [ "${ABI}" != "${DEFAULT_ABI}" ] ; then
				find "${D}"${ABI}/usr/bin -type f -exec mv {} {}.${ABI} \;
			fi
			mv "${D}"${ABI}/* "${D}" || die
			rmdir "${D}"${ABI} || die
		else
			netsurf_make DESTDIR="${D}" install "$@"
		fi
	}

	multilib_src_install_all() {
		if has doc ${USE} ; then
			dohtml -r build/docs/html/*
		fi
	}
}

src_prepare() {
	sed -e '/CFLAGS \(:\|+\)=/d' \
		-i {,framebuffer/,gtk/}Makefile.defaults || die
	sed -e 's/xml2-config/${PKG_CONFIG} libxml-2.0/g' \
		-i */Makefile.target || die
	sed -e '/CFLAGS/s: -g : :' \
		-i framebuffer/Makefile.target || die

	mv "${WORKDIR}"/netsurf-fb.modes-example fb.modes

	netsurf_src_prepare
}

src_configure() {
	netsurf_src_configure

	netsurf_makeconf+=(
		NETSURF_USE_BMP=$(usex bmp YES NO)
		NETSURF_USE_GIF=$(usex gif YES NO)
		NETSURF_USE_JPEG=$(usex jpeg YES NO)
		NETSURF_USE_PNG=$(usex png YES NO)
		NETSURF_USE_PNG=$(usex png YES NO)
		NETSURF_USE_MNG=$(usex mng YES NO)
		NETSURF_USE_WEBP=$(usex webp YES NO)
		NETSURF_USE_VIDEO=$(usex gstreamer YES NO)
		NETSURF_USE_MOZJS=$(usex javascript YES NO)
		NETSURF_USE_JS=NO
		NETSURF_USE_HARU_PDF=$(usex pdf-writer YES NO)
		NETSURF_USE_NSSVG=$(usex svg $(usex svgtiny YES NO) NO)
		NETSURF_USE_RSVG=$(usex svg $(usex svgtiny NO YES) NO)
		NETSURF_USE_ROSPRITE=$(usex rosprite YES NO)
		PKG_CONFIG=$(tc-getPKG_CONFIG)
		$(usex fbcon_frontend_able  NETSURF_FB_FRONTEND=able  "")
		$(usex fbcon_frontend_linux NETSURF_FB_FRONTEND=linux "")
		$(usex fbcon_frontend_sdl   NETSURF_FB_FRONTEND=sdl   "")
		$(usex fbcon_frontend_vnc   NETSURF_FB_FRONTEND=vnc   "")
		$(usex fbcon_frontend_x     NETSURF_FB_FRONTEND=x     "")
		NETSURF_FB_FONTLIB=$(usex truetype freetype internal)
		NETSURF_FB_FONTPATH=${EROOT}usr/share/fonts/dejavu
		TARGET=dummy
	)
}

src_compile() {
	if use fbcon ; then
		netsurf_makeconf=( "${netsurf_makeconf[@]/TARGET=*/TARGET=framebuffer}" )
		netsurf_src_compile
	fi
	if use gtk ; then
		netsurf_makeconf=( "${netsurf_makeconf[@]/TARGET=*/TARGET=gtk}" )
		netsurf_src_compile
	fi
}

src_install() {
	sed -e '1iexit;' \
		-i "${WORKDIR}"/*/utils/git-testament.pl || die

	if use fbcon ; then
		netsurf_makeconf=( "${netsurf_makeconf[@]/TARGET=*/TARGET=framebuffer}" )
		netsurf_src_install
		elog "framebuffer binary has been installed as netsurf-fb"
		mv -v "${ED}"usr/bin/netsurf{,-fb} || die
		make_desktop_entry "${EROOT}"usr/bin/netsurf-gtk NetSurf-gtk netsurf "Network;WebBrowser"
	
		elog "In order to setup the framebuffer console, netsurf needs an /etc/fb.modes"
		elog "You can use an example from /usr/share/doc/${PF}/fb.modes.* (bug 427092)."
		elog "Please make /etc/input/mice readable to the account using netsurf-fb."
		elog "Either use chmod a+r /etc/input/mice (security!!!) or use an group."
	fi
	if use gtk ; then
		netsurf_makeconf=( "${netsurf_makeconf[@]/TARGET=*/TARGET=gtk}" )
		netsurf_src_install
		elog "netsurf gtk version has been installed as netsurf-gtk"
		mv -v "${ED}"/usr/bin/netsurf{,-gtk} || die
		make_desktop_entry "${EROOT}"usr/bin/netsurf-fb NetSurf-framebuffer netsurf "Network;WebBrowser"
	fi
	insinto /usr/share/pixmaps
	doins gtk/res/netsurf.xpm

}
