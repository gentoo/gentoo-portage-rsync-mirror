# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/glances/glances-1.7.4.ebuild,v 1.1 2014/03/31 09:49:55 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1 linux-info

MYPN=Glances
MYP=${MYPN}-${PV}

DESCRIPTION="CLI curses based monitoring tool"
HOMEPAGE="https://github.com/nicolargo/glances"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/psutil[${PYTHON_USEDEP}]"

CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASK_DELAY_ACCT ~TASKSTATS"

S="${WORKDIR}/${MYP}"

pkg_setup() {
	linux-info_pkg_setup
}

python_prepare_all() {
	sed -e "s:share/doc/glances:share/doc/${PF}:g" \
		-e "s/'COPYING',//" \
		-e "s:/etc:${EPREFIX}/etc:" \
		-i setup.py || die
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "${PN} can gain additional functionality with following packages:"
		elog "   dev-python/jinja - export statistics to HTML"
		elog "   app-admin/hddtemp - monitor hard drive temperatures"
	fi
}
