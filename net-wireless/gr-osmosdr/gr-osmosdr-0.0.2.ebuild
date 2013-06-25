# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gr-osmosdr/gr-osmosdr-0.0.2.ebuild,v 1.4 2013/06/25 13:32:01 chithanh Exp $

EAPI=5
PYTHON_DEPEND="python? 2"

inherit cmake-utils python

DESCRIPTION="GNU Radio source block for OsmoSDR and rtlsdr and hackrf"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/GrOsmoSDR"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE="fcd hackrf iqbalance python rtlsdr uhd"
#IUSE="fcd hackrf iqbalance osmosdr python rtlsdr uhd"

#	osmosdr? ( net-libs/libosmosdr:= )
RDEPEND="<net-wireless/gnuradio-3.7_rc:0=[fcd?]
	hackrf? ( net-libs/libhackrf:= )
	iqbalance? ( net-wireless/gr-iqbal:= )
	rtlsdr? ( net-wireless/rtl-sdr:= )
	uhd? ( net-wireless/uhd:= )"
DEPEND="${RDEPEND}
	dev-python/cheetah"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -q -r 2 "${S}"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DEFAULT=OFF
		$(cmake-utils_use_enable fcd)
		$(cmake-utils_use_enable hackrf)
		$(cmake-utils_use_enable iqbalance)
		$(cmake-utils_use_enable python)
		$(cmake-utils_use_enable rtlsdr RTL)
		$(cmake-utils_use_enable uhd)
	)
#		$(cmake-utils_use_enable osmosdr)

	cmake-utils_src_configure
}

pkg_postinst() {
	if use !rtlsdr && has 0.0.1 ${REPLACING_VERSIONS}; then
		ewarn "RTL-SDR support is no longer enabled by default."
		ewarn "Set USE=\"rtlsdr\" if you need it."
	fi
}
