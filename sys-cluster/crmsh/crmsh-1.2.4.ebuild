# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-1.2.4.ebuild,v 1.2 2013/10/24 12:32:45 xarthisius Exp $

EAPI=4

inherit autotools-utils

MY_TREE="51379136d692"

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
RDEPEND="${DEPEND}
	dev-python/lxml"

S="${WORKDIR}/${PN}-${MY_TREE}"

src_prepare() {
	sed -e 's@CRM_CACHE_DIR=${localstatedir}/cache/crm@CRM_CACHE_DIR=${localstatedir}/crmsh@g' \
		-i configure.ac || die
	eautoreconf
}
