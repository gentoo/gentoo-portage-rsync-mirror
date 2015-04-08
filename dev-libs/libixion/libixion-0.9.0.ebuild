# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libixion/libixion-0.9.0.ebuild,v 1.2 2015/04/06 11:42:50 dilfridge Exp $

EAPI=5

EGIT_REPO_URI="https://gitlab.com/ixion/ixion.git"

PYTHON_COMPAT=( python2_7 )

[[ ${PV} == 9999 ]] && GITECLASS="git-r3 autotools"
inherit eutils python-single-r1 ${GITECLASS}
unset GITECLASS

DESCRIPTION="General purpose formula parser & interpreter"
HOMEPAGE="https://gitlab.com/ixion/ixion"
[[ ${PV} == 9999 ]] || SRC_URI="http://kohei.us/files/ixion/src/${P}.tar.xz"

LICENSE="MIT"
SLOT="0/0.10"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~ppc ~x86"

IUSE="static-libs"

RDEPEND="${PYTHON_DEPS}
	dev-libs/boost:=
"
DEPEND="${RDEPEND}
	>=dev-util/mdds-0.12.0:=
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default

	prune_libtool_files --all
}
