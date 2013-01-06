# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykerberos/pykerberos-1.1-r1.ebuild,v 1.2 2012/02/21 07:57:16 patrick Exp $

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_P="PyKerberos-${PV}"

DESCRIPTION="A high-level Python wrapper for Kerberos/GSSAPI operations"
HOMEPAGE="http://trac.calendarserver.org/"
SRC_URI="http://dev.gentoo.org/~maksbotan/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-crypt/mit-krb5"
RDEPEND="${DEPEND}"

# Pull from SVN
# svn export
# http://svn.calendarserver.org/repository/calendarserver/PyKerberos/tags/release/PyKerberos-1.1/
# python-kerberos-1.1
# tar czf python-kerberos-%{version}.tar.gz python-kerberos-%{version}

src_prepare(){
	#Needed for freeipa, http://trac.calendarserver.org/ticket/311
	epatch "${FILESDIR}"/PyKerberos-delegation.patch
	default
}
