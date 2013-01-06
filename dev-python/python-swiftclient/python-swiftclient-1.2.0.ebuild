# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-swiftclient/python-swiftclient-1.2.0.ebuild,v 1.1 2013/01/02 19:52:08 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Python bindings to the OpenStack Object Storage API"
HOMEPAGE="http://docs.openstack.org/developer/python-swiftclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/simplejson"
RDEPEND="${DEPEND}"
