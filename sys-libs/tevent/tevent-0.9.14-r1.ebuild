# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.14-r1.ebuild,v 1.7 2012/09/13 19:08:03 scarabeus Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit waf-utils python

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/python-2.4.2
	>=sys-libs/talloc-2.0.6[python]"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/add-py-file-${PV}.patch
		"${FILESDIR}"/tevent-version.patch )
WAF_BINARY="${S}/buildtools/bin/waf"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	waf-utils_src_install
	insinto $(python_get_sitedir)
	doins tevent.py
}

pkg_postinst() {
	python_mod_optimize tevent.py
}

pkg_postrm() {
	python_mod_cleanup tevent.py
}
