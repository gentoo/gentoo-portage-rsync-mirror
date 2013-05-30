# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gr-osmosdr/gr-osmosdr-0.0.1.ebuild,v 1.1 2013/05/30 22:13:39 chithanh Exp $

EAPI=5
PYTHON_DEPEND="2"

inherit cmake-utils python

DESCRIPTION="GNU Radio source block for OsmoSDR and rtlsdr"
HOMEPAGE="http://sdr.osmocom.org/"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
else
	SRC_URI="mirror://gentoo/${P}.tar.xz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/boost
	<net-wireless/gnuradio-3.7:0=
	net-wireless/rtl-sdr"
DEPEND="${RDEPEND}
	dev-python/cheetah"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -q -r 2 "${S}"
}
