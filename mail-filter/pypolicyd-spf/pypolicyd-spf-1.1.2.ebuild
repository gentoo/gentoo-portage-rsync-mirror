# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/pypolicyd-spf/pypolicyd-spf-1.1.2.ebuild,v 1.3 2014/12/28 18:40:36 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 versionator

DESCRIPTION="Python based policy daemon for Postfix SPF checking"
HOMEPAGE="https://launchpad.net/pypolicyd-spf"
SRC_URI="http://launchpad.net/pypolicyd-spf/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyspf[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/authres"
