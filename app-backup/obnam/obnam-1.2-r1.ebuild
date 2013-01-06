# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/obnam/obnam-1.2-r1.ebuild,v 1.3 2012/11/15 15:28:14 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"
PYTHON_MODNAME="${PN}lib"
MY_P="${PN}_${PV}.orig"

inherit eutils distutils python

DESCRIPTION="A backup program that supports encryption and deduplication"
HOMEPAGE="http://liw.fi/obnam/"
SRC_URI="http://code.liw.fi/debian/pool/main/o/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/cliapp-1.20120630
	dev-python/larch
	dev-python/paramiko
	dev-python/tracing
	>=dev-python/ttystatus-0.19
	"
RDEPEND="${DEPEND}"

# S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}_diff_fix.patch"
	epatch "${FILESDIR}/${P}_man_diff_fix.patch"
}

src_install() {
	distutils_src_install
	rm "${D}"/usr/bin/obnam-{benchmark,viewprof}
	rm "${D}"/usr/share/man/man1/obnam-benchmark*
	insinto /etc
	doins "${FILESDIR}"/obnam.conf
	keepdir /var/log/obnam
}

pkg_postinst() {
	if [[ $REPLACING_VERSIONS < "1.2" ]]; then
		elog "You will need to setup a config file before running obnam for the first time."
		elog "For details, please see the obnam(1) manual page."
		elog "An example file has been installed as /etc/obnam.conf for your convenience."
	fi
}
