# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dicttoxml/dicttoxml-1.5.6.ebuild,v 1.1 2014/11/13 03:42:39 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python{2_7,3_3,3_4})

inherit distutils-r1

DESCRIPTION="Converts a Python dictionary or other native data type into a valid XML string"
HOMEPAGE="https://github.com/quandyfactory/dicttoxml"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
