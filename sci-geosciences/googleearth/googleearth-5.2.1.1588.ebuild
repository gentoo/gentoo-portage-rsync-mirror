# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/googleearth/googleearth-5.2.1.1588.ebuild,v 1.9 2013/08/06 13:25:38 ulm Exp $

EAPI=2

inherit eutils unpacker fdo-mime versionator toolchain-funcs

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
# no upstream versioning, version determined from help/about
# incorrect digest means upstream bumped and thus needs version bump
SRC_URI="http://dl.google.com/earth/client/advanced/previous/GoogleEarthLinux.bin
			-> GoogleEarthLinux-${PV}.bin"

LICENSE="googleearth GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE="mdns-bundled +qt-bundled"

GCC_NEEDED="4.2"

RDEPEND=">=sys-devel/gcc-${GCC_NEEDED}[cxx]
	x86? (
		media-libs/fontconfig
		media-libs/freetype
		virtual/opengl
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXau
		x11-libs/libXdmcp
		sys-libs/zlib
		dev-libs/glib:2
		!qt-bundled? (
			>=dev-qt/qtcore-4.5.3:4
			>=dev-qt/qtgui-4.5.3:4
			>=dev-qt/qtwebkit-4.5.3:4
		)
		net-misc/curl
		sci-libs/gdal
		!mdns-bundled? ( sys-auth/nss-mdns )
	)
	amd64? (
		|| (
			(
				media-libs/fontconfig[abi_x86_32]
				media-libs/freetype[abi_x86_32]
				x11-libs/libICE[abi_x86_32]
				x11-libs/libSM[abi_x86_32]
				x11-libs/libX11[abi_x86_32]
				x11-libs/libXi[abi_x86_32]
				x11-libs/libXext[abi_x86_32]
				x11-libs/libXrender[abi_x86_32]
				x11-libs/libXau[abi_x86_32]
				x11-libs/libXdmcp[abi_x86_32]
			)
			>=app-emulation/emul-linux-x86-xlibs-20081109
		)
		>=app-emulation/emul-linux-x86-baselibs-20081109
		app-emulation/emul-linux-x86-opengl
		!qt-bundled? (
			>=app-emulation/emul-linux-x86-qtlibs-20091231-r1
		)
	)
	virtual/ttf-fonts"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Wrong checksum or file size means that Google silently replaced the distfile with a newer version."
	einfo "Note that Gentoo cannot mirror the distfiles due to license reasons, so we have to follow the bump."
	einfo "Please file a version bump bug on http://bugs.gentoo.org (search existing bugs for googleearth first!)."
	einfo "By redigesting the file yourself, you will install a different version than the ebuild says, untested!"
}

QA_TEXTRELS="opt/googleearth/libflightsim.so
opt/googleearth/libwebbrowser.so
opt/googleearth/libinput_plugin.so
opt/googleearth/libIGGfx.so
opt/googleearth/liblayer.so
opt/googleearth/libbase.so
opt/googleearth/libevll.so
opt/googleearth/libmoduleframework.so
opt/googleearth/libcommon_webbrowser.so
opt/googleearth/libbasicingest.so
opt/googleearth/libsgutil.so
opt/googleearth/libnavigate.so
opt/googleearth/librender.so
opt/googleearth/libauth.so
opt/googleearth/libgeobaseutils.so
opt/googleearth/libcommon.so
opt/googleearth/libQtGui.so.4
opt/googleearth/libcommon_platform.so
opt/googleearth/libgoogleearth_free.so
opt/googleearth/libcollada.so
opt/googleearth/libviewsync.so
opt/googleearth/libgps.so
opt/googleearth/libgooglesearch.so
opt/googleearth/plugins/imageformats/libqjpeg.so
opt/googleearth/libmeasure.so
"

pkg_setup() {
	GCC_VER="$(gcc-version)"
	if ! version_is_at_least ${GCC_NEEDED} ${GCC_VER}; then
		ewarn "${PN} needs libraries from gcc-${GCC_NEEDED} or higher to run"
		ewarn "Your active gcc version is only ${GCC_VER}"
		ewarn "Please consult the GCC upgrade guide to set a higher version:"
		ewarn "http://www.gentoo.org/doc/en/gcc-upgrading.xml"
	fi
}

src_unpack() {
	unpack_makeself

	cd "${WORKDIR}"/bin || die
	unpack ./../${PN}-linux-x86.tar

	mkdir "${WORKDIR}"/data && cd "${WORKDIR}"/data || die
	unpack ./../${PN}-data.tar

	cd "${WORKDIR}"/bin || die

	if ! use qt-bundled; then
		rm -v libQt{Core,Gui,Network,WebKit}.so.4 ../data/qt.conf || die
		rm -frv ../data/plugins/imageformats || die
	fi
	rm -v libGLU.so.1 libcurl.so.4 || die
	if ! use mdns-bundled; then
		rm -v libnss_mdns4_minimal.so.2 || die
	fi

	if use x86; then
		# no 32 bit libs for gdal
		rm -v libgdal.so.1 || die
	fi
}

src_prepare() {
	cd "${WORKDIR}"/bin || die
	# bug #262780
	epatch "${FILESDIR}/decimal-separator.patch"

	# make the postinst script only create the files; it's  installation
	# are too complicated and inserting them ourselves is easier than
	# hacking around it
	sed -i -e 's:$SETUP_INSTALLPATH/::' \
		-e 's:$SETUP_INSTALLPATH:1:' \
		-e "s:^xdg-desktop-icon.*$::" \
		-e "s:^xdg-desktop-menu.*$::" \
		-e "s:^xdg-mime.*$::" "${WORKDIR}"/postinstall.sh || die
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} . || die "make_wrapper failed"
	./postinstall.sh
	insinto /usr/share/mime/packages
	doins ${PN}-mimetypes.xml || die
	domenu Google-${PN}.desktop || die
	doicon ${PN}-icon.png || die
	dodoc README.linux || die

	cd bin || die
	exeinto /opt/${PN}
	doexe * || die

	cp -pPR "${WORKDIR}"/data/* "${D}"/opt/${PN} || die
	fowners -R root:root /opt/${PN}
	fperms -R a-x,a+X /opt/googleearth/resources
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	elog "The qt-bundled flag is now enabled by default due to crashes on startup with system Qt."
	elog "Testing and reporting outcome with/without the flag is welcome (bug #319813)."
	elog "If it crashes in both cases, put this version in your package.mask and revert to the stable 5.1.*"
}
