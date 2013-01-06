# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/pypolicyd-spf/pypolicyd-spf-0.8.1.ebuild,v 1.3 2011/04/09 21:21:11 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils versionator

DESCRIPTION="Python based policy daemon for Postfix SPF checking"
HOMEPAGE="https://launchpad.net/pypolicyd-spf"
SRC_URI="http://launchpad.net/pypolicyd-spf/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-python/pyspf-2.0.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="policydspfsupp.py policydspfuser.py"
