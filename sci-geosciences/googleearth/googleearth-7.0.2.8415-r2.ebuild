# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/googleearth/googleearth-7.0.2.8415-r2.ebuild,v 1.4 2013/08/06 13:25:38 ulm Exp $

EAPI=5

inherit pax-utils eutils unpacker fdo-mime versionator gnome2-utils toolchain-funcs

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
# no upstream versioning, version determined from help/about
# incorrect digest means upstream bumped and thus needs version bump
SRC_URI="x86? ( http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb
			-> GoogleEarthLinux-${PV}_i386.deb )
	amd64? ( http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
			-> GoogleEarthLinux-${PV}_amd64.deb )
	http://dev.gentoo.org/~hasufell/distfiles/googleearth-libexpat-2.1.0-novisibility.tar.xz"
LICENSE="googleearth GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE="+system-mdns system-qt"

GCC_NEEDED="4.2"
QA_PREBUILT="*"

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
		system-qt? (
			>=dev-qt/qtcore-4.5.3:4
			>=dev-qt/qtgui-4.5.3:4
			>=dev-qt/qtwebkit-4.5.3:4
		)
		net-misc/curl
		sci-libs/gdal
		system-mdns? ( sys-auth/nss-mdns )
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
		system-qt? (
			>=app-emulation/emul-linux-x86-qtlibs-20091231-r1
		)
	)
	virtual/ttf-fonts"

DEPEND="dev-util/patchelf"

S=${WORKDIR}/opt/google/earth/free

pkg_nofetch() {
	einfo "Wrong checksum or file size means that Google silently replaced the distfile with a newer version."
	einfo "Note that Gentoo cannot mirror the distfiles due to license reasons, so we have to follow the bump."
	einfo "Please file a version bump bug on http://bugs.gentoo.org (search existing bugs for googleearth first!)."
	einfo "By redigesting the file yourself, you will install a different version than the ebuild says, untested!"
}

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
	# default src_unpack fails with deb2targz installed, also this unpacks the data.tar.lzma as well
	unpack_deb GoogleEarthLinux-${PV}_$(usex amd64 "amd64" "i386").deb

	cd opt/google/earth/free || die

	unpack googleearth-libexpat-2.1.0-novisibility.tar.xz

	if use system-qt; then
		rm -v libQt{Core,Gui,Network,WebKit}.so.4 qt.conf || die
		rm -rv plugins/imageformats || die
	fi
	rm -v libcurl.so.4 || die
	if use system-mdns; then
		rm -v libnss_mdns4_minimal.so.2 || die
	fi

	if use x86; then
		# no 32 bit libs for gdal
		rm -v libgdal.so.1 || die
	fi
}

src_prepare() {
	# bug #262780 is hopefully now solved upstream
#	epatch "${FILESDIR}/decimal-separator.patch"

	# we have no ld-lsb.so.3 symlink
	# thanks to Nathan Phillip Brink <ohnobinki@ohnopublishing.net> for suggesting patchelf
	patchelf --set-interpreter /lib/ld-linux.so.2 ${PN}-bin || die "patchelf failed"

	# Set RPATH for preserve-libs handling (bug #265372).
	local x
	for x in * ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		patchelf --set-rpath '$ORIGIN' "${x}" ||
			die "patchelf failed on ${x}"
	done
	for x in plugins/imageformats/*.so ; do
		[[ -f ${x} ]] || continue
		patchelf --set-rpath /opt/${PN} "${x}" ||
			die "patchelf failed on ${x}"
	done

	epatch "${FILESDIR}"/${P}-desktopfile.patch
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} .

	# install binaries and remove them
	binaries="${PN} ${PN}-bin *.so *.so.*"
	exeinto /opt/${PN}
	doexe ${binaries}
	rm ${binaries} || die

	insinto /usr/share/mime/packages
	doins "${FILESDIR}/${PN}-mimetypes.xml" || die

	domenu google-earth.desktop

	for size in 16 22 24 32 48 64 128 256 ; do
		newicon -s ${size} product_logo_${size}.png google-earth.png
	done

	rm -r product_logo_* xdg-mime xdg-settings google-earth google-earth.desktop || die

	# just copy everything that's left
	cp -pPR * "${ED}"/opt/${PN} || die

	# some files are executable and shouldn't
	fperms -R a-x,a+X /opt/googleearth/resources

	pax-mark -m "${ED}/opt/googleearth/googleearth-bin"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "The system-qt flag is disabled by default due to crashes on startup with system Qt."
	elog "Do not report bugs if you attempt to enable this masked flag."
	elog ""
	elog "When you get a crash starting Google Earth, try adding a file ~./config/Google/GoogleEarthPlus.conf"
	elog "the following options:"
	elog "lastTip = 4"
	elog "enableTips = false"
	elog ""
	elog "In addition, the use of free video drivers may be problems associated with using the Mesa"
	elog "library. In this case, Google Earth 6x likely only works with the Gallium3D variant."
	elog "To select the 32bit graphic library use the command:"
	elog "	eselect mesa list"
	elog "For example, for Radeon R300 (x86):"
	elog "	eselect mesa set r300 2"
	elog "For Intel Q33 (amd64):"
	elog "	eselect mesa set 32bit i965 2"
	elog "You may need to restart X afterwards"

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
