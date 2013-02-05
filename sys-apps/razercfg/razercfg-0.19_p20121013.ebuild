# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/razercfg/razercfg-0.19_p20121013.ebuild,v 1.3 2013/02/05 13:54:50 ssuominen Exp $

EAPI=4

inherit cmake-utils multilib eutils udev

DESCRIPTION="Utility for advanced configuration of Razer mice (DeathAdder, Krait, Lachesis)"

HOMEPAGE="http://bues.ch/cms/hacking/razercfg.html"
EGIT_COMMIT="1416b03a29589dd6ce6ae80d3e80e497cd99282f"
SRC_URI="http://bues.ch/gitweb?p=razer.git;a=snapshot;h=${EGIT_COMMIT};sf=tgz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pm-utils qt4"

RDEPEND="${DEPEND}
	pm-utils? ( sys-power/pm-utils )
	qt4? ( dev-python/PyQt4 )
	dev-lang/python"

DEPEND="${DEPEND}"
S="${WORKDIR}/${PN%cfg}-${EGIT_COMMIT:0:7}"

src_prepare() {
	sed -i \
		-e '/ldconfig/{N;d}' \
		-e '/udevadm control/{N;d}' \
		-e "s:/etc/udev/rules.d/:$(get_udevdir)/rules.d/:" \
		-e 's:01-razer-udev.rules:40-razercfg.rules:' \
		-e "s:/etc/pm/sleep.d:/usr/$(get_libdir)/pm-utils/sleep.d/:" \
		-e 's:50-razer:80razer:' \
		librazer/CMakeLists.txt \
		|| die "sed failed"
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}"/razerd.init.d razerd
	dodoc README razer.conf

	if ! use qt4; then
		rm "${D}"/usr/bin/qrazercfg
	else
		make_desktop_entry qrazercfg "Razer Mouse Settings" mouse "Qt;Settings"
	fi

	use pm-utils || rm "${D}"/usr/$(get_libdir)/pm-utils/sleep.d/80razer
}

pkg_postinst() {
	udevadm control --reload-rules && udevadm trigger --subsystem-match=usb
}
