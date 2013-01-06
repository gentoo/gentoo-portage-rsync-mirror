# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/line6usb/line6usb-0.8.1-r1.ebuild,v 1.3 2012/02/25 06:34:46 robbat2 Exp $

EAPI="2"

inherit linux-mod eutils multilib

DESCRIPTION="Experimental USB driver for Line6 PODs and the Variax workbench."
HOMEPAGE="http://www.tanzband-scream.at/line6/"
SRC_URI="http://www.tanzband-scream.at/line6/download/${P}.tar.bz2
	doc? ( http://www.tanzband-scream.at/line6/driverdocs.pdf )"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
# needs testing/keywording with 2.6 kernels on ~ppc/ppc64 (should work)
IUSE="doc"

CONFIG_CHECK="USB SOUND"
MODULE_NAMES="line6usb(usb:${S}:${S})"
ERROR_PODXTPRO="${P} requires the podxtpro driver to be removed first."

RDEPEND="virtual/modutils
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=media-sound/alsa-headers-1.0.10
	>=media-libs/alsa-lib-1.0.10
	sys-apps/debianutils"

pod_kern_warn() {
	eerror "Kernel config not found..."
	eerror
	eerror "You should decide if you want to use the package kernel"
	eerror "driver or the in-kernel staging driver.  Please configure"
	eerror "and build a kernel, either with or without the in-kernel"
	eerror "Line6 POD driver (under staging drivers).  The current"
	eerror "ebuild driver is one minor version ahead of the in-kernel"
	eerror "driver."
	eerror
}

pkg_setup() {
	if kernel_is lt 2 6 25; then
		eerror "POD support requres a host kernel of 2.6.25 or higher."
		eerror "Please upgrade your kernel..."
		die "kernel version not compatible"
	elif ! linux_config_exists; then
		eerror "Unable to check your kernel for POD driver"
		pod_kern_warn
	elif linux_chkconfig_present LINE6_USB; then
		ewarn "You already have the Line6 staging driver installed."
		ewarn "Ebuild kernel driver will not be installed..."
	else
		elog "Staging driver not found; ebuild kernel driver will be installed..."
		INSTALL_LINE6_MOD="yes"
	fi

	ABI="${KERNEL_ABI}"
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
	check_upgrade
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-kernel-2.6.31-fix.patch

	convert_to_m Makefile

	sed -i \
		-e "s:/lib/modules/\$(shell uname -r)/build:${KERNEL_DIR}:g" \
		-e "s:\$(shell uname -r):${KV_FULL}:g" \
		-e "s:\$(shell pwd):${S}:g" \
		Makefile || die "sed failed!"
}

src_compile() {
	# linux-mod_src_compile doesn't work here
	set_arch_to_kernel
	cd "${S}"
	emake KERNEL_LOCATION="${KERNEL_DIR}" || die "emake failed."
}

src_install() {
	dodir /usr/share/doc/${P} /usr/share/${P}/examples

	if [[ -n ${INSTALL_LINE6_MOD} ]] ; then
		DESTDIR="${D}" make install-only || die "make install failed"
	else
		dobin *.sh *.pl
	fi

	mv "${D}"usr/bin/{aplay.sh,arecord.sh} "${D}"usr/share/${P}/examples/
	# remove some cruft
	rm "${D}"usr/bin/remove_old_podxtpro_driver.sh

	dodoc INSTALL
	if use doc; then
		insinto /usr/share/doc/${P}
		doins "${DISTDIR}"/driverdocs.pdf
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog
	elog "This is not such an experimental driver anymore, and should not"
	elog "cause hair-loss or sterility.  There is a slightly older version"
	elog "now in the kernel source tree under staging drivers.  Feel free"
	elog "to enable it, and this package will only install the utilities"
	elog "if you do.  See the docs and examples for more information."
	elog
}

check_upgrade() {
	local old="podxtpro.${KV_OBJ}"
	local new="line6usb.${KV_OBJ}"
	if [[ -e \
		"/lib/modules/${KV_FULL}/kernel/sound/usb/${old}" ]]; then
		eerror "The previous version of the driver called podxtpro"
		eerror "exists on your system."
		eerror
		eerror "Please completely remove the old driver before trying"
		eerror "to install ${P}."
		eerror
		die "upgrade not possible with existing driver"
	elif [[ -e \
		"/lib/modules/${KV_FULL}/kernel/sound/usb/${new}" ]]; then
		ewarn
		ewarn "Depending on the portage version, collisions can be expected"
		ewarn "(because kernel modules are protected by default).  Use"
		ewarn "FEATURES=-collision-protect emerge ... for this package,"
		ewarn "or remove the old kernel module (${new}) manually first"
		ewarn "from /lib/modules/${KV_FULL}/kernel/sound/usb/"
		ewarn
	fi
}
