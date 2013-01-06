# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmdtest/cmdtest-0.5.ebuild,v 1.1 2012/10/07 00:35:56 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"

inherit distutils python

DESCRIPTION="black box tests Unix command line tools"
HOMEPAGE="http://liw.fi/cmdtest/"
SRC_URI="http://code.liw.fi/debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/cliapp
	dev-python/ttystatus
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
