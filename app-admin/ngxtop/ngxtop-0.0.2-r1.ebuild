# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ngxtop/ngxtop-0.0.2-r1.ebuild,v 1.3 2014/06/05 06:40:23 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="real-time metrics for nginx server (and others)"
HOMEPAGE="https://github.com/lebinh/ngxtop"
SRC_URI="https://github.com/lebinh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}"/${P}-py3.patch )
