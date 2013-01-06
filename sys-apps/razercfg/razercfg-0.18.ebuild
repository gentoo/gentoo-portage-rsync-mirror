# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/razercfg/razercfg-0.18.ebuild,v 1.1 2012/08/25 18:18:17 joker Exp $

EAPI=4

inherit cmake-utils multilib eutils

DESCRIPTION="Utility for advanced configuration of Razer mice (DeathAdder, Krait, Lachesis)"

HOMEPAGE="http://bues.ch/cms/hacking/razercfg.html"
SRC_URI="http://bues.ch/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pm-utils qt4"

RDEPEND="${DEPEND}
	pm-utils? ( sys-power/pm-utils )
	qt4? ( dev-python/PyQt4 )
	dev-lang/python"

DEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/ldconfig/{N;d}' \
		-e '/udevadm control/{N;d}' \
		-e "s:/etc/udev/rules.d/:/$(get_libdir)/udev/rules.d/:" \
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
