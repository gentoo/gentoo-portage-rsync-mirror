# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-1.2.6.ebuild,v 1.1 2013/10/17 12:21:11 ultrabug Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils python-r1

MY_TREE="ad8279d42fd4"

DESCRIPTION="Pacemaker command line interface for management and configuration"
HOMEPAGE="https://savannah.nongnu.org/projects/crmsh/"
SRC_URI="http://hg.savannah.gnu.org/hgweb/crmsh/archive/${MY_TREE}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=sys-cluster/pacemaker-1.1.8"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_TREE}"

src_prepare() {
	sed \
		-e 's@CRM_CACHE_DIR=${localstatedir}/cache/crm@CRM_CACHE_DIR=${localstatedir}/crmsh@g' \
		-i configure.ac || die
	autotools-utils_src_prepare
}

src_configure() {
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_install() {
	python_foreach_impl autotools-utils_src_install
	python_replicate_script "${ED}"/usr/sbin/crm
}
