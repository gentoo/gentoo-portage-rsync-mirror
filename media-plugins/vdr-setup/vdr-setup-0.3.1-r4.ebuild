# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-setup/vdr-setup-0.3.1-r4.ebuild,v 1.3 2012/02/16 17:31:18 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Create Submenus, Configure VDR on OSD"
HOMEPAGE="http://www.vdrtools.de/vdrsetup.html"
SRC_URI="http://www.vdrtools.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0_p2-r7[setup]
		>=dev-libs/tinyxml-2.6.1[stl]"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gcc-4.x.diff"
		"${FILESDIR}/${P}-gentoo.diff"
		"${FILESDIR}/${P}-lang.diff"
		"${FILESDIR}/${P}-timers.diff"
		"${FILESDIR}/${P}-vdr-1.5.0.diff"
		"${FILESDIR}/090-${P}_extern-tinyxml.diff" )

LANGS="en de"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

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
