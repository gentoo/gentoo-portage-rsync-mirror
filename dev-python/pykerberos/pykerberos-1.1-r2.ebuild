# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykerberos/pykerberos-1.1-r2.ebuild,v 1.3 2014/03/03 23:47:16 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_P="PyKerberos-${PV}"

DESCRIPTION="A high-level Python wrapper for Kerberos/GSSAPI operations"
HOMEPAGE="http://trac.calendarserver.org/"
SRC_URI="http://dev.gentoo.org/~maksbotan/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-crypt/mit-krb5"
RDEPEND="${DEPEND}"

# Pull from SVN
# svn export
# http://svn.calendarserver.org/repository/calendarserver/PyKerberos/tags/release/PyKerberos-1.1/
# python-kerberos-1.1
# tar czf python-kerberos-%{version}.tar.gz python-kerberos-%{version}

python_prepare_all() {
	local PATCHES=(
		# Needed for freeipa, http://trac.calendarserver.org/ticket/311
		"${FILESDIR}"/PyKerberos-delegation.patch
	)

	distutils-r1_python_prepare_all
}
