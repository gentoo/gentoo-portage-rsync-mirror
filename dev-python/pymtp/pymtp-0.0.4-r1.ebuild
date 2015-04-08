# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymtp/pymtp-0.0.4-r1.ebuild,v 1.5 2012/09/17 20:26:11 blueness Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils eutils

PATCH_LEVEL=4

DESCRIPTION="LibMTP bindings for Python"
HOMEPAGE="http://packages.debian.org/libmtp http://libmtp.sourceforge.net/ http://pypi.python.org/pypi/PyMTP"
DEB_URI="mirror://debian/pool/main/${PN:0:1}/${PN}"
SRC_URI="${DEB_URI}/${PN}_${PV}.orig.tar.gz
	${DEB_URI}/${PN}_${PV}-${PATCH_LEVEL}.debian.tar.gz"

LICENSE=GPL-3
SLOT=0
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/libmtp-1.1.0"
DEPEND=${RDEPEND}

PYTHON_MODNAME=pymtp.py

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=diff epatch "${WORKDIR}"/debian/patches
}
