# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tracing/tracing-0.6.ebuild,v 1.1 2012/06/15 10:17:56 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"

inherit distutils python

DESCRIPTION="Debug log/trace messages"
HOMEPAGE="http://liw.fi/tracing/"
SRC_URI="http://code.liw.fi/debian/pool/main/p/python-${PN}/python-${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
