# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-gt-x820/iscan-plugin-gt-x820-2.1.2.1.ebuild,v 1.2 2012/10/17 23:44:36 flameeyes Exp $

EAPI="4"

inherit rpm versionator multilib

MY_PV="$(get_version_component_range 1-3)"
MY_PVR="$(replace_version_separator 3 -)"

DESCRIPTION="Epson Perfection V500 scanner plugin for SANE 'epkowa' backend."
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="
	x86? ( http://linux.avasys.jp/drivers/iscan-plugins/${PN}/${MY_PV}/${PN}-${MY_PVR}.i386.rpm )
	amd64? ( http://linux.avasys.jp/drivers/iscan-plugins/${PN}/${MY_PV}/${PN}-${MY_PVR}.x86_64.rpm )"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

DEPEND=">=media-gfx/iscan-2.21.0
	!!<media-gfx/iscan-plugin-gt-x820-2.1.2.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="
	/opt/iscan/lib/libesintA1.so.2.0.1
	/opt/iscan/lib/libesintA1.so.2
	/opt/iscan/lib/libesintA1.so"

src_configure() { :; }
src_compile() { :; }

src_install() {
	# install scanner firmware
	insinto /usr/share/iscan
	doins "${WORKDIR}"/usr/share/iscan/*

	dodoc usr/share/doc/*/*

	# install scanner plugins
	exeinto /opt/iscan/lib
	doexe "${WORKDIR}/usr/$(get_libdir)/iscan/"*
}

pkg_setup() {
	basecmds=(
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x013a /opt/iscan/lib/libesintA1 /usr/share/iscan/esfwA1.bin"
	)
}

pkg_postinst() {
	elog
	elog "Firmware file esfwA1.bin for Epson Perfection V600"
	elog "has been installed in /usr/share/iscan."
	elog

	# Only register scanner on new installs
	[[ -n ${REPLACING_VERSIONS} ]] && return

	# Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
		elog "New firmware has been registered automatically."
		elog
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	# Only unregister on on uninstall
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}
