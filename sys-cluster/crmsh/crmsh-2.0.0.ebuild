# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-2.0.0.ebuild,v 1.2 2014/06/25 05:56:40 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

AUTOTOOLS_AUTORECONF=true

EGIT_REPO_URI="git://github.com/crmsh/crmsh"
if [[ ${PV} == *9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	#KEYWORDS="~amd64 ~hppa ~x86"
	# QA: No keywords for ebuilds that fetch from VCS
	KEYWORDS=""
fi

inherit autotools-utils git-2 python-r1

DESCRIPTION="Pacemaker command line interface for management and configuration"
HOMEPAGE="http://crmsh.github.io/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=sys-cluster/pacemaker-1.1.8"
RDEPEND="${DEPEND}
	dev-python/lxml[${PYTHON_USEDEP}]"

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
