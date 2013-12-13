# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.20.ebuild,v 1.1 2013/12/13 14:05:23 polynomial-c Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit waf-utils python-single-r1

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE=""

RDEPEND=">=sys-libs/talloc-2.0.8[python]
	${PYTHON_DEPS}"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

WAF_BINARY="${S}/buildtools/bin/waf"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	waf-utils_src_install
	python_export PYTHON_SITEDIR
	insinto "${PYTHON_SITEDIR#${EPREFIX}}"
	doins tevent.py
	python_optimize
}
