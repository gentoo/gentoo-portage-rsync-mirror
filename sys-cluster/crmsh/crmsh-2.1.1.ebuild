# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/crmsh/crmsh-2.1.1.ebuild,v 1.1 2014/12/02 14:40:59 ultrabug Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

AUTOTOOLS_AUTORECONF=true
KEYWORDS=""
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="git://github.com/crmsh/crmsh"
	inherit git-2
	S="${WORKDIR}/${PN}-${MY_TREE}"
else
	SRC_URI="https://github.com/crmsh/crmsh/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~hppa ~x86"
fi

inherit autotools-utils python-r1

DESCRIPTION="Pacemaker command line interface for management and configuration"
HOMEPAGE="http://crmsh.github.io/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	>=sys-cluster/pacemaker-1.1.8"
RDEPEND="${DEPEND}
	dev-python/lxml[${PYTHON_USEDEP}]"

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
