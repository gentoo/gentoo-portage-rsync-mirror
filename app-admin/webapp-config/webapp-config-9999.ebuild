# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webapp-config/webapp-config-9999.ebuild,v 1.1 2013/02/18 17:44:32 blueness Exp $

EAPI="5"

# We need to fix 'import md5' for the tests before
# we can be 3.x compat.  Uncomment when done.
#PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} )

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

if [[ ${PV} = 9999* ]]
then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="http://dev.gentoo.org/~blueness/${PN}/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
fi

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://sourceforge.net/projects/webapp-config/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="app-text/xmlto"
RDEPEND=""
PYTHON_MODNAME="WebappConfig"

src_compile() {
	BUILD_DIR="${WORKDIR}/${P}_build"
	distutils-r1_python_compile
	emake -C doc/
}

src_install() {
	python_export_best
	distutils-r1_python_install --install-scripts="/usr/sbin"

	insinto /etc/vhosts
	doins config/webapp-config

	keepdir /usr/share/webapps
	keepdir /var/db/webapps

	dodoc AUTHORS TODO
	doman doc/*.[58]
	dohtml doc/*.[58].html
}

python_test() {
	PYTHONPATH="." "${PYTHON}" WebappConfig/tests/dtest.py \
		|| die "Tests fail with ${EPYTHON}";
}

pkg_postinst() {
	distutils-r1_pkg_postinst

	elog "Now that you have upgraded webapp-config, you **must** update your"
	elog "config files in /etc/vhosts/webapp-config before you emerge any"
	elog "packages that use webapp-config."
}
