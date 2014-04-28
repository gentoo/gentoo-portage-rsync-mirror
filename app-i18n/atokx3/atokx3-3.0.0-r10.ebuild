# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/atokx3/atokx3-3.0.0-r10.ebuild,v 1.1 2014/04/28 00:17:22 naota Exp $

EAPI="3"

inherit cdrom eutils gnome2-utils multilib

MY_UPDATE_P="${PN}up2"
MY_UPDATE_GTK="${PN}gtk216"
MY_ZIPCODE_P="a20y1311lx"

DESCRIPTION="ATOK X3 for Linux - The most famous Japanese Input Method Engine"
HOMEPAGE="http://www.justsystems.com/jp/products/atok_linux/"
SRC_URI="http://www3.justsystem.co.jp/download/atok/up/lin/${MY_UPDATE_P}.tar.gz
	http://www3.justsystem.co.jp/download/atok/up/lin/${MY_UPDATE_GTK}.tar.gz
	http://www3.justsystem.co.jp/download/zipcode/up/lin/${MY_ZIPCODE_P}.tgz"

LICENSE="ATOK MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="multilib"

RESTRICT="strip mirror"

# emul-linux-x86-baselibs-20121202 is required because some libraries depends on /lib32/libudev.so.0
RDEPEND="!app-i18n/atokx2
	!dev-libs/libiiimcf
	!dev-libs/csconv
	!app-i18n/iiimgcf
	!dev-libs/libiiimp
	!app-i18n/iiimsf
	!app-i18n/iiimxcf
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libxml2:2
	media-libs/fontconfig
	media-libs/libpng
	sys-apps/tcp-wrappers
	virtual/pam
	x11-libs/cairo
	>=x11-libs/gtk+-2.4.13:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/pangox-compat
	multilib? (
		=app-emulation/emul-linux-x86-baselibs-20140406-r1
		app-emulation/emul-linux-x86-gtklibs
		|| (
			(
				media-libs/fontconfig[abi_x86_32]
				x11-libs/libICE[abi_x86_32]
				x11-libs/libSM[abi_x86_32]
				x11-libs/libXcomposite[abi_x86_32]
				x11-libs/libXcursor[abi_x86_32]
				x11-libs/libXdamage[abi_x86_32]
				x11-libs/libXext[abi_x86_32]
				x11-libs/libXfixes[abi_x86_32]
				x11-libs/libXft[abi_x86_32]
				x11-libs/libXi[abi_x86_32]
				x11-libs/libXrandr[abi_x86_32]
				x11-libs/libXrender[abi_x86_32]
				x11-libs/libXxf86vm[abi_x86_32]
			)
			app-emulation/emul-linux-x86-xlibs
		)
	)"

