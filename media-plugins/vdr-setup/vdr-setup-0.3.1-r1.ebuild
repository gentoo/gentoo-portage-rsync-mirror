# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-setup/vdr-setup-0.3.1-r1.ebuild,v 1.7 2011/10/22 19:00:33 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Create Submenus, Configure VDR on OSD"
HOMEPAGE="http://www.vdrtools.de/vdrsetup.html"
SRC_URI="http://www.vdrtools.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
RDEPEND="${DEPEND}"

S=${WORKDIR}/setup-${PV}

PATCHES=( ${FILESDIR}/${P}-*.diff )

LANGS="en de"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	vdr-plugin_pkg_setup

	local header=/usr/include/vdr/submenu.h
	if [[ -f ${header} ]] && grep -q cSubMenuNode ${header} && [[ -f /usr/share/vdr/setup/menu.c ]]; then
		einfo "Patched vdr found"
	else
		echo
		eerror "Patched VDR needed"
		echo
		local flag="setup"

		ewarn "you need to reemerge VDR with USE=\"${flag}\""
		ewarn
		ewarn "If you did USE=\"${flag}\" emerge vdr"
		ewarn 'and it failed with this message, then try'
		ewarn "\tUSE=\"${flag}\" emerge vdr vdr-setup"

		die "Patched VDR needed"
	fi
}

src_install() {
	vdr-plugin_src_install

	keepdir /etc/vdr/channels.d

	insinto /var/vdr
	newins "${S}"/Examples/sysconfig sysconfig-setup
	fowners vdr:vdr /var/vdr/sysconfig-setup

	local lang
	use linguas_de && lang="de"
	[[ -z ${lang} ]] && lang="en"

	insinto /etc/vdr/plugins/setup
	newins "${FILESDIR}"/vdr-menu.${lang}.xml vdr-menu.xml
	newins "${FILESDIR}"/vdr-setup.${lang}.xml vdr-setup.xml

	insinto /etc/vdr/plugins/setup/help
	doins "${S}"/Examples/help/*.hlp

	chown -R vdr:vdr "${D}"/etc/vdr

	dodoc MANUAL.DE Examples/*.xml
}

pkg_preinst() {
	if [[ ! -L ${ROOT}/etc/vdr/channels.conf ]]; then
		cp "${ROOT}"/etc/vdr/channels.conf "${D}"/etc/vdr/channels.d/channels.conf.bak
		cp "${ROOT}"/etc/vdr/channels.conf "${D}"/etc/vdr/channels.d/channels.conf
		fowners vdr:vdr /etc/vdr/channels.d/{channels.conf,channels.conf.bak}
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "Edit /etc/vdr/plugins/setup/*"
	echo
	eerror "vdr-setup is very sensible on Error's in your setup.conf"
	elog "Best way to fix this: Stop (at first) VDR , move setup.conf to setup.conf.bak"
	elog "and let create VDR a new setup.conf on next Start automatically"
	echo
	ewarn "Setup-Plugin will change the path of your channels.conf"
	elog "You will find a backup copy on /etc/vdr/channels/channels.conf.bak"
	echo
}
