# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgcore-checks/pkgcore-checks-0.4.14.ebuild,v 1.2 2011/08/06 09:06:39 ferringb Exp $

EAPI="3"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="pkgcore developmental repoman replacement"
HOMEPAGE="http://pkgcore-checks.googlecode.com/"
SRC_URI="http://pkgcore-checks.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/pkgcore-0.5.9
	>=dev-python/snakeoil-0.3.6"
DEPEND="${RDEPEND}"

DOCS="AUTHORS NEWS"
PYTHON_MODNAME="pkgcore_checks"

pkg_setup() {
	# disable snakeoil 2to3 caching...
	unset PY2TO3_CACHEDIR
	python_pkg_setup
}

pkg_postinst() {
	einfo "updating pkgcore plugin cache"
	pplugincache pkgcore_checks.plugins pkgcore.plugins
	distutils_pkg_postinst
}

pkg_postrm() {
	# Careful not to remove this on up/downgrades.
	local sitep="${ROOT}$(python_get_sitedir)"
	if [[ -e "${sitep}/pkgcore_checks/plugins/plugincache2" && ! -e "${sitep}/pkgcore_checks/base.py" ]]; then
		rm "${sitep}/pkgcore_checks/plugins/plugincache2"
	fi
	distutils_pkg_postrm
}
