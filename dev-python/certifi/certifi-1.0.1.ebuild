# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/certifi/certifi-1.0.1.ebuild,v 1.1 2014/04/08 10:39:25 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy2_0 pypy )

inherit distutils-r1

DESCRIPTION="SSL root certificate bundle"
HOMEPAGE="http://python-requests.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="app-misc/ca-certificates"

python_install() {
	distutils-r1_python_install
	# Overwrite bundled certificates with a symlink.
	dosym "${EPREFIX}/etc/ssl/certs/ca-certificates.crt" "${sitedir#${EPREFIX}}/certifi/cacert.pem"
}
