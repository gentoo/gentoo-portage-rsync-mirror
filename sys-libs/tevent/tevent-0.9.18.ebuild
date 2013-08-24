# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.18.ebuild,v 1.2 2013/08/24 15:40:06 jer Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit waf-utils python

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-libs/talloc-2.0.6[python]"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

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
