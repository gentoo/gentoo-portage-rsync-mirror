# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fatrace/fatrace-0.5.ebuild,v 1.3 2014/11/28 13:05:13 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit linux-info python-single-r1 toolchain-funcs

DESCRIPTION="report file access events from all running processes"
HOMEPAGE="https://launchpad.net/fatrace"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="powertop"

RDEPEND="powertop? ( ${PYTHON_DEPS} )"
DEPEND=""

CONFIG_CHECK="~FANOTIFY"

src_prepare() {
	tc-export CC
}

src_install() {
	dosbin fatrace
	use powertop && dosbin power-usage-report

	doman fatrace.1
	dodoc NEWS
}
