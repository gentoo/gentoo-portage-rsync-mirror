# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-summary/syslog-summary-1.14-r1.ebuild,v 1.1 2014/12/15 05:26:43 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="Summarizes the contents of a syslog log file"
HOMEPAGE="http://github.com/dpaleino/syslog-summary"
SRC_URI="mirror://github/dpaleino/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	python_fix_shebang -f syslog-summary

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
