# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-magic/python-magic-0.4.3.ebuild,v 1.3 2013/09/05 18:46:42 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Access the libmagic file type identification library"
HOMEPAGE="https://github.com/ahupp/python-magic"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/file"
RDEPEND="${DEPEND}"
