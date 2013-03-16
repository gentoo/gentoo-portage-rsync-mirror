# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/robotframework/robotframework-2.7.7.ebuild,v 1.1 2013/03/16 18:37:32 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A generic test automation framework for acceptance testing and acceptance test-driven development"
HOMEPAGE="http://code.google.com/p/robotframework/"
SRC_URI="http://robotframework.googlecode.com/files/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
