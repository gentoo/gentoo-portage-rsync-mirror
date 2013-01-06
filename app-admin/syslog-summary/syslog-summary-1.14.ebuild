# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-summary/syslog-summary-1.14.ebuild,v 1.5 2011/12/18 17:44:35 armin76 Exp $

EAPI=2
PYTHON_DEPEND="2:2.5"

inherit eutils python

DESCRIPTION="Summarizes the contents of a syslog log file."
HOMEPAGE="http://github.com/dpaleino/syslog-summary"
SRC_URI="mirror://github/dpaleino/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 syslog-summary

	# Sadly, the makefile is useless for us.
	rm Makefile || die
}

src_install() {
	dobin syslog-summary || die
	dodoc AUTHORS ChangeLog NEWS README || die
	doman syslog-summary.1 || die

	insinto /etc/syslog-summary
	doins ignore.rules || die
}
