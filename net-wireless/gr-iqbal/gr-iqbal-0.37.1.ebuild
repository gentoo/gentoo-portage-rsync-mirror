# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gr-iqbal/gr-iqbal-0.37.1.ebuild,v 1.2 2013/07/15 04:41:30 zerochaos Exp $

EAPI=5
PYTHON_DEPEND="2"

inherit cmake-utils python

DESCRIPTION="gnuradio I/Q balancing"
HOMEPAGE="http://git.osmocom.org/gr-iqbal/"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${PN}-0.37.0.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE=""

RDEPEND=">=net-wireless/gnuradio-3.7_rc:0=
	net-libs/libosmo-dsp:="
DEPEND="${RDEPEND}"

S="${WORKDIR}"/"${PN}"-0.37.0

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -q -r 2 "${S}"
	epatch "${FILESDIR}"/add-pkgconfig-file.patch
}
