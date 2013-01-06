# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gsm-receiver/gsm-receiver-9999.ebuild,v 1.1 2012/08/12 18:44:18 chithanh Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit autotools git-2 python

DESCRIPTION="GSM receiver block from the airprobe suite"
HOMEPAGE="https://svn.berlin.ccc.de/projects/airprobe/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-libs/libosmocore
	net-wireless/gnuradio"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

EGIT_REPO_URI="git://git.gnumonks.org/airprobe.git"
EGIT_SOURCEDIR="${S}"
S+=/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -q -r 2 "${S}"
	eautoreconf
}

src_configure() {
	# fails to create .deps directory without dependency tracking
	econf --enable-dependency-tracking
}

src_install() {
	default

	dobin src/python/*.py
	insinto /usr/share/doc/${PF}/examples
	doins src/python/{cfile,*.sh}
}
