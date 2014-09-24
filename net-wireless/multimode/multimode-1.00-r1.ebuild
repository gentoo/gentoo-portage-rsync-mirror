# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/multimode/multimode-1.00-r1.ebuild,v 1.3 2014/09/24 05:55:50 zerochaos Exp $

EAPI=5
PYTHON_COMPAT="python2_7"

inherit python-single-r1

DESCRIPTION="multimode radio decoder for rtl-sdr devices using gnuradio"
HOMEPAGE="https://www.cgran.org/browser/projects/multimode/trunk"
LICENSE="BSD"
SLOT="0"
IUSE=""

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://www.cgran.org/svn/projects/multimode/trunk"
	inherit subversion
	KEYWORDS=""
else
	SRC_URI="http://www.sbrac.org/files/${PN}-r${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}"
fi

DEPEND=""
RDEPEND="${DEPEND}
	>=net-wireless/gr-osmosdr-0.0.1
	<net-wireless/gnuradio-3.7:=[grc,utils,${PYTHON_USEDEP}]
	>=net-wireless/rtl-sdr-0.5.0"

src_install() {
	newbin ${PN}.py ${PN}
	insinto $(python_get_sitedir)
	doins ${PN}_helper.py
	insinto /usr/share/${PN}
	doins ${PN}.grc
	python_fix_shebang "${ED}"/usr/bin
}
