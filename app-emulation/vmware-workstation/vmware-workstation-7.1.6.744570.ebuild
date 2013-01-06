# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-workstation/vmware-workstation-7.1.6.744570.ebuild,v 1.2 2012/10/29 14:52:38 flameeyes Exp $

EAPI="2"

inherit eutils versionator fdo-mime gnome2-utils vmware-bundle

MY_PN="VMware-Workstation"
MY_PV="$(replace_version_separator 3 - $PV)"
MY_P="${MY_PN}-${MY_PV}"
PV_MINOR=$(get_version_component_range 3)

DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/workstation/"
SRC_URI="
	x86? ( ${MY_P}.i386.bundle )
	amd64? ( ${MY_P}.x86_64.bundle )
	"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="doc vix +vmware-tools"
RESTRICT="fetch mirror strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="dev-cpp/cairomm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm
	dev-cpp/libsexymm
	dev-cpp/pangomm
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libaio
	dev-libs/libsigc++
	dev-libs/libxml2
	=dev-libs/openssl-0.9.8*
	dev-libs/xmlrpc-c
	gnome-base/libgnomecanvas
	gnome-base/libgtop:2
	gnome-base/librsvg:2
	gnome-base/orbit
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libart_lgpl
	=media-libs/libpng-1.2*
	net-misc/curl
	sys-devel/gcc
	sys-fs/fuse
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libgksu
	x11-libs/libICE
	x11-libs/libsexy
	x11-libs/libSM
	>=x11-libs/libview-0.6.6
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
	x11-libs/startup-notification
	x11-themes/hicolor-icon-theme
	!app-emulation/vmware-server
	!app-emulation/vmware-player"
PDEPEND="~app-emulation/vmware-modules-238.${PV_MINOR}
	vmware-tools? ( app-emulation/vmware-tools )"

S=${WORKDIR}
VM_INSTALL_DIR="/opt/vmware"

pkg_nofetch() {
	local bundle

	if use x86; then
		bundle="${MY_P}.i386.bundle"
	elif use amd64; then
		bundle="${MY_P}.x86_64.bundle"
	fi

	einfo "Please download ${bundle}"
	einfo "from ${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" vmware-player-app
	vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" vmware-player-setup
	vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" vmware-workstation
	if use vix; then
		vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" vmware-vix
	fi
}

src_prepare() {
	rm -rf "${S}"/vmware-player-app/bin/vmware-modconfig
	rm -rf "${S}"/vmware-player-app/lib/modules/binary

	# remove superfluous libraries
	ebegin 'Removing superfluous libraries'
	cd vmware-player-app/lib/lib || die
	# exclude OpenSSL from unbundling until the AES-NI patch gets into the tree
	# see http://forums.gentoo.org/viewtopic-t-835867.html
	ldconfig -p | sed 's:^\s\+\([^(]*[^( ]\).*=> /.*$:\1:g;t;d' | fgrep -vx 'libcrypto.so.0.9.8
libssl.so.0.9.8' | xargs -d'\n' -r rm -rf
	cd ../../../vmware-workstation/lib/lib || die
	ldconfig -p | sed 's:^\s\+\([^(]*[^( ]\).*=> /.*$:\1:g;t;d' | fgrep -vx 'libcrypto.so.0.9.8
libssl.so.0.9.8' | xargs -d'\n' -r rm -rf
	eend
}

