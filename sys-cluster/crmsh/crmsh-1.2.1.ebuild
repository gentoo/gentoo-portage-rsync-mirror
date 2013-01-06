# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-1.2.1.ebuild,v 1.2 2012/11/14 17:22:45 jer Exp $

EAPI=4

inherit autotools-utils

MY_TREE="b6bb311c7bd3"

DESCRIPTION="Pacemaker command line interface for management and configuration"
HOMEPAGE="https://savannah.nongnu.org/projects/crmsh/"
SRC_URI="http://hg.savannah.gnu.org/hgweb/crmsh/archive/${MY_TREE}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="
	>=sys-cluster/pacemaker-1.1.8
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_TREE}"

src_prepare() {
	sed -e 's@CRM_CACHE_DIR=${localstatedir}/cache/crm@CRM_CACHE_DIR=${localstatedir}/crmsh@g' \
		-i configure.ac || die
	eautoreconf
}
