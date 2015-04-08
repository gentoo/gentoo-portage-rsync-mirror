# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sudsds/sudsds-1.0.1-r1.ebuild,v 1.5 2013/09/05 18:46:48 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Lightweight SOAP client - Czech NIC labs fork"
HOMEPAGE="https://labs.nic.cz/page/969/"
SRC_URI="http://www.nic.cz/public_media/datove_schranky/releases/src/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