src_install() {
	local major_minor_revision=$(get_version_component_range 1-3 "${PV}")
	local build=$(get_version_component_range 4 "${PV}")

	cd "${S}"/vmware-player-app

	# install the binaries
	into "${VM_INSTALL_DIR}"
	dobin bin/*
	dosbin sbin/*

	# install the libraries
	insinto "${VM_INSTALL_DIR}"/lib/vmware
	doins -r lib/*

	# install the ancillaries
	insinto /usr
	doins -r share

	# commented out until Portage gets OpenSSL 0.9.8 with AES-NI support
	# see http://forums.gentoo.org/viewtopic-t-835867.html
	## these two libraries do not like to load from /usr/lib*
	#local each ; for each in libcrypto.so.0.9.8 libssl.so.0.9.8 ; do
	#	if [[ ! -f "${VM_INSTALL_DIR}/lib/vmware/lib/${each}" ]] ; then
	#		dosym "/usr/$(get_libdir)/${each}" \
	#			"${VM_INSTALL_DIR}/lib/vmware/lib/${each}/${each}"
	#	fi
	#done

	# install vmware-config
	cd "${S}"/vmware-player-setup
	insinto "${VM_INSTALL_DIR}"/lib/vmware/setup
	doins vmware-config

	# install vmware-workstation
	cd "${S}"/vmware-workstation

	# install the binaries
	into "${VM_INSTALL_DIR}"
	dobin bin/*

	# install the libraries
	insinto "${VM_INSTALL_DIR}"/lib/vmware
	doins -r lib/*

	# install the ancillaries
	insinto /usr
	doins -r share

	# install documentation
	doman man/man1/vmware.1.gz

	if use doc; then
		dodoc doc/open_source_licenses.txt
		dodoc doc/vmware-vmci/samples/*
	fi

	# install vmware-vix
	if use vix; then
		cd "${S}"/vmware-vix

		# install the binary
		into "${VM_INSTALL_DIR}"
		dobin bin/*

		# install the libraries
		insinto "${VM_INSTALL_DIR}"/lib/vmware-vix
		doins -r lib/*

		dosym vmware-vix/libvixAllProducts.so "${VM_INSTALL_DIR}"/lib/libbvixAllProducts.so

		# install headers
		insinto /usr/include/vmware-vix
		doins include/*

		if use doc; then
			dohtml -r doc/*
		fi
	fi

	# create symlinks for the various tools
	local tool ; for tool in vmware vmplayer{,-daemon} \
			vmware-{acetool,gksu,fuseUI,modconfig{,-console},netcfg,tray,unity-helper} ; do
		dosym appLoader "${VM_INSTALL_DIR}"/lib/vmware/bin/"${tool}"
	done
	dosym "${VM_INSTALL_DIR}"/lib/vmware/bin/vmplayer "${VM_INSTALL_DIR}"/bin/vmplayer
	dosym "${VM_INSTALL_DIR}"/lib/vmware/bin/vmware "${VM_INSTALL_DIR}"/bin/vmware

	# fix up permissions
	chmod 0755 "${D}${VM_INSTALL_DIR}"/lib/vmware/{bin/*,lib/wrapper-gtk24.sh,setup/*}
	chmod 04711 "${D}${VM_INSTALL_DIR}"/sbin/vmware-authd
	chmod 04711 "${D}${VM_INSTALL_DIR}"/lib/vmware/bin/vmware-vmx*
	if use vix; then
		chmod 0755 "${D}${VM_INSTALL_DIR}"/lib/vmware-vix/setup/*
	fi

	# create the environment
	local envd="${T}/90vmware"
	cat > "${envd}" <<-EOF
		PATH='${VM_INSTALL_DIR}/bin'
		ROOTPATH='${VM_INSTALL_DIR}/bin'
	EOF
	doenvd "${envd}"

	# create the configuration
	dodir /etc/vmware

	cat > "${D}"/etc/vmware/bootstrap <<-EOF
		BINDIR='${VM_INSTALL_DIR}/bin'
		LIBDIR='${VM_INSTALL_DIR}/lib'
	EOF

	cat > "${D}"/etc/vmware/config <<-EOF
		bindir = "${VM_INSTALL_DIR}/bin"
		libdir = "${VM_INSTALL_DIR}/lib/vmware"
		initscriptdir = "/etc/init.d"
		authd.fullpath = "${VM_INSTALL_DIR}/sbin/vmware-authd"
		gksu.rootMethod = "su"
		VMCI_CONFED = "yes"
		VMBLOCK_CONFED = "yes"
		VSOCK_CONFED = "yes"
		NETWORKING = "yes"
		player.product.version = "${major_minor_revision}"
		product.buildNumber = "${build}"
		product.name = "VMware Workstation"
		workstation.product.version = "${major_minor_revision}"
	EOF

	if use vix; then
		cat >> "${D}"/etc/vmware/config <<-EOF
			vmware.fullpath = "${VM_INSTALL_DIR}/bin/vmware"
			vix.libdir = "${VM_INSTALL_DIR}/lib/vmware-vix"
			vix.config.version = "1"
		EOF
	fi

	# install the init.d script
	local initscript="${T}/vmware.rc"
	sed -e "s:@@BINDIR@@:${VM_INSTALL_DIR}/bin:g" \
		"${FILESDIR}/vmware-7.0.rc" > ${initscript}
	newinitd "${initscript}" vmware

	# fill in variable placeholders
	sed -e "s:@@LIBCONF_DIR@@:${VM_INSTALL_DIR}/lib/vmware/libconf:g" \
		-i "${D}${VM_INSTALL_DIR}"/lib/vmware/libconf/etc/{gtk-2.0/{gdk-pixbuf.loaders,gtk.immodules},pango/pango{.modules,rc}}
	sed -e "s:@@BINARY@@:${VM_INSTALL_DIR}/bin/vmware:g" \
		-i "${D}/usr/share/applications/${PN}.desktop"
	sed -e "s:@@BINARY@@:${VM_INSTALL_DIR}/bin/vmplayer:g" \
		-i "${D}/usr/share/applications/vmware-player.desktop"
	sed -e "s:@@BINARY@@:${VM_INSTALL_DIR}/bin/vmware-netcfg:g" \
		-i "${D}/usr/share/applications/vmware-netcfg.desktop"
}

pkg_config() {
	"${VM_INSTALL_DIR}"/bin/vmware-networks --postinstall ${PN},old,new
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	ewarn "/etc/env.d was updated. Please run:"
	ewarn "env-update && source /etc/profile"
	ewarn ""
	ewarn "Before you can use vmware-player, you must configure a default network setup."
	ewarn "You can do this by running 'emerge --config ${PN}'."
}

pkg_prerm() {
	einfo "Stopping ${PN} for safe unmerge"
	/etc/init.d/vmware stop
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
