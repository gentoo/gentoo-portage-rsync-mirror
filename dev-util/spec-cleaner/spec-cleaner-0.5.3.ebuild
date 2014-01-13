# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spec-cleaner/spec-cleaner-0.5.3.ebuild,v 1.1 2014/01/13 13:17:33 scarabeus Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
EGIT_REPO_URI="https://github.com/openSUSE/spec-cleaner.git"
inherit python-single-r1 multilib
[[ ${PV} == 9999 ]] && inherit git-r3

DESCRIPTION="SUSE spec file cleaner and formatter"
HOMEPAGE="https://github.com/openSUSE/spec-cleaner"
[[ ${PV} != 9999 ]] && SRC_URI="https://github.com/openSUSE/${PN}/archive/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
[[ ${PV} != 9999 ]] && \
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"

[[ ${PV} != 9999 ]] && S="${WORKDIR}/${PN}-${P}"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${D}" install \
		LIBEXECDIR=/usr/libexec/ \
		LIBDIR=/usr/$(get_libdir) \
		SITEDIR=$(python_get_sitedir)

	python_fix_shebang "${D}"
}

src_test() {
	emake check
}
