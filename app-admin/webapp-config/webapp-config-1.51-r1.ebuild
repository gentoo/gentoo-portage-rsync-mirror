# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webapp-config/webapp-config-1.51-r1.ebuild,v 1.1 2013/08/06 11:09:00 blueness Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://sourceforge.net/projects/webapp-config/"
SRC_URI="http://dev.gentoo.org/~blueness/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+portage"

DEPEND="app-text/xmlto"
RDEPEND="portage? ( sys-apps/portage[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${P}-fix-indentation.patch )

python_compile_all() {
	emake -C doc/
}

python_install() {
	# According to this discussion:
	# http://mail.python.org/pipermail/distutils-sig/2004-February/003713.html
	# distutils does not provide for specifying two different script install
	# locations. Since we only install one script here the following should
	# be ok
	distutils-r1_python_install --install-scripts="/usr/sbin"
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /etc/vhosts
	doins config/webapp-config

	keepdir /usr/share/webapps
	keepdir /var/db/webapps

	dodoc AUTHORS
	doman doc/*.[58]
	dohtml doc/*.[58].html
}

python_test() {
	PYTHONPATH="." "${PYTHON}" WebappConfig/tests/dtest.py \
		|| die "Testing failed with ${EPYTHON}"
}

pkg_postinst() {
	elog "Now that you have upgraded webapp-config, you **must** update your"
	elog "config files in /etc/vhosts/webapp-config before you emerge any"
	elog "packages that use webapp-config."
}
