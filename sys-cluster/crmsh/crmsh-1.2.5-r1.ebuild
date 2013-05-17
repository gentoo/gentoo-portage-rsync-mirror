# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-1.2.5-r1.ebuild,v 1.1 2013/05/17 10:13:44 ultrabug Exp $

EAPI=4

inherit autotools-utils

MY_TREE="ef3f08547688"

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
