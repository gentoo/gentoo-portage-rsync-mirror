# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-discover-runner/django-discover-runner-1.0.ebuild,v 1.1 2013/06/19 07:56:29 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A Django test runner based on unittest2's test discovery"
HOMEPAGE="https://github.com/jezdez/django-discover-runner
	https://pypi.python.org/pypi/django-discover-runner"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/django[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
