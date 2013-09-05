# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bootchart2/bootchart2-0.14.5-r1.ebuild,v 1.3 2013/09/05 19:44:51 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit linux-info python-r1 systemd toolchain-funcs

DESCRIPTION="Performance analysis and visualization of the system boot process"
HOMEPAGE="https://github.com/mmeeks/bootchart/"
SRC_URI="mirror://github/mmeeks/bootchart/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="svg test X"

REQUIRED_USE="
	X? ( ${PYTHON_REQUIRED_USE} )
	test? ( X )"

RDEPEND="
	!app-benchmarks/bootchart
	X? (
		dev-python/pycairo[svg?,${PYTHON_USEDEP}]
		dev-python/pygtk
		${PYTHON_DEPS}
		)
	sys-apps/lsb-release"
DEPEND="${PYTHON_DEPS}"

CONFIG_CHECK="~PROC_EVENTS ~TASKSTATS ~TASK_DELAY_ACCT ~TMPFS"

src_prepare() {
	tc-export CC
	sed \
		-e "/^install/s:py-install-compile::g" \
		-e "/^SYSTEMD_UNIT_DIR/s:=.*:= $(systemd_get_unitdir):g" \
		-i Makefile || die
	sed \
		-e '/^EXIT_PROC/s:^.*$:EXIT_PROC="agetty mgetty mingetty":g' \
		-i bootchartd.conf bootchartd.in || die
}

src_test() {
	python_foreach_impl emake test
}

src_install() {
	export NO_PYTHON_COMPILE=1
	export DOCDIR=/usr/share/doc/${PF}
	default

	# Note: LIBDIR is hardcoded as /lib in collector/common.h, so we shouldn't
	# just change it. Since no libraries are installed, /lib is fine.
	keepdir /lib/bootchart/tmpfs

	installation() {
		python_domodule pybootchartgui

		python_optimize "${ED}"/$(python_get_sitedir)
		cp pybootchartgui.py "${T}"/pybootchartgui || die
		python_newscript pybootchartgui.py pybootchartgui
	}
	use X && python_foreach_impl installation

	newinitd "${FILESDIR}"/${PN}.init ${PN}
}

pkg_postinst() {
	elog "If you are using an initrd during boot"
	echo
	elog "please add the init script to your default runlevel"
	elog "rc-update add bootchart2 default"
	echo
}