QA_PREBUILT="opt/atokx3/lib/server/*
	opt/atokx3/lib/client/xaux/*
	opt/atokx3/lib/client/*
	opt/atokx3/bin/*
	usr/libexec/*
	usr/bin/*
	usr/$(get_libdir)/*
	usr/$(get_libdir)/gtk-2.0/immodules/*
	usr/$(get_libdir)/iiim/le/atokx3/64/*
	usr/$(ABI=x86 get_libdir)/*
	usr/$(ABI=x86 get_libdir)/gtk-2.0/immodules/*
	usr/$(ABI=x86 get_libdir)/iiim/*
	usr/$(ABI=x86 get_libdir)/iiim/le/atokx3/*"

EMULTILIB_PKG="true"

S="${WORKDIR}"

pkg_setup() {
	if ! cdrom_get_cds atokx3index ; then
		die "Please mount ATOK for Linux CD-ROM or set CD_ROOT variable to the directory containing ATOK X3 for Linux."
	fi
}

src_unpack() {
	local targets="
		IIIMF/iiimf-client-lib-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-gtk-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-protocol-lib-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-server-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-x-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-client-lib-devel-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-protocol-lib-devel-trunk_r3104-js*.i386.tar.gz
		ATOK/atokx-20.0-*.0.0.i386.tar.gz"
	#	IIIMF/iiimf-properties-trunk_r3104-js*.i386.tar.gz
	#	IIIMF/iiimf-docs-trunk_r3104-js*.i386.tar.gz
	#	IIIMF/iiimf-notuse-trunk_r3104-js*.i386.tar.gz

	if use amd64 ; then
		targets="${targets}
			IIIMF/iiimf-client-lib-64-trunk_r3104-js*.x86_64.tar.gz
			IIIMF/iiimf-gtk-64-trunk_r3104-js*.x86_64.tar.gz
			IIIMF/iiimf-protocol-lib-64-trunk_r3104-js*.x86_64.tar.gz
			ATOK/atokx-64-20.0-*.0.0.x86_64.tar.gz"
		#	IIIMF/iiimf-client-lib-devel-64-trunk_r3104-js*.x86_64.tar.gz
		#	IIIMF/iiimf-protocol-lib-devel-64-trunk_r3104-js*.x86_64.tar.gz
		#	IIIMF/iiimf-notuse-64-trunk_r3104-js*.x86_64.tar.gz
	fi

	targets="${targets} ATOK/atokxup-20.0-*.0.0.i386.tar.gz"

	unpack ${MY_UPDATE_P}.tar.gz

	for i in ${targets} ; do
		if [ -f "${S}"/${MY_UPDATE_P}/bin/${i} ] ; then
			einfo "unpack" $(basename "${S}"/${MY_UPDATE_P}/bin/${i})
			tar xzf "${S}"/${MY_UPDATE_P}/bin/${i} || die "Failed to unpack ${i}"
		elif [ -f "${CDROM_ROOT}"/bin/tarball/${i} ] ; then
			einfo "unpack" $(basename "${CDROM_ROOT}"/bin/tarball/${i})
			tar xzf "${CDROM_ROOT}"/bin/tarball/${i} || die "Failed to unpack ${i}"
		else
			eerror "${i} not found."
			die "${i} not found."
		fi
	done
	unpack ${MY_UPDATE_GTK}.tar.gz
	unpack ${MY_ZIPCODE_P}.tgz
}

src_prepare() {
	if use amd64 ; then
		local lib32="$(ABI=x86 get_libdir)"
		local lib64="$(get_libdir)"
		if [ "lib" != "${lib32}" ] ; then
			mv usr/lib "usr/${lib32}" || die
		fi
		if [ "lib64" != "${lib64}" ] ; then
			mv usr/lib64 "usr/${lib64}" || die
		fi
		mkdir -p "usr/${lib64}/iiim/le/atokx3" || die
		mv "usr/${lib32}/iiim/le/atokx3/64" "usr/${lib64}/iiim/le/atokx3/64" || die
		rm "usr/${lib32}/iiim/le/atokx3/amd64" || die
		sed -e "s:/usr/lib:/usr/${lib64}:" \
			"usr/${lib32}/libiiimcf.la" > "usr/${lib64}/libiiimcf.la" || die
		sed -e "s:/usr/lib:/usr/${lib64}:" \
			"usr/${lib32}/libiiimp.la" > "usr/${lib64}/libiiimp.la" || die
		sed -i -e "s:/usr/lib:/usr/${lib32}:" "usr/${lib32}/libiiimcf.la" || die
		sed -i -e "s:/usr/lib:/usr/${lib32}:" "usr/${lib32}/libiiimp.la" || die
	fi
}

src_install() {
	dodoc "${MY_UPDATE_P}/README_UP2.txt" || die
	rm -rf "${MY_UPDATE_P}"

	cp -dpR * "${ED}" || die

	# amd64 hack
	if use amd64 ; then
		local lib32="$(ABI=x86 get_libdir)"
		local lib64="$(get_libdir)"
		if [ "${lib32}" != "${lib64}" ] ; then
			for f in xiiimp.so xiiimp.a iiim-xbe xiiimp.so.2 xiiimp.so.2.0.0 iiimd-watchdog xiiimp.la ; do
				dosym "${EPREFIX}/usr/${lib32}/iiim/${f}" "/usr/${lib64}/iiim/${f}" || die
			done
			for f in atokx3aux.so atokx3.so ; do
				dosym "${EPREFIX}/usr/${lib32}/iiim/le/atokx3/${f}" "/usr/${lib64}/iiim/le/atokx3/${f}" || die
			done
			dosym "${EPREFIX}/usr/${lib64}/iiim/le/atokx3/64" /usr/"${lib32}"/iiim/le/atokx3/64 || die
			dosym "${EPREFIX}/usr/${lib64}/iiim/le/atokx3/64" /usr/"${lib32}"/iiim/le/atokx3/amd64 || die
		fi
	fi

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-iiimf" > "${T}/iiimf.conf" || die
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/iiimf.conf" || die

	dodoc "${CDROM_ROOT}"/doc/atok.pdf || die
	dohtml "${CDROM_ROOT}"/readme.html || die
}

pkg_preinst() {
	# bug #343325
	if use amd64 && has_multilib_profile && [ -L "${EPREFIX}/usr/$(get_libdir)/iiim" ] ; then
		rm -f "${EPREFIX}/usr/$(get_libdir)/iiim"
	fi
}

pkg_postinst() {
	elog
	elog "To use ATOK for Linux, you need to add following to .xinitrc or .xprofile:"
	elog
	elog ". /opt/atokx3/bin/atokx3start.sh"
	elog
	gnome2_query_immodules_gtk2
}

pkg_postrm() {
	gnome2_query_immodules_gtk2
}
